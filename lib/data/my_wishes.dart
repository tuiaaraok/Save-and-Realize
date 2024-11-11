import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
part 'my_wishes.g.dart';

@HiveType(typeId: 2)
class MyWishes {
  @HiveField(0)
  String nameWish;
  @HiveField(1)
  String nameCategory;
  @HiveField(2)
  Uint8List myImageWish;
  MyWishes({
    required this.nameWish,
    required this.nameCategory,
    required this.myImageWish,
  });
}
