import 'dart:async';

import 'package:estigma/infrastructure/mappers/appointment_mapper.dart';
import 'package:estigma/infrastructure/models/appointmets_model.dart';
import 'package:estigma/infrastructure/repositories/appointments_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

final appointmentStreamProvider = StreamProvider<List<AppointmentModel>>((ref) {
  final client = PocketBase('https://testauth.meapp.com.ar');
  final controller = StreamController<List<AppointmentModel>>.broadcast();

  Future<void> loadAppointments() async {
    final records = await client.collection('appointments').getList(
      filter: 'isHandled=False', sort: '-created',
    );
    final items = records.items.map((item) => AppointmentMapper.fromJson(item.toJson())).toList();
    print('Cargando ${items.length} citas'); // Mensaje de depuración
    controller.add(items);
  }

  client.realtime.subscribe('appointments', (e) async {
    // ignore: avoid_print
    print('Evento recibido : ${e.event}');
    await loadAppointments();
  });

  loadAppointments();

  ref.onDispose(() {
    client.realtime.unsubscribe('*');
    controller.close();
  });

  return controller.stream;
});
final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  return AppointmentRepository('https://testauth.meapp.com.ar');
});

final appointmentsProvider = FutureProvider<List<AppointmentModel>>((ref) async {
  final repo = ref.watch(appointmentRepositoryProvider);
  return repo.fetchAppointments();
});
final unreadAppointmentsCountProvider = Provider<int>((ref) {
  final appointmentsAsync = ref.watch(appointmentStreamProvider);
  return appointmentsAsync.when(
    data: (appointments) => appointments.length,
    loading: () => 0,
    error: (error, stack) => 0,
  );
});