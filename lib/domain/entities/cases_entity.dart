import 'package:http/http.dart';

class CasesEntity {
  final String name;
  final String age;
  final List<MultipartFile>? imgs;
  final String type_ulcer;
  final String testimonial;

  CasesEntity({ required this.name, required this.type_ulcer, required this.age, required this.testimonial, this.imgs});

  CasesEntity copyWith({String? id, String? name, String? age,String? ulcerType, String? testimonial, List<MultipartFile>? images}) {
    return CasesEntity(
      name: name ?? this.name,
      age: age ?? this.age,
      imgs: images ?? imgs,
      type_ulcer: ulcerType ?? type_ulcer,
      testimonial: testimonial ?? this.testimonial,
    );
  }
}
