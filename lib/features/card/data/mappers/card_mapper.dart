import 'package:loteria_app/features/card/data/models/card_model.dart';
import 'package:loteria_app/features/card/data/dto/card_dto.dart';
import 'package:loteria_app/features/card/domain/entities/card_entity.dart';

/// =========================
/// DTO → MODEL
/// =========================
extension CardDtoToModel on CardDto {
  CardModel toModel() {
    return CardModel(
      id: id,
      setId: setId,
      name: name,
      imageUrl: imageUrl,
      number: number,
      isSynced: true, // viene del server
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

/// =========================
/// MODEL → DTO
/// =========================
extension CardModelToDto on CardModel {
  CardDto toDto() {
    return CardDto(
      id: id,
      setId: setId,
      name: name,
      imageUrl: imageUrl,
      number: number,
      isSynced: isSynced,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

/// =========================
/// MODEL → ENTITY
/// =========================
extension CardModelToEntity on CardModel {
  CardEntity toEntity() {
    return CardEntity(
      id: id,
      setId: setId,
      name: name,
      imageUrl: imageUrl,
      number: number,
      isSynced: isSynced,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

/// =========================
/// ENTITY → MODEL
/// =========================
extension CardEntityToModel on CardEntity {
  CardModel toModel() {
    return CardModel(
      id: id,
      setId: setId,
      name: name,
      imageUrl: imageUrl,
      number: number,
      isSynced: isSynced,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

/// =========================
/// LIST MAPPERS
/// =========================

/// DTO → MODEL LIST
extension CardDtoListMapper on List<CardDto> {
  List<CardModel> toModelList() {
    return map((e) => e.toModel()).toList();
  }
}

/// MODEL → DTO LIST
extension CardModelListToDto on List<CardModel> {
  List<CardDto> toDtoList() {
    return map((e) => e.toDto()).toList();
  }
}

/// MODEL → ENTITY LIST
extension CardModelListMapper on List<CardModel> {
  List<CardEntity> toEntityList() {
    return map((e) => e.toEntity()).toList();
  }
}

/// ENTITY → MODEL LIST
extension CardEntityListMapper on List<CardEntity> {
  List<CardModel> toModelList() {
    return map((e) => e.toModel()).toList();
  }
}