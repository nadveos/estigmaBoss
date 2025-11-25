// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;
  String _authStatus = 'Not authenticated';

  // ignore: unused_element
  Future<void> _authenticate() async {
    setState(() {
      _isAuthenticating = true;
      _authStatus = 'Authenticating...';
    });

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authStatus = didAuthenticate ? 'Authenticated!' : 'Failed to authenticate';
      });
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authStatus = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_authStatus, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.fingerprint),
              label: const Text('Login with Biometrics'),
              // onPressed: _isAuthenticating ? null : _authenticate,
              onPressed: () {
                context.go('/');
                
              },
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                context.go('/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}