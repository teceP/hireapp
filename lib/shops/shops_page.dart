import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShopsPage extends StatelessWidget {
  const ShopsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, userId) => TextButton(
        onPressed: () {},/*context.router.push(
          SingleUserRoute(userId: '$userId'),
        ),*/
        child: Text('User ID - $userId'),
      ),
    ));
  }
}
