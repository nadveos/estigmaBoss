import 'package:http/http.dart';



class CaseModel {
  final String id;
  final String name;
  final String age;
  final MultipartFile? imgs;
  final String typeUlcer;
  final String testimonial;

  CaseModel({ required this.id, required this.name, required this.age, this.imgs,required this.typeUlcer, required this.testimonial});
}
