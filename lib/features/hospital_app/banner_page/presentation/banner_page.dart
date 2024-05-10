import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthycart/core/custom/app_bar/custom_appbar_curve.dart';
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/features/hospital_app/banner_page/application/add_banner_provider.dart';
import 'package:healthycart/features/hospital_app/banner_page/presentation/widget/ad_slider.dart';
import 'package:healthycart/features/hospital_app/banner_page/presentation/widget/add_new_banner.dart';
import 'package:healthycart/features/hospital_app/banner_page/presentation/widget/add_banner_popup_widget.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/image.dart';
import 'package:provider/provider.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddBannerProvider>(context, listen: false).getBanner();
    });
    PopupAddBannerDialouge popUp = PopupAddBannerDialouge.instance;
    return Consumer<AddBannerProvider>(
        builder: (context, addBannerProvider, _) {
      return CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomCurveAppBarWidget(),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: AdSlider(screenWidth: double.infinity),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Add or Edit Banner's",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.builder(
              itemCount: addBannerProvider.bannerList.length+1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 104),
              itemBuilder: (context, index) {
                if (index == addBannerProvider.bannerList.length) {
                  return AddNewBannerWidget(
                    onTap: () {
                      popUp.showAddbannerDialouge(
                        context: context,
                        nameTitle: 'Add Banner',
                        buttonText: 'Save',
                        onAddTap: () {
                          addBannerProvider.getImage();
                        },
                        buttonTap: () async {
                          if (addBannerProvider.imageFile == null) {
                            CustomToast.errorToast(text: 'Pick a banner image');
                            return;
                          }
                          addBannerProvider.saveImage();
                          await addBannerProvider.addBanner();
                        },
                      );
                    },
                    child: const Center(child: Icon(Icons.add)),
                  );
                } else {
                  return BannerImageWidget(
                    indexNumber: '${index + 1}',
                  );
                }
              },
            ),
          )
        ],
      );
    });
  }
}

class BannerImageWidget extends StatelessWidget {
  const BannerImageWidget({
    super.key,
    required this.indexNumber,
  });
  final String indexNumber;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: BColors.lightGrey,
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                      image: AssetImage(BImage.logo), fit: BoxFit.fill)),
            ),
          ),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.2),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Positioned(
              left: 4,
              top: 4,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black,
                child: Text(
                  indexNumber,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                ),
              )),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: BColors.lightGrey.withOpacity(.6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Edit",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                const Gap(8),
                Icon(
                  Icons.mode_edit_outline_outlined,
                  size: 18,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
