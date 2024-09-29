import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/data/acount.dart';
import 'package:flutter_application_1/navigation/navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({
    super.key,
  });

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Box<Acount> contactsBox;
  @override
  void initState() {
    super.initState();
    contactsBox = Hive.box<Acount>(HiveBoxes.acount);
    if (contactsBox.isNotEmpty) {
      _image = contactsBox.getAt(0)?.image_wish_friend;
    }
  }

  TextEditingController namecontroller = TextEditingController();
  Uint8List? _image;
  int i = 0;
  Future getLostData() async {
    XFile? picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker == null) return;
    List<int> imageBytes = await picker.readAsBytes();
    _image = Uint8List.fromList(imageBytes);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.grey, fontSize: 24.sp),
        ),
      ),
      body: Container(
        width: 390.w,
        height: 844.h,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 130.h,
                      height: 150.h,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20.h,
                            child: Container(
                              width: 130.h,
                              height: 130.h,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(130.r)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: _image == null
                                      ? AssetImage("assets/images/profile.png")
                                      : MemoryImage(_image!),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  getLostData();
                                },
                                child: CircleAvatar(
                                  radius: 15.r,
                                  backgroundColor:
                                      Color(0xFF5545B8).withOpacity(0.5),
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/icons/Image.png"),
                                    height: 20.h,
                                    width: 20.h,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Text(
                      contactsBox.get(0)!.name,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                    Container(
                        width: 100.w,
                        height: 20.h,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: namecontroller,
                          decoration: InputDecoration(
                              hintText: 'Edit Name',
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp)),
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.transparent,
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        )),
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          String? encodeQueryParameters(
                              Map<String, String> params) {
                            return params.entries
                                .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }

                          // ···
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'TravisJohnson9902@outlook.com',
                            query: encodeQueryParameters(<String, String>{
                              '': '',
                            }),
                          );
                          try {
                            if (await canLaunchUrl(emailLaunchUri)) {
                              await launchUrl(emailLaunchUri);
                            } else {
                              throw Exception(
                                  "Could not launch $emailLaunchUri");
                            }
                          } catch (e) {
                            print(
                                'Error launching email client: $e'); // Log the error
                          }
                        },
                        child: Container(
                          width: 310.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                              color: Color(0xFF5545B8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Image(
                                image: AssetImage("assets/icons/Contact.png"),
                                color: Colors.white,
                                fit: BoxFit.fitWidth,
                                height: 30.w,
                                width: 30.w,
                              ),
                              SizedBox(
                                  width:
                                      8), // Добавьте немного пространства между иконкой и текстом
                              Expanded(
                                child: Text(
                                  "Contact us",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                  textAlign:
                                      TextAlign.center, // Центрируем текст
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 21.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          final Uri _url = Uri.parse('https://flutter.dev');
                          if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                          }
                        },
                        child: Container(
                          width: 310.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                              color: Color(0xFF5545B8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Image(
                                image: AssetImage("assets/icons/Privacy.png"),
                                color: Colors.white,
                                fit: BoxFit.fitWidth,
                                height: 30.w,
                                width: 30.w,
                              ),
                              SizedBox(
                                  width:
                                      8), // Добавьте немного пространства между иконкой и текстом
                              Expanded(
                                child: Text(
                                  "Privacy policy",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                  textAlign:
                                      TextAlign.center, // Центрируем текст
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 21.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          LaunchReview.launch(
                              androidAppId: "app.openauthenticator",
                              iOSAppId: "585027354");
                        },
                        child: Container(
                          width: 310.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                              color: Color(0xFF5545B8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Image(
                                image: AssetImage("assets/icons/Rate.png"),
                                color: Colors.white,
                                fit: BoxFit.fitWidth,
                                height: 30.w,
                                width: 30.w,
                              ),
                              SizedBox(
                                  width:
                                      8), // Добавьте немного пространства между иконкой и текстом
                              Expanded(
                                child: Text(
                                  "Rate us",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                  textAlign:
                                      TextAlign.center, // Центрируем текст
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 21.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 190.h,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: double.maxFinite,
                        height: 60.h,
                        color: Colors.black,
                        child: GestureDetector(
                          onTap: () {
                            print("Back pressed");
                            if (namecontroller.text != "") {
                              contactsBox.putAt(
                                  0,
                                  Acount(
                                      name: namecontroller.text,
                                      image_wish_friend: _image));
                            } else {
                              contactsBox.putAt(
                                  0,
                                  Acount(
                                      name: contactsBox.get(0)!.name,
                                      image_wish_friend: _image));
                            }

                            Navigator.pushNamed(context, home_screen);
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



    // googlePlayIdentifier: 'app.openauthenticator',
    //           appStoreIdentifier: '6479272927',