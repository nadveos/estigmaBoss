import 'package:estigma/infrastructure/models/cases_model.dart';

class CasesMapper {
  static CasesModel fromJson(Map<String, dynamic> json) => CasesModel(
  name: json['name'],
  age: json['age'],
  imgs: null, // The response has a list, but the model expects a single file.
  type_ulcer: json['type_ulcer'],
  testimonial: json['testimonial'],
  
  );
}
