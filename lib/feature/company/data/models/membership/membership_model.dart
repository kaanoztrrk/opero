import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'membership_model.g.dart';

enum MembershipRole { owner, admin, employee, guest }

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class MembershipModel {
  @HiveField(0)
  final String membershipId;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String companyId;

  @HiveField(3)
  final MembershipRole role;

  @HiveField(4)
  final String invitedBy;

  @HiveField(5)
  final DateTime joinedAt;

  @HiveField(6)
  final bool isActive;

  MembershipModel({
    required this.membershipId,
    required this.userId,
    required this.companyId,
    required this.role,
    required this.invitedBy,
    DateTime? joinedAt,
    this.isActive = true,
  }) : joinedAt = joinedAt ?? DateTime.now();

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipModelFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipModelToJson(this);
}
