import 'package:estigma/infrastructure/mappers/appointment_mapper.dart';
import 'package:estigma/infrastructure/models/appointmets_model.dart';

class AppointmentListResponse {
  final List<AppointmentModel> items;
  final int page;
  final int perPage;
  final int totalItems;
  final int totalPages;

  AppointmentListResponse({
    required this.items,
    required this.page,
    required this.perPage,
    required this.totalItems,
    required this.totalPages,
  });

  factory AppointmentListResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentListResponse(
      items: (json['items'] as List)
          .map((item) => AppointmentMapper.fromJson(item))
          .toList(),
      page: json['page'],
      perPage: json['perPage'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }
}