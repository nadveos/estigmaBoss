
class CalendarAppointmentsModel {
  final String paciente;
  final String zona;
  final DateTime inicio;
  final DateTime fin;
  final String enfermero;

  CalendarAppointmentsModel({
    required this.paciente,
    required this.zona,
    required this.inicio,
    required this.fin,
    required this.enfermero,
  });
}