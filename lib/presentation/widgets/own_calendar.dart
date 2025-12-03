import 'package:estigma/infrastructure/datasources/cita_datasource.dart';
import 'package:estigma/infrastructure/models/cita_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class OwnCalendar extends StatelessWidget {
  const OwnCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.timelineWorkWeek,
      dataSource: CitaDataSource(
        [
          Cita(
            paciente: 'Juan Pérez',
            zona: 'Zona Norte',
            inicio: DateTime(2025, 12, 4, 10, 0),
            fin: DateTime(2025, 12, 4, 11, 0),
            enfermero: 'Victor',
          ),
          Cita(
            paciente: 'María López',
            zona: 'Zona Sur',
            inicio: DateTime(2025, 12, 4, 12, 0),
            fin: DateTime(2025, 12, 4, 12, 30),
            enfermero: 'Agustin',
          ),
          Cita(
            paciente: 'Carlos Díaz',
            zona: 'Zona Este',
            inicio: DateTime(2025, 12, 4, 15, 0),
            fin: DateTime(2025, 12, 4, 16, 0),
            enfermero: 'Sebastian',
          ),
        ],
        <CalendarResource>[
          CalendarResource(id: 'Victor', displayName: 'Victor', color: Colors.blue),
          CalendarResource(id: 'Agustin', displayName: 'Agustin', color: Colors.green),
          CalendarResource(id: 'Sebastian', displayName: 'Sebastian', color: Colors.orange),
        ],
      ),
      resourceViewSettings: const ResourceViewSettings(showAvatar: false),
      allowDragAndDrop: true,
      allowAppointmentResize: true,
    );
  }
}
