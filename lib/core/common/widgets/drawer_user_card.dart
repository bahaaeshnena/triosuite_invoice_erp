import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/core/common/helpers/get_user.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class DrawerUserCard extends StatelessWidget {
  const DrawerUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final user = getUser();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final preferredName = isArabic ? user?.fullNameAr : user?.fullNameEn;
    final alternativeName = isArabic ? user?.fullNameEn : user?.fullNameAr;
    final displayName = _firstNotEmpty([
      preferredName,
      alternativeName,
      user?.username,
      S.of(context).guest,
    ]);
    final avatarLetter = displayName.characters.first.toUpperCase();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: .65),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: colors.secondaryContainer,
            foregroundColor: colors.onSecondaryContainer,
            child: Text(
              avatarLetter,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  user == null ? S.of(context).guest : '@${user.username}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _firstNotEmpty(List<String?> values) {
    return values
        .firstWhere((value) => value?.trim().isNotEmpty ?? false)!
        .trim();
  }
}
