import 'package:flutter/material.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/data/acount.dart';
import 'package:flutter_application_1/navigation/navigation.dart';
import 'package:flutter_application_1/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class CreateAcountScreen extends StatefulWidget {
  const CreateAcountScreen({
    super.key,
  });

  @override
  State<CreateAcountScreen> createState() => _CreateAcountScreenState();
}

class _CreateAcountScreenState extends State<CreateAcountScreen> {
  TextEditingController nameController = TextEditingController();

  bool current = false;
  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      if (nameController.text != "") {
        current = true;
      } else {
        current = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 390.w,
          height: 844.h,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: const AssetImage(
                    "assets/images/onboarding_name.png",
                  ),
                  fit: BoxFit.fitHeight,
                  height: 250.h,
                  width: 250.w,
                ),
                SizedBox(
                  height: 60.h,
                ),
                Column(
                  children: [
                    Text(
                      'Create your first wishlist',
                      textAlign: TextAlign.center,
                      style: kTitleStyle,
                    ),
                    Text(
                      'Enter your name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF5545B8),
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80.h,
                ),
                SizedBox(
                  width: 310.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What's your name?",
                        style: kSubtitleStyle,
                      ),
                      Container(
                        height: 55.h,
                        width: 310.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            border: Border.all(color: Colors.white)),
                        child: Center(
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: nameController,
                            decoration: InputDecoration(
                                border: InputBorder.none, // Убираем обводку
                                focusedBorder: InputBorder
                                    .none, // Убираем обводку при фокусе
                                hintText: '...',
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.sp)),
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.transparent,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.sp),
                            onChanged: (text) {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 120.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Hive.box<Acount>(HiveBoxes.acount)
                              .add(Acount(name: nameController.text));
                          Navigator.pushNamed(context, homeScreen);
                        },
                        child: Container(
                          width: 320.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                              color: nameController.text == ''
                                  ? const Color(0xFF5545B8).withOpacity(0.5)
                                  : const Color(0xFF5545B8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Center(
                            child: Text(
                              'Start',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                              ),
                            ),
                          ),
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
    );
  }
}
