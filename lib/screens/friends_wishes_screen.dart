import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/data/acount.dart';
import 'package:flutter_application_1/data/friends_wiches.dart';
import 'package:flutter_application_1/navigation/navigation.dart';
import 'package:flutter_application_1/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/data/friends_wiches.dart';
import 'package:flutter_application_1/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/data/friends_wiches.dart';
import 'package:flutter_application_1/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FriendsWishesScreen extends StatefulWidget {
  FriendsWishesScreen({super.key});

  @override
  State<FriendsWishesScreen> createState() => _FriendsWishesScreenState();
}

class _FriendsWishesScreenState extends State<FriendsWishesScreen> {
  Set<String> friends_names = {};
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool remove_btn = false;
  Set<String> remove_elements = {};
  Set<String> sort_names = {};
  late Box<FriendsWiches> contactsBox;

  @override
  void initState() {
    super.initState();
    contactsBox = Hive.box<FriendsWiches>(HiveBoxes.wishes_friends);

    contactsBox.values.forEach((toElement) {
      friends_names.add(toElement.name_friend);
    });
  }

  void deleteSelectedFriends() {
    // Create a list of keys to delete

    for (int i = 0; i < contactsBox.length.toInt(); i++) {
      if (remove_elements.contains(contactsBox.getAt(i)!.name_friend)) {
        contactsBox.deleteAt(i);

        i--;
      }
    }
    setState(() {
      friends_names.removeAll(remove_elements);

      remove_elements.clear(); // Clear selected names
      remove_btn = false; // Reset remove mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(),
      appBar: buildAppBar(),
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<FriendsWiches>(HiveBoxes.wishes_friends).listenable(),
        builder: (context, Box<FriendsWiches> box, _) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: 390.w,
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      box.isEmpty
                          ? Container(
                              height: 370.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "#Empty",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Add the first wish",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          : buildGrid(box),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 21.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushNamed(add_client_screen);
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(0xFF5545B8).withOpacity(0.5),
                            radius: 45.r,
                            child: Icon(Icons.add,
                                color: Colors.white, size: 36.h),
                          ),
                        ),
                      ),
                      SizedBox(height: 60.h),
                    ],
                  ),
                ),
              ),
              buildBackButton(),
            ],
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        child: Column(
          children: [
            Text(
              "Menu",
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset('assets/icons/drawer.svg'),
          ],
        ),
      ),
      title: Text(
        "The wish of friends",
        style: TextStyle(color: Colors.grey, fontSize: 18.sp),
      ),
    );
  }

  Widget buildDrawer() {
    return Row(
      children: [
        Container(
          width: 276.w,
          color: Color.fromARGB(255, 38, 16, 95),
          child: SafeArea(
            child: Column(
              children: [
                buildProfileSection(),
                buildFriendsList(),
                buildRemoveButton(),
                buildActionButton(),
              ],
            ),
          ),
        ),
        Expanded(
            child: GestureDetector(
          child: Container(
            color: Colors.transparent,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState!.closeDrawer();
                },
                child: Column(
                  children: [
                    Text(
                      "Menu",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SvgPicture.asset(
                      'assets/icons/drawer.svg',
                    )
                  ],
                ),
              ),
            ),
          ),
        ))
      ],
    );
  }

  Padding buildProfileSection() {
    return Padding(
      padding: EdgeInsets.only(left: 29.w),
      child: Container(
        width: 236.w,
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Container(
            width: 50.h,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(25.r)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Hive.box<Acount>(HiveBoxes.acount)
                            .getAt(0)
                            ?.image_wish_friend ==
                        null
                    ? AssetImage("assets/images/profile.png")
                    : MemoryImage(Hive.box<Acount>(HiveBoxes.acount)
                        .getAt(0)!
                        .image_wish_friend!),
              ),
            ),
          ),
          title: Text(
            Hive.box<Acount>(HiveBoxes.acount).getAt(0)!.name,
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Your Profile",
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              size: 30.h, color: Colors.white),
        ),
      ),
    );
  }

  Padding buildFriendsList() {
    return Padding(
      padding: EdgeInsets.only(left: 27.w, right: 14.w, top: 22.h),
      child: Container(
        height: 537.h,
        child: ListView.builder(
          itemCount: friends_names.length,
          itemBuilder: (BuildContext context, int index) {
            return buildFriendTile(index);
          },
        ),
      ),
    );
  }

  Padding buildFriendTile(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 11.h),
      child: GestureDetector(
        onTap: () {
          if (remove_btn) {
            remove_elements.contains(friends_names.elementAt(index))
                ? remove_elements.remove(friends_names.elementAt(index))
                : remove_elements.add(friends_names.elementAt(index));
          } else {
            sort_names.contains(friends_names.elementAt(index))
                ? sort_names.remove(friends_names.elementAt(index))
                : sort_names.add(friends_names.elementAt(index));
          }
          setState(() {});
        },
        child: Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(Radius.circular(36.r)),
            border: remove_elements.contains(friends_names.elementAt(index))
                ? Border.all(color: Colors.red)
                : sort_names.contains(friends_names.elementAt(index))
                    ? Border.all(color: Colors.white)
                    : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10.w),
              Icon(Icons.person_rounded, size: 30.h, color: Colors.white),
              Expanded(
                child: Text(
                  friends_names.elementAt(index),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
              SizedBox(width: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildRemoveButton() {
    return Padding(
      padding: EdgeInsets.only(left: 27.w, right: 14.w, bottom: 20.h),
      child: GestureDetector(
        onTap: () {
          setState(() {
            sort_names = {};
            remove_elements = {};
            remove_btn = !remove_btn;
          });
        },
        child: Container(
          width: 236.w,
          child: Center(
            child: CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.grey,
              child: Center(
                child: Image(
                  image: AssetImage("assets/icons/Delete.png"),
                  color: remove_btn ? Colors.red : Color(0xFF5545B8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildActionButton() {
    return GestureDetector(
      onTap: () {
        if (remove_btn) {
          deleteSelectedFriends();
        }
        _scaffoldKey.currentState!.closeDrawer();
      },
      child: Container(
        width: 214.w,
        height: 45.h,
        decoration: BoxDecoration(
          color: remove_btn && remove_elements.isEmpty
              ? Color(0xFF5545B8).withOpacity(0.5)
              : Color(0xFF5545B8),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        child: Center(
          child: Text(
            remove_btn
                ? "Delete"
                : sort_names.isEmpty
                    ? 'Go Back'
                    : "Sort",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  GridView buildGrid(Box<FriendsWiches> box) {
    List<FriendsWiches> friends = box.values.toList();

    // Если выбраны имена для сортировки
    if (sort_names.isNotEmpty) {
      friends = friends
          .where((friend) => sort_names.contains(friend.name_friend))
          .toList();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (140.w / 199.h),
      ),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        // Убедитесь, что индекс не выходит за границы
        if (index < friends.length) {
          return buildFriendCard(friends[index], index);
        } else {
          return SizedBox.shrink(); // Безопасно возвращаем пустой вид
        }
      },
    );
  }

  Padding buildFriendCard(FriendsWiches friend, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(delete_friend_wish, arguments: index);
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    image: DecorationImage(
                      image: MemoryImage(friend.image_wish_friend),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                height: 29.h,
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: friend.name_friend,
                    style: TextStyle(color: Colors.white, fontSize: 21.sp),
                    children: [
                      TextSpan(
                        text: "/",
                        style: TextStyle(color: Colors.grey, fontSize: 21.sp),
                      ),
                      TextSpan(
                        text: friend.whish_friend,
                        style: TextStyle(
                            color: Color(0xFF5545B8), fontSize: 21.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align buildBackButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: double.maxFinite,
        height: 60.h,
        color: Colors.black,
        child: GestureDetector(
          onTap: () {
            print("Back pressed");
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.arrow_back_ios, color: Colors.white, size: 14.w),
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
    );
  }
}


// class FriendsWishesScreen extends StatefulWidget {
//   FriendsWishesScreen({
//     super.key,
//   });

//   @override
//   State<FriendsWishesScreen> createState() => _FriendsWishesScreenState();
// }

// class _FriendsWishesScreenState extends State<FriendsWishesScreen> {
//   Set<String> friends_name = {};
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool remove_btn = false;
//   Set<String> remove_elsemts = {};
//   Set<String> sort_name = {};
//   @override
//   void initState() {
//     super.initState();
//     Box<FriendsWiches> contactsBox =
//         Hive.box<FriendsWiches>(HiveBoxes.wishes_friends);
//     print(contactsBox.values.length);

//     contactsBox.values.forEach((toElement) {
//       friends_name.add(toElement.name_friend);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
      // drawer: Row(
      //   children: [
      //     Container(
      //       width: 276.w,
      //       color: Color.fromARGB(255, 38, 16, 95),
      //       child: SafeArea(
      //         child: Column(
      //           children: [
      //             Column(
      //               children: [
      //                 Padding(
      //                   padding: EdgeInsets.only(
      //                     left: 29.w,
      //                   ),
      //                   child: Container(
      //                     width: 236.w,
      //                     child: ListTile(
      //                       contentPadding: EdgeInsets.all(0),
      //                       leading: Container(
      //                         width: 50.h,
      //                         height: 50.h,
      //                         decoration: BoxDecoration(
      //                             color: Colors.amber,
      //                             borderRadius:
      //                                 BorderRadius.all(Radius.circular(
      //                               25.r,
      //                             )),
      //                             image: DecorationImage(
      //                               fit: BoxFit.cover,
      //                               image: AssetImage(
      //                                 "assets/images/profile.png",
      //                               ),
      //                             )),
      //                       ),
      //                       title: Text(
      //                         "Mark Stebulov",
      //                         style: TextStyle(
      //                             fontSize: 16.sp,
      //                             color: Colors.white,
      //                             fontWeight: FontWeight.bold),
      //                       ),
      //                       subtitle: Text(
      //                         "Your Profile",
      //                         style: TextStyle(
      //                             fontSize: 12.sp, color: Colors.grey),
      //                       ),
      //                       trailing: Icon(
      //                         Icons.arrow_forward_ios_rounded,
      //                         size: 30.h,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 Divider(
      //                   indent: 34.w,
      //                   thickness: 1.h,
      //                   color: Color(0xFF5545B8),
      //                 )
      //               ],
      //             ),
      //             Padding(
      //               padding:
      //                   EdgeInsets.only(left: 27.w, right: 14.w, top: 22.h),
      //               child: Container(
      //                 height: 537.h,
      //                 child: ListView.builder(
      //                   itemCount: friends_name.length,
      //                   itemBuilder: (BuildContext context, int index) {
      //                     return Padding(
      //                       padding: EdgeInsets.symmetric(vertical: 11.h),
      //                       child: GestureDetector(
      //                         onTap: () {
      //                           if (remove_btn) {
      //                             if (remove_elsemts.contains(
      //                                 friends_name.elementAt(index))) {
      //                               remove_elsemts
      //                                   .remove(friends_name.elementAt(index));
      //                             } else {
      //                               remove_elsemts
      //                                   .add(friends_name.elementAt(index));
      //                             }
      //                           } else {
      //                             if (sort_name.contains(
      //                                 friends_name.elementAt(index))) {
      //                               sort_name
      //                                   .remove(friends_name.elementAt(index));
      //                             } else {
      //                               sort_name
      //                                   .add(friends_name.elementAt(index));
      //                             }
      //                           }
      //                           setState(() {});
      //                         },
      //                         child: Container(
      //                           height: 45.h,
      //                           decoration: BoxDecoration(
      //                               color: Colors.black26,
      //                               borderRadius:
      //                                   BorderRadius.all(Radius.circular(36.r)),
      //                               border: remove_elsemts.contains(
      //                                       friends_name.elementAt(index))
      //                                   ? Border.all(color: Colors.red)
      //                                   : sort_name.contains(
      //                                           friends_name.elementAt(index))
      //                                       ? Border.all(color: Colors.white)
      //                                       : null),
      //                           child: Row(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.center,
      //                               children: [
      //                                 SizedBox(width: 10.w),
      //                                 Icon(
      //                                   Icons.person_rounded,
      //                                   size: 30.h,
      //                                   color: Colors.white,
      //                                 ),
      //                                 Expanded(
      //                                   child: Text(
      //                                     friends_name.elementAt(index),
      //                                     textAlign: TextAlign.center,
      //                                     style: TextStyle(
      //                                         color: Colors.white,
      //                                         fontSize: 16.sp),
      //                                   ),
      //                                 ),
      //                                 SizedBox(width: 40.h),
      //                               ]),
      //                         ),
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 9.h,
      //             ),
      //             Padding(
      //               padding: EdgeInsets.only(
      //                 left: 27.w,
      //                 right: 14.w,
      //               ),
      //               child: GestureDetector(
      //                 onTap: () {
      //                   remove_btn = !remove_btn;
      //                   setState(() {});
      //                 },
      //                 child: Container(
      //                   width: 236.w,
      //                   child: Center(
      //                       child: CircleAvatar(
      //                     radius: 25.r,
      //                     backgroundColor: Colors.grey,
      //                     child: Center(
      //                         child: Image(
      //                       image: AssetImage(
      //                         "assets/icons/Delete.png",
      //                       ),
      //                       color: remove_btn ? Colors.red : Color(0xFF5545B8),
      //                     )),
      //                   )),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 9.h,
      //             ),
      //             GestureDetector(
      //               onTap: () {
      //                 _scaffoldKey.currentState!.closeDrawer();
      //               },
      //               child: Container(
      //                 width: 214.w,
      //                 height: 45.h,
      //                 decoration: BoxDecoration(
      //                     color: remove_btn
      //                         ? remove_elsemts.isEmpty
      //                             ? Color(0xFF5545B8).withOpacity(0.5)
      //                             : Color(0xFF5545B8)
      //                         : Color(0xFF5545B8),
      //                     borderRadius:
      //                         BorderRadius.all(Radius.circular(12.r))),
      //                 child: Center(
      //                   child: Text(
      //                     remove_btn
      //                         ? "Delete"
      //                         : sort_name.isEmpty
      //                             ? 'Go Back'
      //                             : "Sort",
      //                     style: TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 22.sp,
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Expanded(
      //       child: GestureDetector(
      //         child: Container(
      //           color: Colors.transparent,
      //           child: SafeArea(
      //             child: GestureDetector(
      //               onTap: () {
      //                 _scaffoldKey.currentState!.closeDrawer();
      //               },
      //               child: Column(
      //                 children: [
      //                   Text(
      //                     "Menu",
      //                     style: TextStyle(
      //                         fontSize: 15.sp,
      //                         color: Colors.white,
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                   SvgPicture.asset(
      //                     'assets/icons/drawer.svg',
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             _scaffoldKey.currentState!.openDrawer();
//           },
//           child: Column(
//             children: [
//               Text(
//                 "Menu",
//                 style: TextStyle(
//                     fontSize: 15.sp,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//               SvgPicture.asset(
//                 'assets/icons/drawer.svg',
//               )
//             ],
//           ),
//         ),
//         title: Text(
//           "The wish of friends",
//           style: TextStyle(color: Colors.grey, fontSize: 18.sp),
//         ),
//       ),
//       body: ValueListenableBuilder(
//         valueListenable:
//             Hive.box<FriendsWiches>(HiveBoxes.wishes_friends).listenable(),
//         builder: (context, Box<FriendsWiches> box, _) {
//           return Stack(
//             children: [
//               SingleChildScrollView(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 30.h),
//                     GridView.builder(
//                       shrinkWrap: true,
//                       physics:
//                           NeverScrollableScrollPhysics(), // Чтобы не было лишней прокрутки
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         childAspectRatio: (140.w / 199.h),
//                       ),
//                       itemCount: box.values.length,
//                       itemBuilder: (context, index) {
//                         final currentIndex = box.length - index - 1;
//                         if (sort_name.isNotEmpty) {

//                         }
//                         return Padding(
//                           padding: index % 2 == 0
//                               ? EdgeInsets.only(
//                                   left: 10.w, right: 14.w, bottom: 20.h)
//                               : EdgeInsets.only(
//                                   left: 14.w, right: 10.w, bottom: 20.h),
//                           child: Container(
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(12.r)),
//                                       image: DecorationImage(
//                                         image: MemoryImage(box
//                                             .getAt(currentIndex)!
//                                             .image_wish_friend),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 29.h,
//                                   alignment: Alignment.center,
//                                   child: RichText(
//                                     text: TextSpan(
//                                       text:
//                                           box.getAt(currentIndex)!.name_friend,
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 21.sp),
//                                       children: [
//                                         TextSpan(
//                                           text: "/",
//                                           style: TextStyle(
//                                               color: Colors.grey,
//                                               fontSize: 21.sp),
//                                         ),
//                                         TextSpan(
//                                           text: box
//                                               .getAt(currentIndex)!
//                                               .whish_friend,
//                                           style: TextStyle(
//                                               color: Color(0xFF5545B8),
//                                               fontSize: 21.sp),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 21.h),
//                       child: CircleAvatar(
//                         backgroundColor: Color(0xFF5545B8).withOpacity(0.5),
//                         radius: 45.r,
//                         child: Icon(Icons.add, color: Colors.white, size: 36.h),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 60.h,
//                     )
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Container(
//                   width: double.maxFinite,
//                   height: 60.h,
//                   color: Colors.black,
//                   child: GestureDetector(
//                     onTap: () {
//                       print("Back pressed");
//                       // Обработчик нажатия на кнопку "Back"
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Icon(Icons.arrow_back_ios,
//                               color: Colors.white, size: 14.w),
//                           Text(
//                             "Back",
//                             style: TextStyle(
//                                 fontSize: 16.sp,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
// //  Text(
// //                                       box.getAt(currentIndex)!.name_friend,
