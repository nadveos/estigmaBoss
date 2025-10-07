import 'package:http/http.dart';

class CasesModel {
  final String name;
  final String age;
  final MultipartFile? imgs;
  final String type_ulcer;
  final String testimonial;

  CasesModel({ required this.name, required this.age, this.imgs,required this.type_ulcer, required this.testimonial});
}
