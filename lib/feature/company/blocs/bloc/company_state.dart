import 'package:equatable/equatable.dart';
import '../../data/models/company_model.dart';

enum CompanyStatus { initial, loading, success, failure }

class CompanyState extends Equatable {
  final CompanyStatus status;
  final String? errorMessage;
  final List<CompanyModel>? companies;

  const CompanyState({
    this.status = CompanyStatus.initial,
    this.errorMessage,
    this.companies,
  });

  CompanyState copyWith({
    CompanyStatus? status,
    String? errorMessage,
    List<CompanyModel>? companies,
  }) {
    return CompanyState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      companies: companies ?? this.companies,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, companies];
}
