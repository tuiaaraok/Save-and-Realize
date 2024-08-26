import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
part 'friends_wiches.g.dart';

@HiveType(typeId: 1)
class FriendsWiches {
  @HiveField(0)
  final String name_friend;
  @HiveField(1)
  String whish_friend;
  @HiveField(2)
  Uint8List image_wish_friend;
  FriendsWiches({
    required this.name_friend,
    required this.whish_friend,
    required this.image_wish_friend,
  });
}
