import 'package:estigma/infrastructure/models/appointmets_model.dart';

class AppointmentMapper {
  static AppointmentModel fromJson(Map<String, dynamic> json) => AppointmentModel(
  id: json['id'],
  name: json['name'],
  email: json['email'],
  phone: json['phone'],
  message: json['message'],
  created: DateTime.parse(json['created']),
  updated: DateTime.parse(json['updated']),
  isHandled: json['isHandled'] ?? false,
);
}