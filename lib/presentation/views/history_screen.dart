import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salary_clean_architecture/presentation/viewmodels/operator_viewmodel.dart';
import 'package:salary_clean_architecture/utils/themes/schema_color.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.watch<OperatorViewmodel>().history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Cálculos'),
        backgroundColor: SchemaColor.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: history.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No hay cálculos registrados',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 4,
                  ),
                  child: ListTile(
                    title: Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Salario Base: \$${item.originalSalary.toStringAsFixed(2)}',
                        ),
                        Text('Total: \$${item.totalSalary.toStringAsFixed(2)}'),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //texto de aumento
                        const Text(
                          'Aumento:',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          '+ \$${item.increase.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: SchemaColor.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
