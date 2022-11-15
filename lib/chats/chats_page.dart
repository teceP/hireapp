import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/chats/single_chat_page.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: const Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, chatId) => TextButton(
          onPressed: () {
            context.router.push(SingleChatRoute(chatId: chatId));
          },
          child: Text('Chat ID - $chatId'),
        ),
      ),
    );
  }
}
