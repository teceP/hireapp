import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleChatPage extends StatelessWidget {
  final chatId;

  const SingleChatPage({@PathParam() required this.chatId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const AutoLeadingButton()),
      body: Center(
        child: Text(
          'Chat ID - $chatId',
        ),
      ),
    );
  }
}
