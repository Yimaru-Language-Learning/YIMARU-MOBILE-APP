import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/app_colors.dart';
import '../common/translations/locale_keys.g.dart';

class PremiumPhoneDialog extends StatefulWidget {
  const PremiumPhoneDialog(
      {super.key, required this.savePhone, required this.isCurrent});
  final Future<bool> Function(String) savePhone;
  final bool Function() isCurrent;

  @override
  State<PremiumPhoneDialog> createState() => _PremiumPhoneDialogState();
}

class _PremiumPhoneDialogState extends State<PremiumPhoneDialog> {
  final _phone = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _saving = false;
  bool _failed = false;

  Future<void> _save() async {
    if (_saving || !_form.currentState!.validate() || !widget.isCurrent()) {
      return;
    }
    setState(() {
      _saving = true;
      _failed = false;
    });
    try {
      final saved = await widget.savePhone('251${_phone.text.trim()}');
      if (!mounted) return;
      if (saved && widget.isCurrent()) {
        Navigator.pop(context, true);
      } else {
        setState(() => _failed = true);
      }
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _phone.dispose();
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
                      Text(LocaleKeys.complete_profile.tr()),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phone,
                        enabled: !_saving,
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
                      if (_failed)
                        Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text('checkout_phone_failed'.tr(),
                                style: const TextStyle(color: kcRed))),
                    ],
                  ))),
          actions: [
            TextButton(
                onPressed: _saving ? null : () => Navigator.pop(context, false),
                child: Text(LocaleKeys.cancel.tr())),
            TextButton(
                onPressed: _saving ? null : _save,
                child: Text(
                    (_saving ? LocaleKeys.please_wait : LocaleKeys.cont).tr())),
          ],
        ),
      );
}
