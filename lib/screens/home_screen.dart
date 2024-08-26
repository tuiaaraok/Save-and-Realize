import 'package:flutter/material.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/data/acount.dart';

import 'package:flutter_application_1/data/my_wishes.dart';
import 'package:flutter_application_1/navigation/navigation.dart';
import 'package:flutter_application_1/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool remove_btn = false;
  Set<String> remove_elements = {};
  Set<String> sort_names = {};
  late Box<MyWishes> contactsBox;
  Set<String> friends_names = {};
  Set<String> icons = {
    "Сlothes",
    "Сosmetics",
    "House",
    "Travel",
    "Technique",
    "Relationship",
    "Health"
  };

  @override
  void initState() {
    super.initState();
    contactsBox = Hive.box<MyWishes>(HiveBoxes.my_wishes);

    contactsBox.values.forEach((toElement) {
      friends_names.add(toElement.name_category);
    });
  }

  void deleteSelectedFriends() {
    // Create a list of keys to delete

    for (int i = 0; i < contactsBox.length.toInt(); i++) {
      if (remove_elements.contains(contactsBox.getAt(i)!.name_category)) {
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
      appBar: AppBar(
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
              SvgPicture.asset(
                'assets/icons/drawer.svg',
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Container(
            width: 390.w,
            child: Column(
              children: [
                SizedBox(
                  height: 36.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(friends_wishes_screen);
                  },
                  child: Container(
                    width: 310.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        color: Color(0xFF5545B8),
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Center(
                      child: Text(
                        "Friend's wishes",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(info_screen);
                  },
                  child: Container(
                    width: 310.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        color: Color(0xFF5545B8),
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Center(
                      child: Text(
                        "Help/Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(
                      add_my_wish,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 21.h),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF5545B8).withOpacity(0.5),
                      radius: 45.r,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 36.h,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Container(
                    width: 370,
                    child: Text(
                      "All the wishes",
                      style: kSubtitleStyle,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box<MyWishes>(HiveBoxes.my_wishes).listenable(),
                    builder: (context, Box<MyWishes> box, _) {
                      return box.isEmpty
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
                          : buildGrid(box);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  GridView buildGrid(Box<MyWishes> box) {
    List<MyWishes> friends = box.values.toList();

    // Если выбраны имена для сортировки
    if (sort_names.isNotEmpty) {
      friends = friends
          .where((friend) => sort_names.contains(friend.name_category))
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

  Padding buildFriendCard(MyWishes friend, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(delete_my_wish, arguments: index);
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    image: DecorationImage(
                      image: MemoryImage(friend.my_image_wish),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                height: 29.h,
                alignment: Alignment.center,
                child: Text(
                  friend.name_wish,
                  style: TextStyle(color: Colors.white, fontSize: 21.sp),
                ),
              ),
            ],
          ),
        ),
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
            return buildFriendTile(
                index,
                icons.contains(friends_names.elementAt(index))
                    ? friends_names.elementAt(index)
                    : "");
          },
        ),
      ),
    );
  }

  Padding buildFriendTile(int index, String isIcon) {
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
              isIcon != ""
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Image(
                        image: AssetImage("assets/icons/${isIcon}.png"),
                        height: 30.h,
                        width: 30.h,
                        fit: BoxFit.fill,
                        color: Colors.white,
                      ),
                    )
                  : SizedBox(
                      width: 50.w,
                    ),
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
}
