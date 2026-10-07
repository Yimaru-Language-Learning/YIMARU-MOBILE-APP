import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/app_colors.dart';

class ManualPaymentDialog extends StatefulWidget {
  const ManualPaymentDialog({super.key, this.paymentUncertain = false});

  final bool paymentUncertain;
  static const accountNumber = '1000322464669';
  static const accountHolder = 'Endrias Israel Mulugeta';
  static const telegramUrl = 'https://t.me/yimarusup';

  @override
  State<ManualPaymentDialog> createState() => _ManualPaymentDialogState();
}

class _ManualPaymentDialogState extends State<ManualPaymentDialog> {
  bool _openingTelegram = false;
  bool _launchFailed = false;

  Future<void> _openTelegram() async {
    setState(() {
      _openingTelegram = true;
      _launchFailed = false;
    });
    bool opened = false;
    try {
      opened = await launchUrl(Uri.parse(ManualPaymentDialog.telegramUrl),
          mode: LaunchMode.externalApplication);
    } catch (_) {
      opened = false;
    }
    if (!mounted) return;
    setState(() {
      _openingTelegram = false;
      _launchFailed = !opened;
    });
  }

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: kcWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    tooltip: 'manual_payment_close'.tr(),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ),
                const CircleAvatar(
                  radius: 34,
                  backgroundColor: Color(0xFFF5EAFB),
                  child: Icon(Icons.account_balance, size: 44, color: kcIndigo),
                ),
                const SizedBox(height: 16),
                Text(
                  (widget.paymentUncertain
                          ? 'manual_payment_uncertain_title'
                          : 'manual_payment_title')
                      .tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  (widget.paymentUncertain
                          ? 'manual_payment_uncertain_description'
                          : 'manual_payment_description')
                      .tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, color: kcMediumGrey),
                ),
                const SizedBox(height: 16),
                if (!widget.paymentUncertain) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5EAFB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      _detail('manual_payment_account_number',
                          ManualPaymentDialog.accountNumber),
                      const SizedBox(height: 10),
                      _detail('manual_payment_account_holder',
                          ManualPaymentDialog.accountHolder),
                      const SizedBox(height: 10),
                      _detail('manual_payment_bank',
                          'manual_payment_bank_name'.tr()),
                    ]),
                  ),
                  const SizedBox(height: 12),
                  Text('manual_payment_confirmation'.tr(),
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 12, color: kcMediumGrey)),
                  const SizedBox(height: 16),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF299AD6),
                      foregroundColor: kcWhite,
                      minimumSize: const Size(0, 44),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _openingTelegram ? null : _openTelegram,
                    icon: _openingTelegram
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.send, size: 20),
                    label: Text('manual_payment_open_telegram'.tr()),
                  ),
                ),
                if (_launchFailed) ...[
                  const SizedBox(height: 8),
                  Text('manual_payment_telegram_error'.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: kcRed, fontSize: 12)),
                  const SelectableText('@yimarusup'),
                  TextButton(
                    onPressed: () async {
                      await Clipboard.setData(const ClipboardData(
                          text: ManualPaymentDialog.telegramUrl));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('manual_payment_link_copied'.tr())));
                      }
                    },
                    child: Text('manual_payment_copy_link'.tr()),
                  ),
                ],
              ]),
            ),
          ),
        ),
      );

  Widget _detail(String label, String value) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Text(label.tr(),
                  style: const TextStyle(fontSize: 12, color: kcMediumGrey))),
          const SizedBox(width: 8),
          Expanded(
              flex: 3,
              child: SelectableText(value,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600))),
        ],
      );
}
