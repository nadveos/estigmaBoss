import 'package:flutter/material.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Caso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _CasesForm(),
      ),
    );
  }
}

class _CasesForm extends StatefulWidget {
  @override
  State<_CasesForm> createState() => _CasesFormState();
}

class _CasesFormState extends State<_CasesForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ulcerTypeController = TextEditingController();
  final TextEditingController _testimonialController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ulcerTypeController.dispose();
    _testimonialController.dispose();
    super.dispose();
  }

  // ignore: unused_element
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Procesando datos')),
      );
      // Here you would typically send the data to a backend or save it locally
      print('Name: ${_nameController.text}');
      print('Ulcer Type: ${_ulcerTypeController.text}');
      print('Testimonial: ${_testimonialController.text}');

      // Clear the form
      _nameController.clear();
      _ulcerTypeController.clear();
      _testimonialController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nombre del Paciente',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el nombre del paciente';
                }
              return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: (){}, child: Text('data'),),
            const SizedBox(height: 16)
          
        ],
      ),
    );
  }
}
            
            