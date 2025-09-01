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
}

// Sentinel: errorMessage alanında "değiştirme" anlamı için kullanılır.
const Object _noChange = Object();

class CompanyState extends Equatable {
  final CompanyStatus status;
  final CompanyAction
  action; // Son/aktif işlem türü (UI'da hangi butonun loading olacağını bilir)
  final String? errorMessage;
  final List<CompanyModel> companies; // Nullable yerine boş liste ile gelir
  final String?
  currentUserId; // Refresh için kullanılacak aktif kullanıcı id'si

  const CompanyState({
    this.status = CompanyStatus.initial,
    this.action = CompanyAction.none,
    this.errorMessage,
    this.companies = const [],
    this.currentUserId,
  });

  CompanyState copyWith({
    CompanyStatus? status,
    CompanyAction? action,
    Object? errorMessage =
        _noChange, // null vererek temizleyebilirsin: errorMessage: null
    List<CompanyModel>? companies,
    String? currentUserId,
  }) {
    return CompanyState(
      status: status ?? this.status,
      action: action ?? this.action,
      errorMessage: identical(errorMessage, _noChange)
          ? this.errorMessage
          : errorMessage as String?,
      companies: companies ?? this.companies,
      currentUserId: currentUserId ?? this.currentUserId,
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
  ];
}
