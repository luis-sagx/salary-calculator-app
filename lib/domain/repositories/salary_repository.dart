import 'package:salary_clean_architecture/domain/entities/result_operator.dart';

abstract class SalaryRepository {
  void saveCalculation(ResultOperator result);
  List<ResultOperator> getHistory();
}
