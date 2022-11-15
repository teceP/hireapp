import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, profileId) => TextButton(
          onPressed: () => context.router.push(
            SingleProfileRoute(
              profileId: profileId,
            ),
          ),
          child: Text('Profile ID - $profileId'),
        ),
      ),
    );
  }
}
