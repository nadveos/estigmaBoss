class AppointmentModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String message;
  final DateTime created;
  final DateTime updated;
  final bool isHandled;

  AppointmentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
    required this.created,
    required this.updated,
    required this.isHandled,
  });
}