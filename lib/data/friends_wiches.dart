import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
part 'friends_wiches.g.dart';

@HiveType(typeId: 1)
class FriendsWiches {
  @HiveField(0)
  final String nameFriend;
  @HiveField(1)
  String whishFriend;
  @HiveField(2)
  Uint8List imageWishFriend;
  FriendsWiches({
    required this.nameFriend,
    required this.whishFriend,
    required this.imageWishFriend,
  });
}
