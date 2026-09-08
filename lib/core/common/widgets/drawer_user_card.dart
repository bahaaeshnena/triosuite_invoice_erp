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
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            colors.primaryContainer,
            colors.secondaryContainer.withValues(alpha: .78),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.primary.withValues(alpha: .14)),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: .08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color: colors.onPrimary.withValues(alpha: .7),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: .22),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              avatarLetter,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: colors.onPrimaryContainer,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      user == null ? S.of(context).guest : '@${user.username}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onPrimaryContainer.withValues(alpha: .72),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.verified_user_rounded, size: 20, color: colors.primary),
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
