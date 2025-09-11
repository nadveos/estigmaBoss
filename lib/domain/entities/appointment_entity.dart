class AppointmentEntity {
  final String id;
  final String title;
  final DateTime date;
  final String description;
  final String userId;
  final bool isConfirmed;

  AppointmentEntity({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.userId,
    required this.isConfirmed,
  });

  AppointmentEntity copyWith({
    String? id,
    String? title,
    DateTime? date,
    String? description,
    String? userId,
    bool? isConfirmed,
  }) {
    return AppointmentEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }
}