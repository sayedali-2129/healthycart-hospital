
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/pop_over/pop_over.dart';
import 'package:healthycart/core/general/cached_network_image.dart';
import 'package:healthycart/features/hospital_app/doctor_page/domain/model/add_doctor_model.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';

class DoctorDetailsViewContainerWidget extends StatelessWidget {
  const DoctorDetailsViewContainerWidget({
    super.key,
    required this.doctorList,
  });

  final DoctorAddModel doctorList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhysicalModel(
          color: BColors.white,
          borderRadius: BorderRadius.circular(12),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8, top: 6, bottom: 6),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 96,
                    width: 96,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(16),
                        child: CustomCachedNetworkImage(
                            image:
                                doctorList.doctorImage ??
                                    '')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 6,
                    ),
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
                                  doctorList.doctorName ??
                                      'Unknown Name',
                                  overflow: TextOverflow
                                      .ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontWeight:
                                              FontWeight
                                                  .w700),
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
                                  doctorList.doctorQualification ??
                                      'Unknown Name',
                                  overflow: TextOverflow
                                      .ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight:
                                              FontWeight
                                                  .w700),
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
                                  doctorList
                                          .doctorSpecialization ??
                                      'Unknown',
                                  overflow: TextOverflow
                                      .ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 14,
                                          fontWeight:
                                              FontWeight
                                                  .w300),
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
                                  doctorList
                                          .doctorTotalTime ??
                                      '9:00Am - 5.00PM',
                                  overflow: TextOverflow
                                      .ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color: Colors
                                              .green),
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
        Positioned(
          top: 0,
          right:0,
          child: PopOverEditDelete(editButton: (){}, deleteButton: (){}))
      ],
    );
  }
}