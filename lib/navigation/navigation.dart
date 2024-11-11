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

const String onboardingScreen = "/onboarding-screen";
const String infoScreen = "/info-screen";
const String homeScreen = "/home-screen";
const String addMyWish = "/add-my-wish";
const String addClientScreen = "/add-client-screen";
const String deleteMyWish = "/delete-my-wish";
const String deleteFriendWish = "/delete-friend-wish";
const String friendsWishesScreen = "/friends-wishes-screen";
const String createAcountScreen = "/create-acount-screen";

class NavigationApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboardingScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const OnboardingScreen();
          },
          settings: settings,
        );
      case createAcountScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const CreateAcountScreen();
          },
          settings: settings,
        );
      case infoScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const InfoScreen();
          },
          settings: settings,
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const HomeScreen();
          },
          settings: settings,
        );
      case addMyWish:
        return MaterialPageRoute(
          builder: (_) {
            return const AddMyWish();
          },
          settings: settings,
        );
      case addClientScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const AddClientScreen();
          },
          settings: settings,
        );
      case deleteMyWish:
        var args = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) {
            return DeleteMyWish(
              index: args,
            );
          },
          settings: settings,
        );
      case deleteFriendWish:
        var args = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) {
            return DeleteFriendWish(
              index: args,
            );
          },
          settings: settings,
        );
      case friendsWishesScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const FriendsWishesScreen();
          },
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const OnboardingScreen();
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