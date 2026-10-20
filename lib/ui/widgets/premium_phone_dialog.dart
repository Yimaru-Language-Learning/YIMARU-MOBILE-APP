import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import '../common/app_colors.dart';
import '../common/translations/locale_keys.g.dart';

class PremiumPhoneDialog extends StatefulWidget {
  const PremiumPhoneDialog(
      {super.key,
      this.initialPhone = '',
      this.useSavedPhone = false,
      required this.sendCode,
      required this.verifyPhone,
      required this.isCurrent});
  final String initialPhone;
  final bool useSavedPhone;
  final Future<void> Function(String) sendCode;
  final Future<bool> Function(String, String) verifyPhone;
  final bool Function() isCurrent;

  @override
  State<PremiumPhoneDialog> createState() => _PremiumPhoneDialogState();
}

class _PremiumPhoneDialogState extends State<PremiumPhoneDialog> {
  final _phone = TextEditingController();
  final _code = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _saving = false;
  String? _error;
  bool _sent = false;
  DateTime? _resendAt;
  bool get _unsupportedSavedPhone =>
      widget.useSavedPhone &&
      !RegExp(r'^251[79][0-9]{8}$').hasMatch(widget.initialPhone);

  String _errorKey(Object error, String fallback) {
    if (error is DioException) {
      final data = error.response?.data;
      if (error.response?.statusCode == 409 &&
          data is Map &&
          data['error'] == 'checkout_phone_changed') {
        return 'checkout_phone_reverify';
      }
      if (error.response?.statusCode == 429) {
        return 'checkout_otp_wait';
      }
    }
    return fallback;
  }

  @override
  void initState() {
    super.initState();
    final phone = widget.initialPhone;
    _phone.text = phone.startsWith('251') ? phone.substring(3) : '';
  }

  Future<void> _send({bool validate = true}) async {
    if (_saving ||
        _unsupportedSavedPhone ||
        (validate && !_form.currentState!.validate()) ||
        !widget.isCurrent()) {
      return;
    }
    if (_resendAt?.isAfter(DateTime.now()) ?? false) {
      setState(() => _error = 'checkout_otp_wait');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.sendCode('251${_phone.text.trim()}');
      if (mounted && widget.isCurrent()) {
        setState(() {
          _sent = true;
          _code.clear();
          _resendAt = DateTime.now().add(const Duration(seconds: 60));
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() => _error = _errorKey(error, 'checkout_otp_send_failed'));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _save() async {
    if (_saving || !_form.currentState!.validate() || !widget.isCurrent()) {
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final saved = await widget.verifyPhone(
          '251${_phone.text.trim()}', _code.text.trim());
      if (!mounted) return;
      if (saved && widget.isCurrent()) {
        Navigator.pop(context, true);
      } else {
        setState(() => _error = 'checkout_otp_invalid');
      }
    } catch (error) {
      if (mounted) {
        setState(() => _error = _errorKey(error, 'checkout_otp_invalid'));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _phone.dispose();
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: !_saving,
        child: AlertDialog(
          title: Text(LocaleKeys.profile_completion.tr()),
          content: SingleChildScrollView(
              child: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((widget.useSavedPhone
                              ? 'checkout_phone_on_file'
                              : LocaleKeys.complete_profile)
                          .tr()),
                      const SizedBox(height: 16),
                      if (_unsupportedSavedPhone) ...[
                        SelectableText(widget.initialPhone),
                        const SizedBox(height: 12),
                        Text('checkout_phone_saved_invalid'.tr(),
                            style: const TextStyle(color: kcRed)),
                      ] else
                        TextFormField(
                          controller: _phone,
                          readOnly: widget.useSavedPhone,
                          enabled: !_saving && !_sent,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(9)
                          ],
                          decoration: InputDecoration(
                              labelText: LocaleKeys.phone_number.tr(),
                              prefixText: '+251 '),
                          validator: (value) =>
                              RegExp(r'^[79][0-9]{8}$').hasMatch(value ?? '')
                                  ? null
                                  : 'checkout_phone_invalid'.tr(),
                        ),
                      if (_sent) ...[
                        const SizedBox(height: 12),
                        Text('checkout_otp_sent'.tr()),
                        TextFormField(
                          controller: _code,
                          enabled: !_saving,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6)
                          ],
                          decoration: InputDecoration(
                              labelText: 'checkout_otp_code'.tr()),
                          validator: (value) =>
                              RegExp(r'^[0-9]{6}$').hasMatch(value ?? '')
                                  ? null
                                  : 'checkout_otp_invalid'.tr(),
                        ),
                        if (!widget.useSavedPhone)
                          TextButton(
                              onPressed: _saving
                                  ? null
                                  : () {
                                      setState(() {
                                        _sent = false;
                                        _error = null;
                                      });
                                    },
                              child: Text('checkout_phone_change'.tr())),
                        TextButton(
                            onPressed: _saving
                                ? null
                                : () async {
                                    if (_resendAt?.isAfter(DateTime.now()) ??
                                        false) {
                                      setState(
                                          () => _error = 'checkout_otp_wait');
                                      return;
                                    }
                                    // Validate the phone only when requesting a replacement code.
                                    setState(() => _sent = false);
                                    await _send(validate: false);
                                  },
                            child: Text('checkout_otp_resend'.tr())),
                      ],
                      if (_error != null)
                        Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(_error!.tr(),
                                style: const TextStyle(color: kcRed))),
                    ],
                  ))),
          actions: [
            TextButton(
                onPressed: _saving ? null : () => Navigator.pop(context, false),
                child: Text(LocaleKeys.cancel.tr())),
            TextButton(
                onPressed: _saving || _unsupportedSavedPhone
                    ? null
                    : (_sent ? _save : _send),
                child: Text((_saving
                        ? LocaleKeys.please_wait
                        : (_sent ? 'checkout_otp_verify' : 'checkout_otp_send'))
                    .tr())),
          ],
        ),
      );
}
