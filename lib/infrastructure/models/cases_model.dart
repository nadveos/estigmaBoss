import 'package:http/http.dart';

class CasesModel {
  final String id;
  final String name;
  final String age;
  final MultipartFile? images;
  final String ulcerType;
  final String testimonial;

  CasesModel({required this.id, required this.name, required this.age, required this.images,required this.ulcerType, required this.testimonial});
}
