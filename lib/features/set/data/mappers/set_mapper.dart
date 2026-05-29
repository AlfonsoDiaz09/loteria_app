import 'package:loteria_app/features/set/data/dto/set_dto.dart';
import 'package:loteria_app/features/set/data/models/set_model.dart';
import 'package:loteria_app/features/set/domain/entities/set_entity.dart';

/// =========================
/// DTO → MODEL
/// =========================
extension SetDtoToModel on SetDto {
  SetModel toModel() {
    return SetModel(
      id: id,
      name: name,
      description: description,
      sesionId: sessionId,
      isDefault: isDefault,
    );
  }
}

/// =========================
/// MODEL → ENTITY
/// =========================
extension SetModelToEntity on SetModel {
  SetEntity toEntity() {
    return SetEntity(
      id: id,
      name: name,
      description: description,
      sessionId: sesionId,
      isDefault: isDefault,
    );
  }
}

/// =========================
/// ENTITY → MODEL
/// =========================
extension SetEntityToModel on SetEntity {
  SetModel toModel() {
    return SetModel(
      id: id,
      name: name,
      description: description,
      sesionId: sessionId,
      isDefault: isDefault,
    );
  }
}

/// =========================
/// LIST MAPPERS
/// =========================

extension SetDtoListMapper on List<SetDto> {
  List<SetModel> toModelList() {
    return map((e) => e.toModel()).toList();
  }
}

extension SetModelListMapper on List<SetModel> {
  List<SetEntity> toEntityList() {
    return map((e) => e.toEntity()).toList();
  }
}

extension SetEntityListMapper on List<SetEntity> {
  List<SetModel> toModelList() {
    return map((e) => e.toModel()).toList();
  }
}