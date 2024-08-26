import 'package:flutter/material.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/data/acount.dart';
import 'package:flutter_application_1/data/friends_wiches.dart';
import 'package:flutter_application_1/data/my_wishes.dart';

import 'package:flutter_application_1/navigation/navigation.dart';
import 'package:flutter_application_1/screens/create_acount_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/info_screen.dart';
import 'package:flutter_application_1/screens/onboarding_screen.dart';
import 'package:flutter_application_1/screens/add_client_screen.dart';
import 'package:flutter_application_1/screens/add_my_wish.dart';
import 'package:flutter_application_1/screens/delete_friend_wish.dart';
import 'package:flutter_application_1/screens/friends_wishes_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FriendsWichesAdapter());
  Hive.registerAdapter(MyWishesAdapter());
  Hive.registerAdapter(AcountAdapter());

  await Hive.openBox<FriendsWiches>(HiveBoxes.wishes_friends);
  await Hive.openBox<MyWishes>(HiveBoxes.my_wishes);
  await Hive.openBox<Acount>(HiveBoxes.acount);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: NavigationApp.generateRoute,
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarTheme(backgroundColor: Colors.transparent)),
          home: Hive.box<Acount>(HiveBoxes.acount).isEmpty
              ? OnboardingScreen()
              : HomeScreen(),
        ));
  }
}
//  Hive.box<FriendsWiches>(HiveBoxes.wishes_friends).isEmpty
//             ? AddClientScreen()
//             : FriendsWishesScreen(),