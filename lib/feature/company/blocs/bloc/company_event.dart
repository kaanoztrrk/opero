import 'package:equatable/equatable.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object?> get props => [];
}

/// Şirket oluşturma
class CreateCompany extends CompanyEvent {
  final String name;
  final String ownerId;

  const CreateCompany({required this.name, required this.ownerId});

  @override
  List<Object?> get props => [name, ownerId];
}

/// Kullanıcının şirket listesi
class GetUserCompanies extends CompanyEvent {
  final String userId;

  const GetUserCompanies({required this.userId});

  @override
  List<Object?> get props => [userId];
}

/// Şirkete katılma
class JoinCompany extends CompanyEvent {
  final String userId;
  final String companyId;
  final String invitedBy;

  const JoinCompany({
    required this.userId,
    required this.companyId,
    required this.invitedBy,
  });

  @override
  List<Object?> get props => [userId, companyId, invitedBy];
}

class RefreshCompanies extends CompanyEvent {
  final String userId;

  const RefreshCompanies(this.userId);

  @override
  List<Object> get props => [userId];
}

class GetCompanyById extends CompanyEvent {
  final String companyId;

  GetCompanyById(this.companyId);
}
