import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class SingleProfilePage extends StatelessWidget {
  final profileId;

  const SingleProfilePage({@PathParam() required this.profileId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Profile ID - $profileId'),
    ));
  }
}
