import 'package:flutter/material.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/data/acount.dart';

import 'package:flutter_application_1/data/my_wishes.dart';
import 'package:flutter_application_1/navigation/navigation.dart';
import 'package:flutter_application_1/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool removeBtn = false;
  Set<String> removeElements = {};
  Set<String> sortNames = {};
  late Box<MyWishes> contactsBox;
  Set<String> friendsNames = {};
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
    contactsBox = Hive.box<MyWishes>(HiveBoxes.myWishes);

    for (var toElement in contactsBox.values) {
      friendsNames.add(toElement.nameCategory);
    }
  }

  void deleteSelectedFriends() {
    // Create a list of keys to delete

    for (int i = 0; i < contactsBox.length.toInt(); i++) {
      if (removeElements.contains(contactsBox.getAt(i)!.nameCategory)) {
        contactsBox.deleteAt(i);

        i--;
      }
    }
    setState(() {
      friendsNames.removeAll(removeElements);

      removeElements.clear(); // Clear selected names
      removeBtn = false; // Reset remove mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(),
      body: Padding(
        padding: EdgeInsets.only(
            left: 24.w, right: 24.w, top: MediaQuery.paddingOf(context).top),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 390.w,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          height: 20.h,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(friendsWishesScreen);
                  },
                  child: Container(
                    width: 310.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFF5545B8),
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
                    ).pushNamed(infoScreen);
                  },
                  child: Container(
                    width: 310.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFF5545B8),
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
                      addMyWish,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 21.h),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF5545B8).withOpacity(0.5),
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
                  child: SizedBox(
                    width: 370.w,
                    child: Text(
                      "All the wishes",
                      style: kSubtitleStyle,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box<MyWishes>(HiveBoxes.myWishes).listenable(),
                    builder: (context, Box<MyWishes> box, _) {
                      return box.isEmpty
                          ? SizedBox(
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
    if (sortNames.isNotEmpty) {
      friends = friends
          .where((friend) => sortNames.contains(friend.nameCategory))
          .toList();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
          return const SizedBox.shrink(); // Безопасно возвращаем пустой вид
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
          ).pushNamed(deleteMyWish, arguments: index);
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  image: DecorationImage(
                    image: MemoryImage(friend.myImageWish),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                friend.nameWish,
                style: TextStyle(color: Colors.white, fontSize: 21.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Row(
      children: [
        Container(
          width: 276.w,
          color: const Color.fromARGB(255, 38, 16, 95),
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
      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(infoScreen);
        },
        child: SizedBox(
          width: 236.w,
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Container(
              width: 50.h,
              height: 50.r,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: Hive.box<Acount>(HiveBoxes.acount)
                              .getAt(0)
                              ?.imageWishFriend ==
                          null
                      ? const AssetImage("assets/images/profile.png")
                      : MemoryImage(Hive.box<Acount>(HiveBoxes.acount)
                          .getAt(0)!
                          .imageWishFriend!),
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
      ),
    );
  }

  Padding buildFriendsList() {
    return Padding(
      padding: EdgeInsets.only(left: 27.w, right: 14.w, top: 22.h),
      child: SizedBox(
        height: 537.h,
        child: ListView.builder(
          itemCount: friendsNames.length,
          itemBuilder: (BuildContext context, int index) {
            return buildFriendTile(
                index,
                icons.contains(friendsNames.elementAt(index))
                    ? friendsNames.elementAt(index)
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
          if (removeBtn) {
            removeElements.contains(friendsNames.elementAt(index))
                ? removeElements.remove(friendsNames.elementAt(index))
                : removeElements.add(friendsNames.elementAt(index));
          } else {
            sortNames.contains(friendsNames.elementAt(index))
                ? sortNames.remove(friendsNames.elementAt(index))
                : sortNames.add(friendsNames.elementAt(index));
          }
          setState(() {});
        },
        child: Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(Radius.circular(36.r)),
            border: removeElements.contains(friendsNames.elementAt(index))
                ? Border.all(color: Colors.red)
                : sortNames.contains(friendsNames.elementAt(index))
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
                        image: AssetImage("assets/icons/$isIcon.png"),
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
                  friendsNames.elementAt(index),
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
            sortNames = {};
            removeElements = {};
            removeBtn = !removeBtn;
          });
        },
        child: SizedBox(
          width: 236.w,
          child: Center(
            child: CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.grey,
              child: Center(
                child: Image(
                  image: const AssetImage("assets/icons/Delete.png"),
                  color: removeBtn ? Colors.red : const Color(0xFF5545B8),
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
        if (removeBtn) {
          deleteSelectedFriends();
        }
        _scaffoldKey.currentState!.closeDrawer();
      },
      child: Container(
        width: 214.w,
        height: 45.h,
        decoration: BoxDecoration(
          color: removeBtn && removeElements.isEmpty
              ? const Color(0xFF5545B8).withOpacity(0.5)
              : const Color(0xFF5545B8),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        child: Center(
          child: Text(
            removeBtn
                ? "Delete"
                : sortNames.isEmpty
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
