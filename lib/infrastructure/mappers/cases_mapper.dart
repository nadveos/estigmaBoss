import 'package:estigma/infrastructure/models/cases_model.dart';

class CasesMapper {
  static CasesModel fromJson(Map<String, dynamic> json) => CasesModel(
  id: json['id'],
  name: json['name'],
  age: json['age'],
  images: json['images'],
  ulcerType: json['ulcerType'],
  testimonial: json['testimonial'],
  
  );
}
