import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/navigation/navigation.dart';
import 'package:flutter_application_1/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: isActive ? 8.0.h : 10.h,
      width: isActive ? 35.w : 10.h,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF5545B8) : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 650.h,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      WidgetForOnBoardingInfo(
                        asset_image: 'assets/images/onboarding1.png',
                        title: 'Create your first wishlist',
                        subtitle:
                            'Create your own collections\nof wishes and make them\ncome true!',
                      ),
                      WidgetForOnBoardingInfo(
                        asset_image: 'assets/images/onboarding2.png',
                        title: 'Create your first wishlist',
                        subtitle:
                            'Create your own collections\nof wishes and make them\ncome true!',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        if (_currentPage == 1) {
                          Navigator.pushNamed(context, create_acount_screen);
                        }
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        width: 320.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: Color(0xFF5545B8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetForOnBoardingInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String asset_image;

  WidgetForOnBoardingInfo(
      {required this.title, required this.subtitle, required this.asset_image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h, bottom: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
              asset_image,
            ),
            height: 280.w,
            width: 280.w,
          ),
          SizedBox(height: 30.h),
          Text(
            'Create your first wishlist',
            textAlign: TextAlign.center,
            style: kTitleStyle,
          ),
          SizedBox(height: 15.h),
          Container(
            child: Text(
              'Create your own collections\nof wishes and make them\ncome true!',
              textAlign: TextAlign.center,
              style: kSubtitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
