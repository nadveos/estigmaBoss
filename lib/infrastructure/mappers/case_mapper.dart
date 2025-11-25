import 'package:estigma/infrastructure/models/case_model.dart';

class CaseMapper {
  static CaseModel fromJson(Map<String, dynamic> json) => CaseModel(
  id: json['id'] ?? '', // Add id field from JSON
  name: json['name'],
  age: json['age'],
  imgs: null, // The response has a list, but the model expects a single file.
  typeUlcer: json['type_ulcer'],
  testimonial: json['testimonial'],
  
  );
}
