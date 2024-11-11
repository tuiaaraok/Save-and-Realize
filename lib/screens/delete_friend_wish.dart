import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/data/friends_wiches.dart';
import 'package:flutter_application_1/navigation/navigation.dart';
import 'package:flutter_application_1/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class DeleteFriendWish extends StatefulWidget {
  const DeleteFriendWish({super.key, required this.index});
  final int index;
  @override
  State<DeleteFriendWish> createState() => _DeleteFriendWishState();
}

class _DeleteFriendWishState extends State<DeleteFriendWish> {
  String name = "";
  String wish = "";
  late Uint8List _image;

  @override
  void initState() {
    super.initState();

    Box<FriendsWiches> contactsBox =
        Hive.box<FriendsWiches>(HiveBoxes.wishesFriends);
    _image = contactsBox.getAt(widget.index)!.imageWishFriend;
    wish = contactsBox.getAt(widget.index)!.whishFriend;
    name = contactsBox.getAt(widget.index)!.nameFriend;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: const Text(
          "Wish",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: SizedBox(
        width: double.maxFinite,
        height: 844.h,
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Text(
                  "$name:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 180.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5545B8).withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    image: DecorationImage(
                        image: MemoryImage(_image), fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    wish,
                    style: TextStyle(
                        fontSize: 18.sp, color: const Color(0xFF5545B8)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 70.h,
            ),
            SizedBox(
              width: 310.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name of wish",
                    style: kSubtitleStyle,
                  ),
                  Container(
                    height: 55.h,
                    width: 310.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        border: Border.all(color: Colors.white)),
                    child: Center(
                      child: Text(
                        wish,
                        style: TextStyle(color: Colors.white, fontSize: 24.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 110.h,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                          index: widget.index,
                        ));
              },
              child: SizedBox(
                width: 236.w,
                child: Center(
                  child: CircleAvatar(
                    radius: 35.r,
                    backgroundColor: const Color(0xFFD9D9D9),
                    child: Center(
                      child: Image(
                        image: const AssetImage(
                          "assets/icons/Delete.png",
                        ),
                        height: 40.h,
                        width: 40.h,
                        fit: BoxFit.fitHeight,
                        color: const Color(0xFF5545B8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: SizedBox(
                  width: double.maxFinite,
                  height: 60.h,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 14.w),
                          Text(
                            "Back",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomDialog extends StatelessWidget {
  CustomDialog({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 300.h,
            width: 310.w,
            padding: const EdgeInsets.only(
              top: 18.0,
            ),
            margin: const EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 45, 36, 104),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Are you sure you\nwant to remove the\nwish?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ),
                GestureDetector(
                  onTap: () {
                    final constain =
                        Hive.box<FriendsWiches>(HiveBoxes.wishesFriends);
                    constain.deleteAt(index).whenComplete(() {
                      Navigator.pop(
                        // ignore: use_build_context_synchronously
                        context,
                      );
                      Navigator.pop(
                        // ignore: use_build_context_synchronously
                        context,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, friendsWishesScreen);
                    });
                  },
                  child: Container(
                    height: 36.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        border: Border.all(color: Colors.white),
                        color: Colors.white10),
                    child: Center(
                        child: Text(
                      "Yes",
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Container(
                      height: 36.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          border: Border.all(color: Colors.white),
                          color: Colors.white10),
                      child: Center(
                          child: Text(
                        "No",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10.h,
            top: 20.h,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Center(
                  child: CircleAvatar(
                    radius: 15.r,
                    backgroundColor: const Color(0xFFD9D9D9),
                    child: Center(
                      child: Image(
                        image: const AssetImage(
                          "assets/icons/Delete.png",
                        ),
                        height: 18.h,
                        width: 18.h,
                        fit: BoxFit.fitHeight,
                        color: const Color(0xFF5545B8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
