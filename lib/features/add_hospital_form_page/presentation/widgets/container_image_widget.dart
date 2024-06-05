
import 'package:flutter/material.dart';
import 'package:healthycart/core/custom/custom_cached_network/custom_cached_network_image.dart';
import 'package:healthycart/features/add_hospital_form_page/application/hospital_form_provider.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:provider/provider.dart';

class ImageFormContainerWidget extends StatelessWidget {
  const ImageFormContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Consumer<HosptialFormProvider>(builder: (context, formProvider, _) {
        return Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)),
          child: GestureDetector(
              onTap: () {
                formProvider.getImage();
              },
              child:(formProvider.imageFile == null &&
                                    formProvider.imageUrl == null)
                  ? Center(
                      child: Image.asset(
                        BImage.uploadImage,
                        height: 40,
                      ),
                    )
                  : (formProvider.imageFile != null)? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.file(
                          formProvider.imageFile!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ): ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomCachedNetworkImage(image: formProvider.imageUrl!, fit: BoxFit.contain,)
                      ),
                    ),
                    ),
        );
      }
    );
  }
}


