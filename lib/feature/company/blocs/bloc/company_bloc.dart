import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/company_repository.dart';
import 'company_event.dart';
import 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository _repository;

  CompanyBloc({required CompanyRepository repository})
    : _repository = repository,
      super(const CompanyState()) {
    on<CreateCompany>(_onCreateCompany);
    on<JoinCompany>(_onJoinCompany);
    on<GetUserCompanies>(_onGetUserCompanies);
    on<RefreshCompanies>(_onRefreshCompanies);
    on<GetCompanyById>(_onGetCompanyById);
  }

  Future<void> _onCreateCompany(
    CreateCompany event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: CompanyStatus.loading));
    try {
      final company = await _repository.createCompany(
        name: event.name,
        ownerId: event.ownerId,
      );
      emit(
        state.copyWith(
          status: CompanyStatus.success,
          companies: [...state.companies, company],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onJoinCompany(
    JoinCompany event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: CompanyStatus.loading));
    try {
      await _repository.joinCompany(
        userId: event.userId,
        companyId: event.companyId,
        invitedBy: event.invitedBy,
      );

      final updatedCompanies = await _repository.getUserCompanies(event.userId);
      emit(
        state.copyWith(
          status: CompanyStatus.success,
          companies: updatedCompanies,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetUserCompanies(
    GetUserCompanies event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: CompanyStatus.loading));
    try {
      final companies = await _repository.getUserCompanies(event.userId);
      emit(state.copyWith(status: CompanyStatus.success, companies: companies));
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefreshCompanies(
    RefreshCompanies event,
    Emitter<CompanyState> emit,
  ) async {
    try {
      final companies = await _repository.getUserCompanies(event.userId);
      emit(state.copyWith(status: CompanyStatus.success, companies: companies));
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetCompanyById(
    GetCompanyById event,
    Emitter<CompanyState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CompanyStatus.loading,
        action: CompanyAction.getUserCompanies,
      ),
    );
    try {
      final company = await _repository.getCompanyById(event.companyId);
      emit(
        state.copyWith(
          status: CompanyStatus.success,
          action: CompanyAction.getCompanyById,
          selectedCompany: company, // state’e seçilen company ekledik
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          action: CompanyAction.getCompanyById,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
