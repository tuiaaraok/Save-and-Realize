// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_wiches.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FriendsWichesAdapter extends TypeAdapter<FriendsWiches> {
  @override
  final int typeId = 1;

  @override
  FriendsWiches read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FriendsWiches(
      nameFriend: fields[0] as String,
      whishFriend: fields[1] as String,
      imageWishFriend: fields[2] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, FriendsWiches obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nameFriend)
      ..writeByte(1)
      ..write(obj.whishFriend)
      ..writeByte(2)
      ..write(obj.imageWishFriend);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendsWichesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
