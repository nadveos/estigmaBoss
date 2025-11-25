import 'package:estigma/presentation/providers/appointmets_provider.dart';
import 'package:estigma/presentation/providers/cases_provider.dart';
import 'package:estigma/presentation/providers/cases_stream_repository.dart';
import 'package:estigma/presentation/providers/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadAppointments = ref.watch(unreadAppointmentsCountProvider);
    double buttonSize = 140;
    final cases = ref.watch(casesStreamRepositoryProvider);
    bool isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
   
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenido'), centerTitle: true, actions: [
        IconButton(onPressed: (){
          ref.read(themeProvider.notifier).toggleTheme();
        }, icon: Icon( isDarkMode ? Icons.light_mode : Icons.dark_mode, color: isDarkMode ? Colors.white : Colors.black) )
      ],),
      body: Column(
        spacing: 10,
        children: [
          Expanded(
            child: cases.when(
              data:
                  (casesList) => ListView.builder(
                    itemCount: casesList.length,
                    itemBuilder: (context, index) {
                      final caseItem = casesList[index];
                      return ListTile(
                        title: Text(caseItem.name),
                        subtitle: Text('Edad: ${caseItem.age} - ${caseItem.typeUlcer}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            print('Caso con id : ${caseItem.id}');
                            ref.read(casesProvider.notifier).deleteCase(caseItem.id);
                          },
                        ),
                      );
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              // Botón con badge para citas pendientes
              Stack(
                children: [
                  _SquareButton(
                    label: 'Consultas',
                    icon: Icons.event_note,
                    size: buttonSize,
                    onTap: () {
                      context.push('/home');
                    },
                  ),
                  if (unreadAppointments > 0)
                    Positioned(
                      right: 12,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: Text(
                          unreadAppointments.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
              // Botón Crear Caso
              _SquareButton(
                label: 'Crear Caso',
                icon: Icons.add_box,
                size: buttonSize,
                onTap: () {
                  context.push('/cases');
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SquareButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final double size;
  final VoidCallback onTap;

  const _SquareButton({required this.label, required this.icon, required this.size, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Theme.of(context).colorScheme.onSurface),
              const SizedBox(height: 16),
              Text(label, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
