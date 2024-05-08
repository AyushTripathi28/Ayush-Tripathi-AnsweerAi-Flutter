import 'package:chatgpt_clone/providers/chat_provider.dart';
import 'package:chatgpt_clone/providers/settings_provider.dart';
import 'package:chatgpt_clone/views/chat__screen/components/chat_component.dart';
import 'package:chatgpt_clone/views/chat__screen/components/initial_question_component.dart';
import 'package:chatgpt_clone/views/chat__screen/components/text_field_component.dart';
import 'package:chatgpt_clone/views/drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: true);
    ChatProvider chatProvider =
        Provider.of<ChatProvider>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("GPT CLONE"),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: settingsProvider.toggleDrawer,
        ),
        actions: [
          IconButton(
              onPressed: () {
                chatProvider.createNewChat();
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      drawer: CustomDrawer(),
      body: const SafeArea(
          child: Column(
        children: [
          ChatComponent(),
          InitialQuestionComponent(),
          TextFieldComponent(),
        ],
      )),
    );
  }
}
