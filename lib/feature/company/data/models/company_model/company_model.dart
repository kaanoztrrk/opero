import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class CompanyModel {
  @HiveField(0)
  final String companyId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String createdBy;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final DateTime updatedAt;

  @HiveField(5)
  final String? logoUrl;

  @HiveField(6)
  final List<String>? modules;

  @HiveField(7)
  final Map<String, dynamic>? settings;

  CompanyModel({
    required this.companyId,
    required this.name,
    required this.createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.logoUrl,
    this.modules,
    this.settings,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
