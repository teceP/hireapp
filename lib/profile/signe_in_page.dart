import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('sign in page');

    return const Scaffold(
      body: Center(
        child: Text(
          'Sign In Page',
        ),
      ),
    );
  }
}
