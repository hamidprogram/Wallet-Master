// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Buys.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuyAdapter extends TypeAdapter<Buy> {
  @override
  final int typeId = 1;

  @override
  Buy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Buy(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Buy obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.buytitle)
      ..writeByte(1)
      ..write(obj.mony)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
