import 'package:estigma/presentation/screens/welcome_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final approuter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/auth', builder: (context, state) => AuthScreen()),
    GoRoute(path: '/', builder: (context, state) => WelcomeScreen()),
  ],
);
