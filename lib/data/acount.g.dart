// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acount.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AcountAdapter extends TypeAdapter<Acount> {
  @override
  final int typeId = 3;

  @override
  Acount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Acount(
      name: fields[0] as String,
      image_wish_friend: fields[1] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, Acount obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image_wish_friend);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
