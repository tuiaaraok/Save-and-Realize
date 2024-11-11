import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
part 'acount.g.dart';

@HiveType(typeId: 3)
class Acount {
  @HiveField(0)
  final String name;
  @HiveField(1)
  Uint8List? imageWishFriend;
  Acount({
    required this.name,
    this.imageWishFriend,
  });
}
