import 'dart:io';

import 'package:estigma/domain/entities/cases_entity.dart';
import 'package:estigma/presentation/providers/cases_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Caso')),
      body: Padding(padding: const EdgeInsets.all(16.0), child: _CasesForm()),
    );
  }
}

class _CasesForm extends ConsumerStatefulWidget {
  @override
  _CasesFormState createState() => _CasesFormState();
}

class _CasesFormState extends ConsumerState<_CasesForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ulcerTypeController = TextEditingController();
  final TextEditingController _testimonialController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  List<File> _selectedImages = [];

  @override
  void dispose() {
    _nameController.dispose();
    _ulcerTypeController.dispose();
    _testimonialController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      List<http.MultipartFile> imageFiles = [];
      if (_selectedImages.isNotEmpty) {
        for (var imageFile in _selectedImages) {
          imageFiles.add(await http.MultipartFile.fromPath('imgs', imageFile.path));
        }
      }

      final caseData = CasesEntity(
        name: _nameController.text,
        age: _ageController.text,
        type_ulcer: _ulcerTypeController.text,
        testimonial: _testimonialController.text,
        imgs: imageFiles.isNotEmpty ? imageFiles : null,
      );

      ref.read(casesProvider.notifier).createCase(caseData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final casesState = ref.watch(casesProvider);

    ref.listen<CasesState>(casesProvider, (previous, next) {
      if (next.isSuccess) {
        _nameController.clear();
        _ulcerTypeController.clear();
        _testimonialController.clear();
        _ageController.clear();
        setState(() {
          _selectedImages = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Caso creado con éxito')));
      } else if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

    return Form(
      key: _formKey,
      child: AbsorbPointer(
        absorbing: casesState.isLoading,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre del Paciente', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre del paciente';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Edad', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la edad';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ulcerTypeController,
              decoration: const InputDecoration(labelText: 'Tipo de Úlcera', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el tipo de úlcera';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _testimonialController,
              decoration: const InputDecoration(labelText: 'Testimonio', border: OutlineInputBorder()),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el testimonio';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _selectedImages.isNotEmpty
                ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, index) {
                    return Image.file(_selectedImages[index]);
                  },
                )
                : const Text('No se ha seleccionado ninguna imagen.'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _pickImage, child: const Text('Seleccionar Imagenes')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: 
                casesState.isLoading ? null : _submitForm,
              child: casesState.isLoading ? const CircularProgressIndicator() : const Text('Enviar Caso'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
