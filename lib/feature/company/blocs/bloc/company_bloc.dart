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
    on<UpdateCompany>(_onUpdateCompany);
    on<DeleteCompany>(_onDeleteCompany);
    on<AddMember>(_onAddMember);
    on<RemoveMember>(_onRemoveMember);
  }

  Future<void> _onCreateCompany(
    CreateCompany event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: CompanyStatus.loading));
    try {
      await _repository.createCompany(event.company);
      emit(state.copyWith(status: CompanyStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateCompany(
    UpdateCompany event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: CompanyStatus.loading));
    try {
      await _repository.updateCompany(event.company);
      emit(state.copyWith(status: CompanyStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDeleteCompany(
    DeleteCompany event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: CompanyStatus.loading));
    try {
      await _repository.deleteCompany(event.companyId);
      emit(state.copyWith(status: CompanyStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddMember(AddMember event, Emitter<CompanyState> emit) async {
    emit(state.copyWith(status: CompanyStatus.loading));
    try {
      await _repository.addMember(event.companyId, event.userId);
      emit(state.copyWith(status: CompanyStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRemoveMember(
    RemoveMember event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: CompanyStatus.loading));
    try {
      await _repository.removeMember(event.companyId, event.userId);
      emit(state.copyWith(status: CompanyStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
