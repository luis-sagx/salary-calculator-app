import 'package:salary_clean_architecture/domain/entities/result_operator.dart';
import 'package:salary_clean_architecture/domain/repositories/salary_repository.dart';

class SalaryRepositoryImpl implements SalaryRepository {
  // Singleton pattern to keep data in memory across screens if the repository is re-instantiated
  // Or we can rely on the Provider to keep the instance alive.
  // Let's assume Provider will keep the repository or viewmodel alive.
  // But to be safe, let's make the list static or the class a singleton.

  static final SalaryRepositoryImpl _instance =
      SalaryRepositoryImpl._internal();
  factory SalaryRepositoryImpl() => _instance;
  SalaryRepositoryImpl._internal();

  final List<ResultOperator> _history = [];

  @override
  void saveCalculation(ResultOperator result) {
    _history.add(result);
  }

  @override
  List<ResultOperator> getHistory() {
    return List.unmodifiable(_history);
  }
}
