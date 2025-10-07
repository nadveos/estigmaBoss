import 'package:estigma/infrastructure/models/appointmets_model.dart';
import 'package:pocketbase/pocketbase.dart';

import '../mappers/appointment_mapper.dart';

class AppointmentRepository {
  final PocketBase client;

  AppointmentRepository(this.client);

  Future<List<AppointmentModel>> fetchAppointments() async {
    final records = await client.collection('appointments').getList(filter: 'isHandled=False', sort: '-created');
    return records.items.map((e) => AppointmentMapper.fromJson(e.toJson())).toList();
  }

  Future<AppointmentModel> getAppointment(String id) async {
    final record = await client.collection('appointments').getOne(id);
    return AppointmentMapper.fromJson(record.toJson());
  }
  Future<void> markAsHandled(String id) async {
    await client.collection('appointments').update(id, body: {'isHandled': true});
  }

 
}