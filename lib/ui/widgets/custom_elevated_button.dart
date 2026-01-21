import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final bool safe;
  final String text;
  final double width;
  final double height;
  final Color? borderColor;
  final double borderRadius;
  final String? leadingImage;
  final IconData? leadingIcon;
  final Color backgroundColor;
  final Color foregroundColor;
  final String? trailingImage;
  final IconData? trailingIcon;
  final GestureTapCallback? onTap;

  const CustomElevatedButton({
    super.key,
    this.onTap,
    this.leadingIcon,
    this.borderColor,
    this.safe = true,
    this.leadingImage,
    this.trailingIcon,
    required this.text,
    this.trailingImage,
    required this.height,
    this.borderRadius = 0,
    required this.backgroundColor,
    required this.foregroundColor,
    this.width = double.maxFinite,
  });

  @override
  Widget build(BuildContext context) => _buildSafeWrapper();

  Widget _buildSafeWrapper() =>
      SafeArea(bottom: safe, child: _buildButtonWrapper());

  Widget _buildButtonWrapper() =>
      SizedBox(height: 50, width: width, child: _buildButton());

  Widget _buildButton() => OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: borderColor == null
              ? BorderSide.none
              : BorderSide(color: borderColor!),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
        child: _buildRow(),
      );

  Widget _buildRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildRowChildren(),
      );

  List<Widget> _buildRowChildren() => [
        if (leadingIcon != null) _buildIcon(leadingIcon!),
        if (leadingImage != null) _buildImage(leadingImage!),
        if (leadingIcon != null || leadingImage != null)
          const SizedBox(width: 5),
        leadingIcon == null &&
                trailingIcon == null &&
                leadingImage == null &&
                trailingImage == null
            ? _buildExpandedText()
            : _buildText(),
        if (trailingIcon != null || trailingImage != null)
          const SizedBox(width: 5),
        if (trailingIcon != null) _buildIcon(trailingIcon!),
        if (trailingImage != null) _buildImage(trailingImage!),
      ];

  Widget _buildIcon(IconData icon) => Icon(
        icon,
        color: foregroundColor,
      );

  Widget _buildImage(String image) => Image.asset(image);

  Widget _buildExpandedText() => Expanded(
        child: _buildText(),
      );

  Widget _buildText() => Text(
        text,
        maxLines: 1,
        softWrap: false,
        textAlign: TextAlign.center,
        style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold),
      );
}
