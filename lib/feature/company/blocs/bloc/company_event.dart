import 'package:equatable/equatable.dart';
import '../../data/models/company_model.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object?> get props => [];
}

class CreateCompany extends CompanyEvent {
  final CompanyModel company;

  const CreateCompany(this.company);

  @override
  List<Object?> get props => [company];
}

class UpdateCompany extends CompanyEvent {
  final CompanyModel company;

  const UpdateCompany(this.company);

  @override
  List<Object?> get props => [company];
}

class DeleteCompany extends CompanyEvent {
  final String companyId;

  const DeleteCompany(this.companyId);

  @override
  List<Object?> get props => [companyId];
}

class AddMember extends CompanyEvent {
  final String companyId;
  final String userId;

  const AddMember(this.companyId, this.userId);

  @override
  List<Object?> get props => [companyId, userId];
}

class RemoveMember extends CompanyEvent {
  final String companyId;
  final String userId;

  const RemoveMember(this.companyId, this.userId);

  @override
  List<Object?> get props => [companyId, userId];
}
