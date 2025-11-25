

class CasesEntities {

final String items;
final String perPage;
final String page;
final String totalItems;
final String totalPages;

CasesEntities({required this.items, required this.perPage, required this.page, required this.totalItems, required this.totalPages});

CasesEntities copyWith({String? items, String? perPage, String? page, String? totalItems, String? totalPages}) {
  return CasesEntities(
    items: items ?? this.items,
    perPage: perPage ?? this.perPage,
    page: page ?? this.page,
    totalItems: totalItems ?? this.totalItems,
    totalPages: totalPages ?? this.totalPages,
  );
}

}