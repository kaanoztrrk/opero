// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipModel _$MembershipModelFromJson(Map<String, dynamic> json) =>
    MembershipModel(
      membershipId: json['membershipId'] as String,
      userId: json['userId'] as String,
      companyId: json['companyId'] as String,
      role: $enumDecode(_$MembershipRoleEnumMap, json['role']),
      invitedBy: json['invitedBy'] as String,
      joinedAt: json['joinedAt'] == null
          ? null
          : DateTime.parse(json['joinedAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$MembershipModelToJson(MembershipModel instance) =>
    <String, dynamic>{
      'membershipId': instance.membershipId,
      'userId': instance.userId,
      'companyId': instance.companyId,
      'role': _$MembershipRoleEnumMap[instance.role]!,
      'invitedBy': instance.invitedBy,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'isActive': instance.isActive,
    };

const _$MembershipRoleEnumMap = {
  MembershipRole.owner: 'owner',
  MembershipRole.admin: 'admin',
  MembershipRole.employee: 'employee',
  MembershipRole.guest: 'guest',
};
