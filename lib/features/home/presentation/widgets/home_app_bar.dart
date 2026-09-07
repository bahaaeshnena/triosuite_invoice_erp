import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      toolbarHeight: preferredSize.height,
      titleSpacing: 4,
      title: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.auto_awesome_mosaic_rounded,
              color: colors.onPrimary,
              size: 19,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            S.of(context).appName,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: S.of(context).settings,
          onPressed: () {},
          icon: Badge(
            smallSize: 7,
            backgroundColor: colors.error,
            child: const Icon(Icons.notifications_none_rounded),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
