// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      state: fields[0] as int?,
      id: fields[1] as String?,
      stateId: fields[2] as String?,
      stateInfo: fields[3] as StateInfo?,
      userParams: fields[4] as UserParams?,
      message: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.state)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.stateId)
      ..writeByte(3)
      ..write(obj.stateInfo)
      ..writeByte(4)
      ..write(obj.userParams)
      ..writeByte(5)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StateInfoAdapter extends TypeAdapter<StateInfo> {
  @override
  final int typeId = 2;

  @override
  StateInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StateInfo(
      sId: fields[0] as String?,
      name: fields[1] as String?,
      code: fields[2] as String?,
      emaId: fields[3] as String?,
      active: fields[4] as int?,
      tCreated: fields[5] as String?,
      aGENT: fields[6] as String?,
      iP: fields[7] as String?,
      emergencyNumbers: fields[8] as String?,
      headerImage: fields[9] as String?,
      helpUrl: fields[10] as String?,
      problemReasons: (fields[11] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, StateInfo obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.emaId)
      ..writeByte(4)
      ..write(obj.active)
      ..writeByte(5)
      ..write(obj.tCreated)
      ..writeByte(6)
      ..write(obj.aGENT)
      ..writeByte(7)
      ..write(obj.iP)
      ..writeByte(8)
      ..write(obj.emergencyNumbers)
      ..writeByte(9)
      ..write(obj.headerImage)
      ..writeByte(10)
      ..write(obj.helpUrl)
      ..writeByte(11)
      ..write(obj.problemReasons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StateInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserParamsAdapter extends TypeAdapter<UserParams> {
  @override
  final int typeId = 3;

  @override
  UserParams read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserParams(
      sId: fields[0] as String?,
      boothid: fields[1] as int?,
      boothRefno: fields[2] as String?,
      boothName: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      boothStatus: fields[5] as int?,
      totalVotersCount: fields[6] as int?,
      latitude: fields[7] as String?,
      longitude: fields[8] as String?,
      maleVotersCount: fields[9] as int?,
      femaleVotersCount: fields[10] as int?,
      updateId: fields[11] as int?,
      updateTime: fields[12] as String?,
      fetched: fields[13] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserParams obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.boothid)
      ..writeByte(2)
      ..write(obj.boothRefno)
      ..writeByte(3)
      ..write(obj.boothName)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.boothStatus)
      ..writeByte(6)
      ..write(obj.totalVotersCount)
      ..writeByte(7)
      ..write(obj.latitude)
      ..writeByte(8)
      ..write(obj.longitude)
      ..writeByte(9)
      ..write(obj.maleVotersCount)
      ..writeByte(10)
      ..write(obj.femaleVotersCount)
      ..writeByte(11)
      ..write(obj.updateId)
      ..writeByte(12)
      ..write(obj.updateTime)
      ..writeByte(13)
      ..write(obj.fetched);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserParamsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
