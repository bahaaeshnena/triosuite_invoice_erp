import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.trailingIcon,
    this.width = double.infinity,
    this.height = 50,
    this.style,
    this.textStyle,
    this.loadingSemanticLabel,
    this.autofocus = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final Widget? trailingIcon;
  final double? width;
  final double height;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final String? loadingSemanticLabel;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: effectiveOnPressed,
        autofocus: autofocus,
        style: style,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: isLoading
              ? Semantics(
                  key: const ValueKey('button-loader'),
                  label: loadingSemanticLabel,
                  child: SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                )
              : Row(
                  key: const ValueKey('button-content'),
                  mainAxisSize: width == double.infinity
                      ? MainAxisSize.max
                      : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      IconTheme.merge(
                        data: const IconThemeData(size: 20),
                        child: icon!,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle,
                      ),
                    ),
                    if (trailingIcon != null) ...[
                      const SizedBox(width: 8),
                      IconTheme.merge(
                        data: const IconThemeData(size: 20),
                        child: trailingIcon!,
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
