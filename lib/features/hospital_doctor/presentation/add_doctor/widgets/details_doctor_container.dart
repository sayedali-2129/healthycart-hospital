import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/pop_over/pop_over.dart';
import 'package:healthycart/core/custom/custom_cached_network/custom_cached_network_image.dart';
import 'package:healthycart/features/hospital_doctor/application/doctor_provider.dart';
import 'package:healthycart/features/hospital_doctor/domain/model/add_doctor_model.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:provider/provider.dart';

class DoctorDetailsViewContainerWidget extends StatelessWidget {
  const DoctorDetailsViewContainerWidget({
    super.key,
    required this.doctorListData,
     required this.editButton, required this.deleteButton,
  });

  final DoctorAddModel doctorListData;
  final VoidCallback editButton;
  final VoidCallback deleteButton;


  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(builder: (context, doctorProvider, _) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Material(
              color: BColors.white,
              borderRadius: BorderRadius.circular(12),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                              image: doctorListData.doctorImage ?? '')),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              doctorListData.doctorName ?? 
                              'Unknown Name ',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            const Gap(4),
                            Text(
                              doctorListData.doctorQualification ??
                                  'Unknown Qualification',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            const Gap(4),
                            Text(
                              doctorListData.doctorSpecialization ??
                                  'Unknown Specialization',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                            ),
                            const Gap(4),
                            Text(
                              doctorListData.doctorTotalTime ??
                                  '9:00Am - 5.00PM',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: PopOverEditDelete(
                editButton: editButton, deleteButton:deleteButton))
        ],
      );
    });
  }
}
