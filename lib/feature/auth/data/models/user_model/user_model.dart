import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class UserModel {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String? photoUrl;

  @HiveField(4)
  final String role; // "user" | "super_admin"

  @HiveField(5)
  final bool isActive;

  @HiveField(6)
  final DateTime? lastLogin;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final DateTime updatedAt;

  @HiveField(9)
  final String? phoneNumber;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.photoUrl,
    this.role = "user",
    this.isActive = true,
    this.lastLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.phoneNumber,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
