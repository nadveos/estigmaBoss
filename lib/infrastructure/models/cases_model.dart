class CasesModel {
  final String items;
  final String perPage;
  final String page;
  final String totalItems;
  final String totalPages;

  CasesModel({
    required this.items,
    required this.perPage,
    required this.page,
    required this.totalItems,
    required this.totalPages,
  });
  factory CasesModel.fromJson(Map<String, dynamic> json) => CasesModel(
    items: json['items'],
    perPage: json['perPage'],
    page: json['page'],
    totalItems: json['totalItems'],
    totalPages: json['totalPages'],
  );
}
