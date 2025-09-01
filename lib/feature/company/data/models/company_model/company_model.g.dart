// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
  companyId: json['companyId'] as String,
  name: json['name'] as String,
  createdBy: json['createdBy'] as String,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  logoUrl: json['logoUrl'] as String?,
  modules: (json['modules'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  settings: json['settings'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
      'name': instance.name,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'logoUrl': instance.logoUrl,
      'modules': instance.modules,
      'settings': instance.settings,
    };
