import 'package:flutter/material.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/data/acount.dart';
import 'package:flutter_application_1/navigation/navigation.dart';
import 'package:flutter_application_1/screens/onboarding_screen.dart';
import 'package:flutter_application_1/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class CreateAcountScreen extends StatefulWidget {
  CreateAcountScreen({
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(
                "assets/images/onboarding_name.png",
              ),
              height: 250.w,
              width: 250.w,
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
                    color: Color(0xFF5545B8),
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            Container(
              width: 310.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      "What's your name?",
                      style: kSubtitleStyle,
                    ),
                  ),
                  Container(
                    height: 55.h,
                    width: 310.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        border: Border.all(color: Colors.white)),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: nameController,
                        decoration: InputDecoration(
                            border: InputBorder.none, // Убираем обводку
                            focusedBorder:
                                InputBorder.none, // Убираем обводку при фокусе
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
                        onChanged: (text) {
                          print(nameController.value.text);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Hive.box<Acount>(HiveBoxes.acount)
                          .add(Acount(name: nameController.text));
                      Navigator.pushNamed(context, home_screen);
                    },
                    child: Container(
                      width: 320.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                          color: nameController.text == ''
                              ? Color(0xFF5545B8).withOpacity(0.5)
                              : Color(0xFF5545B8),
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
    ));
  }
}