import 'package:estigma/infrastructure/models/calendar_appointmets_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarAppointmentsDataSource extends CalendarDataSource {
  CalendarAppointmentsDataSource(List<CalendarAppointmentsModel> citas) {
    appointments = citas.map((cita) {
      return Appointment(
        startTime: cita.inicio,
        endTime: cita.fin,
        subject: '${cita.paciente} - ${cita.zona}',
        notes: 'Enfermero: ${cita.enfermero}',
        resourceIds: [cita.enfermero], // asigna al recurso correcto
      );
    }).toList();
  }
}