import 'package:equatable/equatable.dart';
import '../../data/models/company_model/company_model.dart';

enum CompanyStatus { initial, loading, success, failure }

enum CompanyAction {
  none,
  create,
  update,
  delete,
  addMember,
  removeMember,
  getUserCompanies,
  join,
  getCompanyById, // ✅ Yeni action
}

const Object _noChange = Object();

class CompanyState extends Equatable {
  final CompanyStatus status;
  final CompanyAction action;
  final String? errorMessage;
  final List<CompanyModel> companies;
  final String? currentUserId;
  final CompanyModel? selectedCompany; // ✅ Seçilen şirket

  const CompanyState({
    this.status = CompanyStatus.initial,
    this.action = CompanyAction.none,
    this.errorMessage,
    this.companies = const [],
    this.currentUserId,
    this.selectedCompany,
  });

  CompanyState copyWith({
    CompanyStatus? status,
    CompanyAction? action,
    Object? errorMessage = _noChange,
    List<CompanyModel>? companies,
    String? currentUserId,
    CompanyModel? selectedCompany, // ✅ copyWith parametre
  }) {
    return CompanyState(
      status: status ?? this.status,
      action: action ?? this.action,
      errorMessage: identical(errorMessage, _noChange)
          ? this.errorMessage
          : errorMessage as String?,
      companies: companies ?? this.companies,
      currentUserId: currentUserId ?? this.currentUserId,
      selectedCompany: selectedCompany ?? this.selectedCompany,
    );
  }

  bool get isLoading => status == CompanyStatus.loading;

  @override
  List<Object?> get props => [
    status,
    action,
    errorMessage,
    companies,
    currentUserId,
    selectedCompany, // ✅ props’a ekledik
  ];
}
