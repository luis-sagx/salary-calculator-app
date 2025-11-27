import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salary_clean_architecture/data/repositories/salary_repository_impl.dart';
import 'package:salary_clean_architecture/domain/usescases/calculate_increase_usecase.dart';
import 'package:salary_clean_architecture/presentation/routes/app_routes.dart';
import 'package:salary_clean_architecture/presentation/viewmodels/operator_viewmodel.dart';
import 'package:salary_clean_architecture/utils/themes/general_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          OperatorViewmodel(CalculateIncreaseUsecase(), SalaryRepositoryImpl()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aumento Operario',
      debugShowCheckedModeBanner: false,
      theme: GeneralTheme.lightTheme,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
