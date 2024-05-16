import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/app_bar/sliver_appbar.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';

class DoctorProfileList extends StatelessWidget {
  const DoctorProfileList({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: CustomScrollView(
      slivers: [
         SliverCustomAppbar(
          title: 'Doctor List',
          onBackTap: (){
            Navigator.pop(context);
          },
        ),
        SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      PhysicalModel(
                        color: BColors.white,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  height: 96,
                                  width: 96,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                            BImage.logo,
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 16, left: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 232,
                                        child: Row(
                                          children: [
                                            const Gap(8),
                                            Expanded(
                                              child: Text(
                                                'Dr Meenakshi Kallara, MBBS,PHD',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(8),
                                      SizedBox(
                                        width: 232,
                                        child: Row(
                                          children: [
                                            const Gap(8),
                                            Expanded(
                                              child: Text(
                                                'Neurologist',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w300),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(4),
                                      SizedBox(
                                        width: 232,
                                        child: Row(
                                          children: [
                                            const Gap(8),
                                            Expanded(
                                              child: Text(
                                                'Time 11.00AM - 2.30PM',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        color: Colors.green),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(8)
                    ],
                  );
                }))
      ],
    ));
  }
}
