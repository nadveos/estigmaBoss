import 'package:http/http.dart';

class CaseEntity {
  final String name;
  final String age;
  final List<MultipartFile>? imgs;
  final String typeUlcer;
  final String testimonial;

  CaseEntity({ required this.name, required this.typeUlcer, required this.age, required this.testimonial, this.imgs});

  CaseEntity copyWith({String? id, String? name, String? age,String? typeUlcer, String? testimonial, List<MultipartFile>? images}) {
    return CaseEntity(
      name: name ?? this.name,
      age: age ?? this.age,
      imgs: images ?? imgs,
      typeUlcer: typeUlcer ?? this.typeUlcer,
      testimonial: testimonial ?? this.testimonial,
    );
  }
}
