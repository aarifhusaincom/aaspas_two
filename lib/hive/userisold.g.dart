// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userisold.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class userisoldAdapter extends TypeAdapter<userisold> {
  @override
  final int typeId = 1;

  @override
  userisold read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return userisold(
      isold: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, userisold obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is userisoldAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
