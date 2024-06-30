import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/app_bar/sliver_appbar.dart';
import 'package:healthycart/core/custom/custom_button_n_search/search_field_button.dart';
import 'package:healthycart/core/custom/custom_cached_network/custom_cached_network_image.dart';
import 'package:healthycart/core/custom/lottie/circular_loading.dart';
import 'package:healthycart/core/custom/no_data/no_data_widget.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/hospital_profile/application/profile_provider.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class DoctorProfileList extends StatefulWidget {
  const DoctorProfileList({super.key});

  @override
  State<DoctorProfileList> createState() => _DoctorProfileListState();
}

class _DoctorProfileListState extends State<DoctorProfileList> {
  final ScrollController _scrollcontroller = ScrollController();
  @override
  void initState() {
    final profileProvider = context.read<ProfileProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      profileProvider.clearFetchData();
      profileProvider.getHospitalAllDoctorDetails();
    });

    _scrollcontroller.addListener(() {
      if (_scrollcontroller.position.atEdge &&
          _scrollcontroller.position.pixels != 0 &&
          profileProvider.fetchLoading == false) {
        profileProvider.getHospitalAllDoctorDetails();
      }
    });

    super.initState();
  }
  
  @override
  void dispose() {
    EasyDebounce.cancel('searchalldoctors');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
      return CustomScrollView(
        controller: _scrollcontroller,
        slivers: [
                   SliverCustomAppbar(
            title: 'All Doctors',
            onBackTap: () {
              EasyNavigation.pop(context: context);
            },
            child: PreferredSize(
              preferredSize: const Size(double.infinity, 68),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 8, top: 4),
                child: SearchTextFieldButton(
                  text: "Search doctors...",
                  controller: profileProvider.searchController,
                  onChanged: (value) {
                    EasyDebounce.debounce(
                        'searchalldoctors', const Duration(milliseconds: 500), () {
                      profileProvider.searchDoctors(value);
                    });
                  },
                ),
              ),
            ),
          ),
          if (profileProvider.fetchLoading && profileProvider.allDoctorList.isEmpty)
          const SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: LoadingIndicater()
                    ),
                  ),
                )
                else if
                (profileProvider.allDoctorList.isEmpty)
                   const ErrorOrNoDataPage(
                      text: "No doctor's found.",
                    )
              else
          SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.builder(
                  itemCount: profileProvider.allDoctorList.length,
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
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CustomCachedNetworkImage(
                                            image: profileProvider
                                                    .allDoctorList[index]
                                                    .doctorImage ??
                                                '')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, bottom: 16, left: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 232,
                                          child: Row(
                                            children: [
                                              const Gap(8),
                                              Expanded(
                                                child: Text(
                                                  profileProvider
                                                          .allDoctorList[
                                                              index]
                                                          .doctorName ??
                                                      'Unknown Name',
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                        const Gap(4),
                                        SizedBox(
                                          width: 232,
                                          child: Row(
                                            children: [
                                              const Gap(8),
                                              Expanded(
                                                child: Text(
                                                  profileProvider
                                                          .allDoctorList[
                                                              index]
                                                          .doctorSpecialization ??
                                                      'Unknown Qualification',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w700),
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
                                                  profileProvider
                                                          .allDoctorList[
                                                              index]
                                                          .doctorSpecialization ??
                                                      'Unknown Specialization',
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  profileProvider
                                                          .allDoctorList[
                                                              index]
                                                          .doctorTotalTime ??
                                                  'Time 11.00AM - 2.30PM',
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                  }
                  ),
                  ),
                            SliverToBoxAdapter(
              child: (profileProvider.fetchLoading == true &&
                      profileProvider.allDoctorList.isNotEmpty)
                  ? const Center(child: LoadingIndicater())
                  : null),
        ],
      );
    }));
  }
}
