import 'package:estigma/infrastructure/models/cita_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CitaDataSource extends CalendarDataSource {
  CitaDataSource(List<Cita> citas, List<CalendarResource> calendarResources) {
    appointments = citas;
    resources = calendarResources;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].inicio;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].fin;
  }

  @override
  String getSubject(int index) {
    final cita = appointments![index] as Cita;
    return '${cita.paciente} - ${cita.zona}';
  }

  @override
  Color getColor(int index) {
    final cita = appointments![index] as Cita;
    // Return color based on nurse
    switch (cita.enfermero) {
      case 'Victor':
        return Colors.blue;
      case 'Agustin':
        return Colors.green;
      case 'Sebastian':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  List<Object>? getResourceIds(int index) {
    final cita = appointments![index] as Cita;
    return [cita.enfermero];
  }
}
