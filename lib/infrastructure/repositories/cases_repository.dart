import 'dart:convert';

import 'package:estigma/domain/entities/cases_entity.dart';
import 'package:estigma/infrastructure/mappers/cases_mapper.dart';
import 'package:estigma/infrastructure/models/cases_model.dart';
import 'package:http/http.dart' as http;

class CasesRepository {
  final String apiUrl;
  CasesRepository(this.apiUrl);

  Future<CasesModel> createCase(CasesEntity caseData) async {
    final request = http.MultipartRequest('POST', Uri.parse('$apiUrl/api/collections/cases/records'));

    request.fields['name'] = caseData.name;
    request.fields['age'] = caseData.age.toString();
    request.fields['type_ulcer'] = caseData.type_ulcer;
    request.fields['testimonial'] = caseData.testimonial;

    if (caseData.imgs != null) {
      request.files.add(caseData.imgs!);
    }

    final response = await request.send();
    print('RESPUESTA : ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      try {
        final json = jsonDecode(responseBody);
        return CasesMapper.fromJson(json);
      } catch (e) {
        print('Error parsing response: $e');
        print('Response body: $responseBody');
        throw Exception('Failed to parse case response');
      }
    } else {
      throw Exception('Failed to create case');
    }
  }
}
