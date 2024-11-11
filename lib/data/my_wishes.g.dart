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
      nameWish: fields[0] as String,
      nameCategory: fields[1] as String,
      myImageWish: fields[2] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, MyWishes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nameWish)
      ..writeByte(1)
      ..write(obj.nameCategory)
      ..writeByte(2)
      ..write(obj.myImageWish);
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
