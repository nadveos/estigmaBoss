import 'package:http/http.dart';

class CasesEntity {
  final String id;
  final String name;
  final int age;
  final MultipartFile? images;
  final String ulcerType;
  final String testimonial;

  CasesEntity({required this.id, required this.name, required this.ulcerType, required this.age, required this.testimonial, this.images});

  CasesEntity copyWith({String? id, String? name, int? age,String? ulcerType, String? testimonial, MultipartFile? images}) {
    return CasesEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      images: images ?? this.images,
      ulcerType: ulcerType ?? this.ulcerType,
      testimonial: testimonial ?? this.testimonial,
    );
  }
}
