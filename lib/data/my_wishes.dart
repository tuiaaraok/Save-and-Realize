import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
part 'my_wishes.g.dart';

@HiveType(typeId: 2)
class MyWishes {
  @HiveField(0)
  String name_wish;
  @HiveField(1)
  String name_category;
  @HiveField(2)
  Uint8List my_image_wish;
  MyWishes({
    required this.name_wish,
    required this.name_category,
    required this.my_image_wish,
  });
}
