import 'dart:convert';

import 'package:estigma/domain/entities/case_entity.dart';
import 'package:estigma/infrastructure/mappers/case_mapper.dart';
import 'package:estigma/infrastructure/models/case_model.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

class CasesRepository {
  final String apiUrl;
  CasesRepository(this.apiUrl);

  Future<CaseModel> createCase(CaseEntity caseData) async {
    final request = http.MultipartRequest('POST', Uri.parse('$apiUrl/api/collections/cases/records'));

    request.fields['name'] = caseData.name;
    request.fields['age'] = caseData.age.toString();
    request.fields['type_ulcer'] = caseData.typeUlcer;
    request.fields['testimonial'] = caseData.testimonial;

    if (caseData.imgs != null) {
      request.files.addAll(caseData.imgs!);
    }

    final response = await request.send();
    print('RESPUESTA : ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      try {
        final json = jsonDecode(responseBody);
        return CaseMapper.fromJson(json);
      } catch (e) {
        print('Error parsing response: $e');
        print('Response body: $responseBody');
        throw Exception('Failed to parse case response');
      }
    } else {
      throw Exception('Failed to create case');
    }
  }

  Future<List<CaseModel>> getCases() async {
    final response = await http.get(Uri.parse('$apiUrl/api/collections/cases/records'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> items = responseData['items'] ?? [];
      return items.map((json) => CaseMapper.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load cases');
    }
  }

  Future<void> deleteCase(String id) async {
    final client = PocketBase(apiUrl);
    final response = await client.collection('cases').delete(id);
    response;
  }
}
