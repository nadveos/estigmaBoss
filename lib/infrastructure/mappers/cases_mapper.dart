
import 'package:estigma/infrastructure/models/cases_model.dart';

class CasesMapper {
  static CasesModel fromJson(Map<String, dynamic> json) => CasesModel(
    items: json['items'],
    perPage: json['perPage'],
    page: json['page'],
    totalItems: json['totalItems'],
    totalPages: json['totalPages'],
  );
}