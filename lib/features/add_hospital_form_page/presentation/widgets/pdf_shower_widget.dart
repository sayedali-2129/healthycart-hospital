
import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/lottie/loading_lottie.dart';
import 'package:healthycart/core/services/easy_navigation.dart';
import 'package:healthycart/features/add_hospital_form_page/application/hospital_form_provider.dart';
import 'package:healthycart/utils/constants/image/image.dart';

class PDFShowerWidget extends StatelessWidget {
  const PDFShowerWidget({
    required this.formProvider,
    super.key,
  });
  final HosptialFormProvider formProvider;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      width: 88,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(BImage.imagePDF)),
          Positioned(
              top: -14,
              right: -14,
              child: IconButton(
                  onPressed: () {
                       LoadingLottie.showLoading(
                        context: context, text: 'Please wait');
                    formProvider.deletePDF().then((value) {
                      EasyNavigation.pop(context: context);
                    });
                  },
                  icon: const Icon(
                    Icons.cancel,
                    size: 24,
                    color: Colors.red,
                  ))),
        ],
      ),
    );
  }
}
