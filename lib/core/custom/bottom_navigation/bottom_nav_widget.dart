import 'package:flutter/material.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';
import 'package:healthycart/utils/constants/image/icon.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget(
      {super.key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4,
      required this.tabItems,
      required this.selectedImage,
      required this.unselectedImage});
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final Image selectedImage;
  final Image unselectedImage;
  final List<Widget> tabItems;
  @override
  State<BottomNavigationWidget> createState() => _BottonNavTabState();
}

class _BottonNavTabState extends State<BottomNavigationWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: widget.tabItems),
        bottomNavigationBar: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            // indicatorPadding: EdgeInsets.all(8),

            indicator: UnderlineTabIndicator(
                borderSide:
                    BorderSide(color: BColors.mainlightColor, width: 8.0),
                insets: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 66.0),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4))),
            labelStyle:
                Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 12,
                fontWeight: FontWeight.w600 ),
            labelColor: BColors.mainlightColor,
            unselectedLabelColor: BColors.black,
            
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            tabs: [
              Tab(
                icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: selectedIndex == 0
                        ? Image.asset(
                            BIcon.request,
                            height: 32,
                            width: 32,
                          )
                        : Image.asset(
                            BIcon.requestBlack,
                            height: 28,
                            width: 28,
                          )),
                text: widget.text1,
              ),
              Tab(
                text: widget.text2,
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: selectedIndex == 1
                      ? widget.selectedImage
                      : widget.unselectedImage,
                ),
              ),
              Tab(
                text: widget.text3,
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: selectedIndex == 2
                      ? Image.asset(
                          BIcon.addBanner,
                          height: 33,
                          width: 33,
                        )
                      : Image.asset(
                          BIcon.addBannerBlack,
                          height: 29,
                          width: 29,
                        ),
                ),
              ),
              Tab(
                text: widget.text4,
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: selectedIndex == 3
                      ? Image.asset(
                          BIcon.profile,
                          height: 32,
                          width: 32,
                        )
                      : Image.asset(
                          BIcon.profileBlack,
                          height: 28,
                          width: 28,
                        ),
                ),
              ),
            ]),
      ),
    );
  }
}
