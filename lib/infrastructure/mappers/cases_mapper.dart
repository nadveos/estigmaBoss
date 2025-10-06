import 'package:estigma/infrastructure/models/cases_model.dart';

class CasesMapper {
  static CasesModel fromJson(Map<String, dynamic> json) => CasesModel(
  id: json['id'],
  name: json['name'],
  ulcerType: json['ulcerType'],
  testimonial: json['testimonial'],
  
  );
}
