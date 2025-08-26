import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? photoUrl;

  // Global rol
  final String? role; // "member" | "admin" | "guest"
  // Şirket bilgileri
  final String? companyId;
  final String? companyRole; // "owner" | "manager" | "employee"
  final bool hasCompany;

  final bool isActive;
  final DateTime? lastLogin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Admin tarafından kontrol edilebilecek erişimler
  final Map<String, bool>? settings;

  final List<String>? modules; // modüller: "crm", "finance", "hr"
  final String? phoneNumber;
  final String? invitedBy;
  final bool isSuperAdmin;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.photoUrl,
    this.role,
    this.companyId,
    this.companyRole,
    this.hasCompany = false,
    this.isActive = true,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.settings,
    this.modules,
    this.phoneNumber,
    this.invitedBy,
    this.isSuperAdmin = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
