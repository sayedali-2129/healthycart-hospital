import 'package:flutter/material.dart';

import 'package:healthycart/core/custom/app_bar/sliver_appbar.dart';
import 'package:healthycart/core/custom/button/search_field_button.dart';

import 'package:healthycart/utils/constants/colors/colors.dart';

class UserLocationSearchWidget extends StatefulWidget {
  const UserLocationSearchWidget({
    super.key,
  });

  @override
  State<UserLocationSearchWidget> createState() =>
      _UserLocationSearchWidgetState();
}

class _UserLocationSearchWidgetState extends State<UserLocationSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverCustomAppbar(
          title: 'Choose Location',
          onBackTap: () {
            Navigator.pop(context);
          }),
      SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverToBoxAdapter(
          child: SearchTextFieldButton(
            text: 'Search city,area or place',
            controller: TextEditingController(),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.my_location_rounded,
                    color: BColors.darkblue,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose current location.",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: BColors.darkblue,
                                  ),
                        ),
                        Text(
                          "Tap to get the current location",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Divider()
            ],
          ),
        ),
      ),
      SliverList.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: ListTile(
                title: Text(
                  "suggestion Address",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                trailing: const Icon(
                  Icons.north_west_outlined,
                  color: BColors.buttonDarkColor,
                  size: 20,
                ),
                onTap: () {},
              ),
            ),
          );
        },
      ),
    ]));
  }
}
