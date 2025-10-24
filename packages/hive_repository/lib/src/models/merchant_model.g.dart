// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MerchantModelAdapter extends TypeAdapter<MerchantModel> {
  @override
  final int typeId = 2;

  @override
  MerchantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MerchantModel(
      id: fields[0] as String,
      name: fields[1] as String,
      qrCode: fields[2] as String,
      tag: fields[3] as String,
      owner: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MerchantModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.qrCode)
      ..writeByte(3)
      ..write(obj.tag)
      ..writeByte(4)
      ..write(obj.owner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
