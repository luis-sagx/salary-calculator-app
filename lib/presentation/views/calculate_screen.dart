import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salary_clean_architecture/presentation/viewmodels/operator_viewmodel.dart';
import 'package:salary_clean_architecture/utils/themes/schema_color.dart';
import 'package:salary_clean_architecture/utils/themes/typographic.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _salaryController = TextEditingController();
  double? _selectedTenure;

  final List<Map<String, dynamic>> _tenureOptions = [
    {'label': 'Menos de 1 año', 'value': 0.5},
    {'label': 'De 1 a 2 años', 'value': 1.5},
    {'label': 'De 2 a 5 años', 'value': 3.5},
    {'label': 'De 5 a 10 años', 'value': 7.5},
    {'label': '10 años o más', 'value': 15.0},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  void _calculate() {
    if (_formKey.currentState!.validate() && _selectedTenure != null) {
      final name = _nameController.text;
      final salary = double.parse(_salaryController.text);

      context.read<OperatorViewmodel>().calculate(
        name,
        salary,
        _selectedTenure!,
      );

      // Show result dialog
      final result = context.read<OperatorViewmodel>().result;
      if (result != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Resultado del Cálculo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Operario: ${result.name}'),
                const SizedBox(height: 8),
                Text(
                  'Salario Original: \$${result.originalSalary.toStringAsFixed(2)}',
                ),
                Text('Aumento: \$${result.increase.toStringAsFixed(2)}'),
                const Divider(),
                Text(
                  'Salario Total: \$${result.totalSalary.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );

        // Clear form
        _nameController.clear();
        _salaryController.clear();
        setState(() {
          _selectedTenure = null;
        });
      }
    } else if (_selectedTenure == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor seleccione la antiguedad')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcular Aumento'),
        backgroundColor: SchemaColor.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Ingrese los datos del operario',
                style: Typographic.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese el nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _salaryController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Salario Actual',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Ingrese el salario';
                  if (double.tryParse(value) == null)
                    return 'Ingrese un número válido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Antiguedad',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: SchemaColor.darkTextColor.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: _tenureOptions.map((option) {
                    return RadioListTile<double>(
                      title: Text(option['label']),
                      value: option['value'],
                      groupValue: _selectedTenure,
                      activeColor: SchemaColor.secondaryColor,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      dense: true,
                      onChanged: (value) =>
                          setState(() => _selectedTenure = value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _calculate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: SchemaColor.secondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Calcular Aumento',
                  style: Typographic.textTheme.bodyMedium?.copyWith(
                    color: SchemaColor.darkTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
