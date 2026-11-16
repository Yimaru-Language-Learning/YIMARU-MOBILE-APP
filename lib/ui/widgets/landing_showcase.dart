import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingShowcase extends StatelessWidget {
  const LandingShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 420,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Background concentric circles
          Container(
            width: 290,
            height: 290,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFE29A),
            ),
          ),
          Container(
            width: 208,
            height: 208,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFDB80),
            ),
          ),

          // Background Sparkles
          const Positioned(
            left: 20,
            top: 155,
            child: _SparkleStar(size: 16),
          ),
          const Positioned(
            right: 24,
            top: 135,
            child: _SparkleStar(size: 16),
          ),
          const Positioned(
            left: 80,
            top: 75,
            child: _SparkleStar(size: 12),
          ),

          // Central Mascot Yimi
          Positioned(
            top: 110,
            child: SvgPicture.asset(
              'assets/images/Yimaru-Icons-and-Illustrations/02-Illustrations/01-landing-page/1.1-landing-page-02.svg',
              width: 185,
              height: 215,
              fit: BoxFit.contain,
            ),
          ),

          // 1. Top Center Star Badge
          Positioned(
            top: 16,
            child: _buildCircleBadge(
              size: 40,
              color: const Color(0xFFFF7043), // Coral
              child: SvgPicture.asset(
                'assets/images/Yimaru-Icons-and-Illustrations/01-Icons/svg/status-and-progress/star.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // 2. Top-Left Sticker: "ሰላም"
          Positioned(
            left: 24,
            top: 26,
            child: _buildDialogueSticker(
              text: 'ሰላም',
              color: const Color(0xFF8E2483), // Plum
              angle: -0.14,
            ),
          ),

          // 3. Top-Right Sticker: "Hello!"
          Positioned(
            right: 24,
            top: 26,
            child: _buildDialogueSticker(
              text: 'Hello!',
              color: const Color(0xFF8E2483), // Plum
              angle: 0.10,
            ),
          ),

          // 4. Middle-Left Sticker: "እንደምን አደሩ"
          Positioned(
            left: 10,
            top: 102,
            child: _buildDialogueSticker(
              text: 'እንደምን አደሩ',
              color: const Color(0xFFFF7043), // Coral
              angle: -0.09,
            ),
          ),

          // 5. Middle-Right Sticker: "Good morning"
          Positioned(
            right: 10,
            top: 102,
            child: _buildDialogueSticker(
              text: 'Good morning',
              color: const Color(0xFFFF7043), // Coral
              angle: 0.09,
            ),
          ),

          // 6. Left Mic Badge
          Positioned(
            left: 32,
            top: 180,
            child: _buildCircleBadge(
              size: 44,
              color: const Color(0xFF5B7FE8), // Blue
              child: SvgPicture.asset(
                'assets/images/Yimaru-Icons-and-Illustrations/01-Icons/svg/audio-and-media/mic.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // 7. Right Headphones Badge
          Positioned(
            right: 32,
            top: 180,
            child: _buildCircleBadge(
              size: 44,
              color: const Color(0xFF8E2483), // Plum
              child: SvgPicture.asset(
                'assets/images/Yimaru-Icons-and-Illustrations/01-Icons/svg/audio-and-media/headphones.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // 8. Bottom-Left Sticker: "አመሰግናለሁ"
          Positioned(
            left: 16,
            top: 262,
            child: _buildDialogueSticker(
              text: 'አመሰግናለሁ',
              color: const Color(0xFF2FB67C), // Mint / Teal
              angle: -0.07,
            ),
          ),

          // 9. Bottom-Right Sticker: "Thank you"
          Positioned(
            right: 16,
            top: 262,
            child: _buildDialogueSticker(
              text: 'Thank you',
              color: const Color(0xFF2FB67C), // Mint / Teal
              angle: 0.07,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogueSticker({
    required String text,
    required Color color,
    required double angle,
  }) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Aeonik',
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCircleBadge({
    required double size,
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class _SparkleStar extends StatelessWidget {
  final double size;

  const _SparkleStar({
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.auto_awesome,
      size: size,
      color: const Color(0xFF8E2483),
    );
  }
}

