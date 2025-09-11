import 'package:estigma/infrastructure/models/appointmets_model.dart';
import 'package:estigma/presentation/providers/appointmets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this); // Solo una pestaña si el admin no sube casos
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _launchWhatsApp(AppointmentModel appointment) async {
    final url = Uri.parse(
      'https://wa.me/${appointment.phone}?text=${Uri.encodeComponent(appointment.message)}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _markAsHandled(AppointmentModel appointment) async {
    final repo = ref.read(appointmentRepositoryProvider);
    await repo.markAsHandled(appointment.id);
  }

  Widget _buildConsultasList() {
    final appointmentsAsync = ref.watch(appointmentStreamProvider);

    return appointmentsAsync.when(
      data: (appointments) => appointments.isEmpty
          ? const Center(child: Text('No hay consultas pendientes'))
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final consulta = appointments[index];
                return ListTile(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(consulta.name, style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 8),
                            Text(consulta.message),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.phone),
                              label: const Text('Responder por WhatsApp'),
                              onPressed: () async {
                                await _launchWhatsApp(consulta);
                                await _markAsHandled(consulta);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  leading: const Icon(Icons.help_outline, color: Colors.orange),
                  title: Text(consulta.name),
                  subtitle: Text(consulta.message),
                  trailing: const Text('Sin responder', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                );
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultas en tiempo real'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Nuevas consultas')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildConsultasList()],
      ),
    );
  }
}