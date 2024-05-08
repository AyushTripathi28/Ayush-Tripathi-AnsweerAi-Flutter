import 'package:chatgpt_clone/providers/chat_provider.dart';
import 'package:chatgpt_clone/providers/settings_provider.dart';
import 'package:chatgpt_clone/services/auth/auth_service.dart';
import 'package:chatgpt_clone/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider =
        Provider.of<ChatProvider>(context, listen: true);
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: true);
    return Drawer(
      elevation: 1,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      width: settingsProvider.getScreenSize(context),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const Gap(10),
            const Row(
              children: [
                Gap(16),
                Expanded(
                  child: Text(
                    "GPT-Clone", //   chatProvider.currentUserName.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Gap(10),
            const Divider(thickness: 0),
            Expanded(
                child: StreamBuilder(
                    stream: _chatService
                        .getThreadsStream(_authService.getCurrentUser()!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Error"));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text("No old threads"),
                        );
                      }

                      snapshot.data!.sort(
                          (a, b) => b["timestamp"].compareTo(a["timestamp"]));

                      return SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!
                              .map((threadData) => BuildThreadList(
                                  threadData: threadData,
                                  isEnabled: chatProvider.currentThreadId ==
                                      threadData["threadId"],
                                  callback: () async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 100));
                                    chatProvider
                                        .setThreadId(threadData["threadId"]);
                                    Navigator.canPop(context)
                                        ? Navigator.pop(context)
                                        : null;
                                  }))
                              .toList(),
                        ),
                      );
                    })),
            const Divider(thickness: 0),
            Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    const Gap(18),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(12),
                    const Expanded(
                      child: Text(
                        "Ayush Tripathi", //   chatProvider.currentUserName.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
                IconButton(
                    onPressed: () {
                      settingsProvider.isDrawerOpen
                          ? settingsProvider.toggleDrawer()
                          : null;

                      _authService.signOut();
                    },
                    icon: const Icon(
                      Icons.logout,
                    )),
              ],
            ),
            const Gap(16)
          ],
        ),
      ),
    );
  }
}

class BuildThreadList extends StatelessWidget {
  final Map<String, dynamic> threadData;
  final bool isEnabled;
  final Function callback;

  const BuildThreadList({
    super.key,
    required this.threadData,
    required this.isEnabled,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, left: 5, right: 5),
      child: ListTile(
        dense: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        tileColor: isEnabled ? const Color(0xff222222) : null,
        onTap: () {
          callback();
        },
        title: Text(
          threadData["title"] ?? "New Chat",
          style: TextStyle(
            color: isEnabled ? Colors.white : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
