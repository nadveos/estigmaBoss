import 'dart:async';

import 'package:estigma/config/enviroment/const_env.dart';
import 'package:estigma/config/notifications/notification_service.dart';
import 'package:estigma/infrastructure/mappers/case_mapper.dart';
import 'package:estigma/infrastructure/models/case_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

final casesStreamRepositoryProvider = StreamProvider<List<CaseModel>>((ref) {
  final client = PocketBase(Enviroment.url);
  final controller = StreamController<List<CaseModel>>.broadcast();
  Future<void> loadCases() async {
    final records = await client.collection('cases').getList( sort: '-created');
    final items = records.items.map((item) => CaseMapper.fromJson(item.toJson())).toList();
    controller.add(items);
  }

  // Future<void> deleteCase(String id) async {
  //   await client.collection('cases').delete(id);
  //   await loadCases();
  // }
  client.collection('cases').subscribe('*', (e) async {
    // ignore: avoid_print
    if (e.action == 'delete') {
      NotificationService.showNotification(title: 'Registro eliminado', body: 'Un registro ha sido eliminado');
    }

    await loadCases();
  });

  loadCases();

  ref.onDispose(() {
    client.realtime.unsubscribe('*');
    controller.close();
  });

  return controller.stream;
});
