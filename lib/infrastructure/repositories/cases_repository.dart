



import 'dart:convert';

import 'package:estigma/domain/entities/cases_entity.dart';
import 'package:estigma/infrastructure/mappers/cases_mapper.dart';
import 'package:estigma/infrastructure/models/cases_model.dart';
import 'package:http/http.dart' as http;

class CasesRepository {
  final String apiUrl;
  CasesRepository(this.apiUrl);

  Future<CasesModel> createCase(CasesEntity caseData) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/collections/cases/records'),
    );

    request.fields['name'] = caseData.name;
    request.fields['age'] = caseData.age.toString();
    request.fields['ulcerType'] = caseData.ulcerType;
    request.fields['testimonial'] = caseData.testimonial;

    if (caseData.images != null) {
      request.files.add(caseData.images!);
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final json = jsonDecode(responseBody);
      return CasesMapper.fromJson(json);
    } else {
      throw Exception('Failed to create case');
    }
  }
}