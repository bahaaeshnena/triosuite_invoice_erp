import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_colors.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/widgets/decorative_circle.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ColoredBox(
      color: isDark ? AppColors.darkBackground : const Color(0xFFF5F7FB),
      child: Align(
        alignment: Alignment.topCenter,
        child: ClipPath(
          clipper: const _SoftCurveClipper(),
          child: Container(
            height: 315,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0B1F4B), Color(0xFF1957C7)],
              ),
            ),
            child: const Stack(
              children: [
                Positioned(
                  top: -54,
                  right: -35,
                  child: DecorativeCircle(size: 172, opacity: .07),
                ),
                Positioned(
                  top: 126,
                  left: -42,
                  child: DecorativeCircle(size: 108, opacity: .06),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SoftCurveClipper extends CustomClipper<Path> {
  const _SoftCurveClipper();

  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height - 42)
      ..quadraticBezierTo(
        size.width * .48,
        size.height + 8,
        size.width,
        size.height - 54,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
