// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  uid: json['uid'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  photoUrl: json['photoUrl'] as String?,
  role: json['role'] as String?,
  companyId: json['companyId'] as String?,
  companyRole: json['companyRole'] as String?,
  hasCompany: json['hasCompany'] as bool? ?? false,
  isActive: json['isActive'] as bool? ?? true,
  lastLogin: json['lastLogin'] == null
      ? null
      : DateTime.parse(json['lastLogin'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  settings: (json['settings'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as bool),
  ),
  modules: (json['modules'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  phoneNumber: json['phoneNumber'] as String?,
  invitedBy: json['invitedBy'] as String?,
  isSuperAdmin: json['isSuperAdmin'] as bool? ?? false,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'name': instance.name,
  'photoUrl': instance.photoUrl,
  'role': instance.role,
  'companyId': instance.companyId,
  'companyRole': instance.companyRole,
  'hasCompany': instance.hasCompany,
  'isActive': instance.isActive,
  'lastLogin': instance.lastLogin?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'settings': instance.settings,
  'modules': instance.modules,
  'phoneNumber': instance.phoneNumber,
  'invitedBy': instance.invitedBy,
  'isSuperAdmin': instance.isSuperAdmin,
};
