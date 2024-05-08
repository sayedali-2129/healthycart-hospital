import 'package:flutter/material.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';

class SliverCustomAppbar extends StatelessWidget {
  const SliverCustomAppbar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: -6,
      pinned: true,
      forceElevated: true,
      toolbarHeight: 80,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: BColors.darkblue, fontWeight: FontWeight.w700)),
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        background: Container(
          decoration: BoxDecoration(
              color: BColors.mainlightColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
        ),
      ),
    );
  }
}