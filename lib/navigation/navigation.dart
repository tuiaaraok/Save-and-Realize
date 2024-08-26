import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/create_acount_screen.dart';
import 'package:flutter_application_1/screens/info_screen.dart';
import 'package:flutter_application_1/screens/onboarding_screen.dart';
import 'package:flutter_application_1/screens/friends_wishes_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/add_client_screen.dart';
import 'package:flutter_application_1/screens/add_my_wish.dart';
import 'package:flutter_application_1/screens/delete_friend_wish.dart';
import 'package:flutter_application_1/screens/delete_my_wish.dart';

const String onboarding_screen = "/onboarding-screen";
const String info_screen = "/info-screen";
const String home_screen = "/home-screen";
const String add_my_wish = "/add-my-wish";
const String add_client_screen = "/add-client-screen";
const String delete_my_wish = "/delete-my-wish";
const String delete_friend_wish = "/delete-friend-wish";
const String friends_wishes_screen = "/friends-wishes-screen";
const String create_acount_screen = "/create-acount-screen";

class NavigationApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding_screen:
        return MaterialPageRoute(
          builder: (_) {
            return OnboardingScreen();
          },
          settings: settings,
        );
      case create_acount_screen:
        return MaterialPageRoute(
          builder: (_) {
            return CreateAcountScreen();
          },
          settings: settings,
        );
      case info_screen:
        return MaterialPageRoute(
          builder: (_) {
            return InfoScreen();
          },
          settings: settings,
        );
      case home_screen:
        return MaterialPageRoute(
          builder: (_) {
            return HomeScreen();
          },
          settings: settings,
        );
      case add_my_wish:
        return MaterialPageRoute(
          builder: (_) {
            return AddMyWish();
          },
          settings: settings,
        );
      case add_client_screen:
        return MaterialPageRoute(
          builder: (_) {
            return AddClientScreen();
          },
          settings: settings,
        );
      case delete_my_wish:
        var args = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) {
            return DeleteMyWish(
              index: args,
            );
          },
          settings: settings,
        );
      case delete_friend_wish:
        var args = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) {
            return DeleteFriendWish(
              index: args,
            );
          },
          settings: settings,
        );
      case friends_wishes_screen:
        return MaterialPageRoute(
          builder: (_) {
            return FriendsWishesScreen();
          },
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return OnboardingScreen();
          },
          settings: settings,
        );
    }
  }
}
  //  Navigator.of(
  //                                         context,
  //                                       ).pushNamed(info_client_page,
  //                                           arguments: box.getAt(currentIndex));