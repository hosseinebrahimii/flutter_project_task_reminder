// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeEnumAdapter extends TypeAdapter<TaskTypeEnum> {
  @override
  final int typeId = 3;

  @override
  TaskTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskTypeEnum.workout;
      case 1:
        return TaskTypeEnum.work;
      case 2:
        return TaskTypeEnum.payments;
      case 3:
        return TaskTypeEnum.meeting;
      case 4:
        return TaskTypeEnum.relax;
      default:
        return TaskTypeEnum.workout;
    }
  }

  @override
  void write(BinaryWriter writer, TaskTypeEnum obj) {
    switch (obj) {
      case TaskTypeEnum.workout:
        writer.writeByte(0);
        break;
      case TaskTypeEnum.work:
        writer.writeByte(1);
        break;
      case TaskTypeEnum.payments:
        writer.writeByte(2);
        break;
      case TaskTypeEnum.meeting:
        writer.writeByte(3);
        break;
      case TaskTypeEnum.relax:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
