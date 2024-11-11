import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/boxes.dart';

import 'package:flutter_application_1/data/my_wishes.dart';
import 'package:flutter_application_1/navigation/navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddMyWish extends StatefulWidget {
  const AddMyWish({super.key});

  @override
  State<AddMyWish> createState() => _AddMyWishSatate();
}

class _AddMyWishSatate extends State<AddMyWish> {
  TextEditingController friendController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DecorationImage? decorationImage;
  String currentFriend = '';
  Set<String> icons = {
    "Сlothes",
    "Сosmetics",
    "House",
    "Travel",
    "Technique",
    "Relationship",
    "Health"
  };
  Set<String> category = {};
  Image? img;
  Uint8List? _image;
  Future getLostData() async {
    XFile? picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker == null) return;
    List<int> imageBytes = await picker.readAsBytes();
    _image = Uint8List.fromList(imageBytes);
  }

  @override
  void initState() {
    category.addAll(icons);
    super.initState();
    _updateFormCompletion();
    Box<MyWishes> contactsBox = Hive.box<MyWishes>(HiveBoxes.myWishes);
    for (var action in contactsBox.values) {
      category.add(action.nameCategory);
    }
    nameController.addListener(_updateFormCompletion);
    friendController.addListener(_updateFormCompletion);

    category.add("Other...");
  }

  _updateFormCompletion() {
    bool isFilled = nameController.text.isNotEmpty &&
        friendController.text.isNotEmpty &&
        _image != null;
    setState(() {});
    return isFilled;
  }

  bool ispress = false;
  Set<String> names = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  width: 370.w,
                  child: Text(
                    "A new wish",
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: const Color(0xFF5545B8),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                    width: 370.w,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 310.w,
                  child: Text(
                    "Name of wish",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
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
                      controller: friendController,
                      decoration: InputDecoration(
                          border: InputBorder.none, // Убираем обводку
                          focusedBorder:
                              InputBorder.none, // Убираем обводку при фокусе
                          hintText: '•••',
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
                  height: 30.h,
                ),
                SizedBox(
                  width: 310.w,
                  child: Text(
                    "Desire Category",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ispress = !ispress;
                    setState(() {});
                  },
                  child: Container(
                    height: 55.h,
                    width: 310.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        border: Border.all(color: Colors.white)),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 35.w,
                          ),
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: nameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none, // Убираем обводку
                                  focusedBorder: InputBorder
                                      .none, // Убираем обводку при фокусе
                                  hintText: '•••',
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
                          Padding(
                            padding: EdgeInsets.all(4.0.w),
                            child: CircleAvatar(
                              radius: 15.r,
                              backgroundColor:
                                  const Color(0xFF5545B8).withOpacity(0.5),
                              child: Center(
                                child: Icon(
                                  ispress
                                      ? Icons.expand_more_rounded
                                      : Icons.expand_less_rounded,
                                  color: Colors.white,
                                  size: 30.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (ispress)
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: category.toList().asMap().entries.map((entry) {
                      int idx = entry.key;
                      String toElement = entry.value;
                      return Padding(
                        padding: EdgeInsets.all(8.w),
                        child: GestureDetector(
                          onTap: () {
                            nameController.text = toElement;
                            setState(() {});
                          },
                          child: Container(
                            width: idx < 4 ? 150.w : 312.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                                color: const Color(0xFF5545B8).withOpacity(0.5),
                                border: toElement == nameController.text
                                    ? Border.all(color: Colors.white)
                                    : null,
                                borderRadius: BorderRadius.circular(25.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  icons.contains(toElement)
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Image(
                                            image: AssetImage(
                                                "assets/icons/$toElement.png"),
                                            height: 30.h,
                                            width: 30.h,
                                            fit: BoxFit.fill,
                                            color: Colors.white,
                                          ),
                                        )
                                      : SizedBox(
                                          width: 60.w,
                                        ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 12.w),
                                      child: Center(
                                        child: Text(
                                          toElement,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  (idx > 3)
                                      ? SizedBox(
                                          width: 20.w,
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                else
                  const SizedBox(),
                SizedBox(
                  height: 60.h,
                ),
                SizedBox(
                  width: 310.w,
                  child: Text(
                    "Pick an image",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 45.h,
                ),
                GestureDetector(
                  onTap: () async {
                    getLostData().whenComplete(() {
                      _updateFormCompletion();
                    });
                  },
                  child: Container(
                    height: 170.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5545B8).withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      image: _image == null
                          ? decorationImage
                          : DecorationImage(
                              image: MemoryImage(_image!), fit: BoxFit.cover),
                    ),
                    child: Center(
                        child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.white.withOpacity(0.12),
                      child: const Image(
                          image: AssetImage("assets/icons/Image.png")),
                    )),
                  ),
                ),
                SizedBox(
                  height: 65.h,
                ),
                GestureDetector(
                  onTap: () {
                    if (_updateFormCompletion()) {
                      Box<MyWishes> contactsBox =
                          Hive.box<MyWishes>(HiveBoxes.myWishes);
                      MyWishes addwishfriend = MyWishes(
                        nameWish: friendController.text,
                        nameCategory: nameController.text,
                        myImageWish: _image!,
                      );
                      contactsBox.add(addwishfriend);
                      Navigator.of(
                        context,
                      ).pop();
                      Navigator.pushNamed(context, homeScreen);
                    }
                  },
                  child: Container(
                    width: 320.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                        color: _updateFormCompletion()
                            ? const Color(0xFF5545B8)
                            : const Color(0xFF5545B8).withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Center(
                      child: Text(
                        'Save',
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
          ),
        ),
      ),
    );
  }
}
