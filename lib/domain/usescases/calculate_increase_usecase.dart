import 'package:salary_clean_architecture/domain/entities/operator.dart';
import 'package:salary_clean_architecture/domain/entities/result_operator.dart';

class CalculateIncreaseUsecase {
  ResultOperator call(Operator operator) {
    double increase = 0.0;

    if (operator.antique >= 10) {
      increase = operator.salary * 0.2;
    } else {
      increase = operator.salary * 0.05;
    }

    double totalSalary = operator.salary + increase;

    return ResultOperator(
      name: operator.name,
      originalSalary: operator.salary,
      years: operator.antique,
      increase: increase,
      totalSalary: totalSalary,
    );
  }
}
