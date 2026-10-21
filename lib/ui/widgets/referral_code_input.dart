import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import '../common/translations/locale_keys.g.dart';

class ReferralCodeInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool isVerifying;
  final bool isValid;
  final String? influencerName;
  final String? errorMessage;
  final Function(String code) onCodeChanged;
  final VoidCallback onClear;

  const ReferralCodeInputWidget({
    super.key,
    required this.controller,
    required this.isVerifying,
    required this.isValid,
    this.influencerName,
    this.errorMessage,
    required this.onCodeChanged,
    required this.onClear,
  });

  @override
  State<ReferralCodeInputWidget> createState() =>
      _ReferralCodeInputWidgetState();
}

class _ReferralCodeInputWidgetState extends State<ReferralCodeInputWidget> {
  bool _isExpanded = false;
  String? _clipboardCode;

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.trim().isNotEmpty) {
      _isExpanded = true;
    }
    _checkClipboard();
  }

  Future<void> _checkClipboard() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final text = clipboardData?.text?.trim().toUpperCase();
      if (text != null &&
          text.isNotEmpty &&
          text.length >= 3 &&
          text.length <= 30 &&
          !text.contains(' ') &&
          text != widget.controller.text.trim().toUpperCase()) {
        if (mounted) {
          setState(() {
            _clipboardCode = text;
          });
        }
      }
    } catch (_) {
      // Clipboard access might be restricted or empty
    }
  }

  void _applyClipboardCode() {
    if (_clipboardCode == null) return;
    widget.controller.text = _clipboardCode!;
    widget.onCodeChanged(_clipboardCode!);
    setState(() {
      _isExpanded = true;
      _clipboardCode = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // If not expanded and field is empty, show a neat toggle button
    if (!_isExpanded && widget.controller.text.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_clipboardCode != null) _buildClipboardBanner(),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              setState(() {
                _isExpanded = true;
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: kcPrimaryColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: kcPrimaryColor.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.card_giftcard_rounded,
                    size: 20,
                    color: kcPrimaryColor,
                  ),
                  horizontalSpaceSmall,
                  Expanded(
                    child: Text(
                      LocaleKeys.have_referral_code.tr(),
                      style: style14P400.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.add_circle_outline_rounded,
                    size: 20,
                    color: kcPrimaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_clipboardCode != null && widget.controller.text.isEmpty)
          _buildClipboardBanner(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.card_giftcard_rounded,
                  size: 16,
                  color: kcPrimaryColor,
                ),
                horizontalSpaceSmall,
                Text(
                  LocaleKeys.referral_code.tr(),
                  style: style14DG600.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            if (widget.controller.text.isEmpty)
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    LocaleKeys.hide_referral_code.tr(),
                    style: style12RP600,
                  ),
                ),
              ),
          ],
        ),
        verticalSpaceSmall,
        TextFormField(
          controller: widget.controller,
          textCapitalization: TextCapitalization.characters,
          onChanged: widget.onCodeChanged,
          decoration: InputDecoration(
            hintText: LocaleKeys.enter_referral_code.tr(),
            filled: true,
            fillColor: widget.isValid
                ? kcDeepGreen.withValues(alpha: 0.05)
                : kcPrimaryColor.withValues(alpha: 0.04),
            border: universalBorder,
            errorBorder: universalErrorBorder,
            enabledBorder: widget.isValid
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: kcDeepGreen, width: 1.5),
                  )
                : universalEnabledBorder,
            focusedBorder: widget.isValid
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: kcDeepGreen, width: 2),
                  )
                : universalFocusedBorder,
            suffixIcon: _buildSuffixIcon(),
          ),
        ),
        if (widget.isValid && widget.influencerName != null) ...[
          verticalSpaceTiny,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: kcDeepGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: kcDeepGreen.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.verified,
                  size: 14,
                  color: kcDeepGreen,
                ),
                horizontalSpaceSmall,
                Text(
                  LocaleKeys.referred_by.tr(
                    args: [widget.influencerName ?? ''],
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    color: kcDeepGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
        if (widget.errorMessage != null && !widget.isValid) ...[
          verticalSpaceTiny,
          Text(
            widget.errorMessage!,
            style: style12R700,
          ),
        ],
      ],
    );
  }

  Widget _buildClipboardBanner() => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          onTap: _applyClipboardCode,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: kcPrimaryColorLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.content_paste_go,
                  size: 16,
                  color: kcPrimaryColor,
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: Text(
                    LocaleKeys.apply_clipboard_code.tr(
                      args: [_clipboardCode ?? ''],
                    ),
                    style: style12RP600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildSuffixIcon() {
    if (widget.isVerifying) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: SizedBox(
          width: 18,
          height: 18,
          child: CupertinoActivityIndicator(radius: 8),
        ),
      );
    }
    if (widget.isValid) {
      return const Icon(
        Icons.check_circle,
        color: kcDeepGreen,
      );
    }
    if (widget.controller.text.isNotEmpty) {
      return IconButton(
        icon: const Icon(Icons.clear, size: 18, color: kcMediumGrey),
        onPressed: widget.onClear,
      );
    }
    return const SizedBox.shrink();
  }
}
