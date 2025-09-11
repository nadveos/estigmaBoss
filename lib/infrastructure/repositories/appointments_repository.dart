// data/repositories/appointment_repository.dart
import 'package:estigma/infrastructure/models/appointmets_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../mappers/appointment_mapper.dart';

class AppointmentRepository {
  final String baseUrl;

  AppointmentRepository(this.baseUrl);

  Future<List<AppointmentModel>> fetchAppointments() async {
    final res = await http.get(Uri.parse('$baseUrl/collections/appointments/records'));
    final data = json.decode(res.body);
    final items = data['items'] as List;
    return items.map((e) => AppointmentMapper.fromJson(e)).toList();
  }

  Future<AppointmentModel> getAppointment(String id) async {
    final res = await http.get(Uri.parse('$baseUrl/collections/appointments/records/$id'));
    final data = json.decode(res.body);
    return AppointmentMapper.fromJson(data);
  }
  Future<void> markAsHandled(String id) async {
    final res = await http.patch(
      Uri.parse('$baseUrl/collections/appointments/records/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'isHandled': true}),
    );

    if (res.statusCode != 200) {
      throw Exception('Error al marcar como atendido: ${res.body}');
    }
  }

 
}