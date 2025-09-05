import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/shared_pref.dart';
import 'package:todo_app/feature/auth/presentation/pages/signIn.dart';
import 'package:todo_app/feature/presentation/screens/todo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    final isLoggedIn = SharedPrefs.getIsLoggedIn();

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AddTodoItems()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              'assets/logo.png', // Replace with your logo
              height: 120,
            ),
            const SizedBox(height: 24),
            // App Name
            Text(
              'Sunrise Todo',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
