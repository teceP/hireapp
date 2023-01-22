import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/profile/signe_in_page.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  bool _signedIn = true;

  @override
  Widget build(BuildContext context) {
    if (!_signedIn) {
      return SignInPage();
    }
    print('profile page');
    return Scaffold(
        body: Center(
      child: Text('Profile Page'),
    ));
  }
}
