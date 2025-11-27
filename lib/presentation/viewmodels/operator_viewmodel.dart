import 'package:flutter/material.dart';
import 'package:salary_clean_architecture/domain/entities/operator.dart';
import 'package:salary_clean_architecture/domain/entities/result_operator.dart';
import 'package:salary_clean_architecture/domain/repositories/salary_repository.dart';
import 'package:salary_clean_architecture/domain/usescases/calculate_increase_usecase.dart';

class OperatorViewmodel extends ChangeNotifier {
  final CalculateIncreaseUsecase _usecase;
  final SalaryRepository _repository;

  OperatorViewmodel(this._usecase, this._repository);

  ResultOperator? _result;
  ResultOperator? get result => _result;

  List<ResultOperator> get history => _repository.getHistory();

  void calculate(String name, double salary, double antique) {
    final operator = Operator(name: name, salary: salary, antique: antique);
    _result = _usecase(operator);
    _repository.saveCalculation(_result!);
    notifyListeners();
  }
}
