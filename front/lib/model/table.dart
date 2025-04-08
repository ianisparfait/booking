import "package:json_annotation/json_annotation.dart";
import "package:booking/model/room.dart";

enum Shape {
  square,
  rectangle,
  round
}

class Table {
  final int id;
  final String? name;
  final String? description;
  final int capacity;
  final Shape shape;
  final Room? room;

  @JsonKey(name: "position_y")
  final int? positionY;

  @JsonKey(name: "position_x")
  final int? positionX;

  final int status;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  Table({
    required this.id,
    this.name,
    this.description,
    required this.capacity,
    required this.shape,
    this.room,
    this.positionY,
    this.positionX,
    required this.status,
    required this.createdAt,
    required this.updatedAt
  });
}