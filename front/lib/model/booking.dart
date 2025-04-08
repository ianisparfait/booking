import "package:booking/model/room.dart";
import "package:booking/model/table.dart";
import "package:json_annotation/json_annotation.dart";

class Booking {
  final int id;
  final String? email;
  final String phone;
  final DateTime date;
  final DateTime time;
  final int people;
  final int status;
  final Room room;

  @JsonKey(name: "booking_table")
  final Table bookingTable;

  @JsonKey(name: "first_name")
  final String firsName;

  @JsonKey(name: "last_name")
  final String lastName;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  Booking({
    required this.id,
    this.email,
    required this.phone,
    required this.date,
    required this.time,
    required this.people,
    required this.status,
    required this.room,
    required this.bookingTable,
    required this.firsName,
    required this.lastName,
    required this.createdAt,
    required this.updatedAt,
  });
}