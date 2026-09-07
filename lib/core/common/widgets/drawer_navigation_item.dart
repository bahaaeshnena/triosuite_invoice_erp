import 'package:flutter/material.dart';

class DrawerNavigationItem extends StatelessWidget {
  const DrawerNavigationItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.isDestructive = false,
    this.trailing,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isDestructive;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final foreground = isDestructive
        ? colors.error
        : isSelected
        ? colors.primary
        : colors.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: isSelected ? colors.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: foreground, size: 22),
                const SizedBox(width: 13),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: foreground,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
                if (trailing != null)
                  trailing!
                else if (isSelected)
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
