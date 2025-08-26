import 'package:json_annotation/json_annotation.dart';

part 'company_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyModel {
  final String id;
  final String name;
  final String? description;
  final String ownerId; // UserModel.uid
  final List<String>? members; // UserModel.uid listesi
  final DateTime createdAt;
  final DateTime? updatedAt;

  CompanyModel({
    required this.id,
    required this.name,
    required this.ownerId,
    this.description,
    this.members,
    required this.createdAt,
    this.updatedAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
