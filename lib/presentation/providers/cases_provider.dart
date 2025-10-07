import 'package:estigma/domain/entities/cases_entity.dart';
import 'package:estigma/infrastructure/repositories/cases_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. State
class CasesState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  CasesState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  CasesState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return CasesState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// 2. Notifier
class CasesNotifier extends StateNotifier<CasesState> {
  final CasesRepository casesRepository;

  CasesNotifier(this.casesRepository) : super(CasesState());

  Future<void> createCase(CasesEntity caseData) async {
    state = state.copyWith(isLoading: true, errorMessage: null, isSuccess: false);
    try {
      await casesRepository.createCase(caseData);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

// 3. Provider
final casesRepositoryProvider = Provider<CasesRepository>((ref) {
  // Replace with your actual API URL
  return CasesRepository('http://127.0.0.1:8090/api');
});

final casesProvider = StateNotifierProvider<CasesNotifier, CasesState>((ref) {
  final casesRepository = ref.watch(casesRepositoryProvider);
  return CasesNotifier(casesRepository);
});
