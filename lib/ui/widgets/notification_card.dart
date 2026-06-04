import 'package:flutter/material.dart';
import 'package:yimaru_app/models/in_app_notification.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class NotificationCard extends StatelessWidget {
  final InAppNotification notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) => _buildContainer();



  Widget _buildContainer() => Container(
    height: 100,
    width: double.maxFinite,
    margin: const EdgeInsets.symmetric(horizontal: 15),
    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: (notification.isRead ?? false)
              ? kcGreen.withOpacity(0.05)
              : kcPrimaryColor.withOpacity(0.05),
          border: Border.all(
            color: (notification.isRead ?? false)
                ? kcGreen.withOpacity(0.1)
                : kcPrimaryColor.withOpacity(0.1),
          ),
        ),
        child: _buildRow(),
      );

  Widget _buildRow() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildRowChildren(),
      );

  List<Widget> _buildRowChildren()=> [
    _buildIcon(),
    horizontalSpaceSmall,
    _buildColumnWrapper()
  ];

  Widget _buildIcon() => const Icon(
        Icons.notifications_none,
        size: 35,
        color: kcMediumGrey,
      );

  Widget _buildColumnWrapper()=> Expanded(child: _buildColumn());

  Widget _buildColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() =>
      [ _buildTitle(), _buildSubtitle()];

  Widget _buildTitle() => Text(
        notification.payload?.headline ?? '',
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        notification.payload?.message ?? '',
        maxLines: 2,
        style: style14MG400,
      );
}
