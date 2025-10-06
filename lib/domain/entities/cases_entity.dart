class CasesEntity {
  final String id;
  final String name;
  final String ulcerType;
  final String testimonial;

  CasesEntity({required this.id, required this.name, required this.ulcerType, required this.testimonial});

  CasesEntity copyWith({String? id, String? name, String? ulcerType, String? testimonial}) {
    return CasesEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      ulcerType: ulcerType ?? this.ulcerType,
      testimonial: testimonial ?? this.testimonial,
    
    );
  }
}
