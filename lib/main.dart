import 'package:estigma/config/router/app_router.dart';
import 'package:estigma/config/theme/app_theme.dart';
import 'package:estigma/presentation/providers/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/notifications/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  await dotenv.load(fileName: ".env");
runApp(const ProviderScope(child: MyApp()));

}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changeThemeProvider = ref.watch(themeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      
      title: 'Estigma',
      routerConfig: approuter,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: changeThemeProvider,
          );
  }
}