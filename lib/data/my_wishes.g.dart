// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_wishes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyWishesAdapter extends TypeAdapter<MyWishes> {
  @override
  final int typeId = 2;

  @override
  MyWishes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyWishes(
      name_wish: fields[0] as String,
      name_category: fields[1] as String,
      my_image_wish: fields[2] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, MyWishes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name_wish)
      ..writeByte(1)
      ..write(obj.name_category)
      ..writeByte(2)
      ..write(obj.my_image_wish);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyWishesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
