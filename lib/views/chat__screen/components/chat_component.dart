import 'package:chatgpt_clone/models/chat_message.dart';
import 'package:chatgpt_clone/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ChatComponent extends StatelessWidget {
  const ChatComponent({super.key});

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider =
        Provider.of<ChatProvider>(context, listen: true);
    return Flexible(
      child: Padding(
          padding: const EdgeInsets.only(
            left: 14,
            right: 14,
            top: 14,
            bottom: 0,
          ),
          child: chatProvider.chatMessageList.isNotEmpty
              ? ListView(
                  controller: chatProvider.scrollController,
                  children: chatProvider.chatMessageList
                      .map((e) => _buildChatMessage(e, context))
                      .toList(),
                )
              : const Center(
                  child: Text("Ask me anything!"),
                )),
    );
  }

  Widget _buildChatMessage(ChatMessage chatMessage, BuildContext ctx) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 14,
                  child: Icon(Icons.person),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(3),
                      const Text(
                        "You",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const Gap(5),
                      Text(chatMessage.question),
                    ],
                  ),
                )
              ],
            ),
            const Gap(30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 14,
                  child: Icon(Icons.android),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(3),
                      const Text(
                        "ChatBot",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const Gap(5),
                      SelectableText(chatMessage.response),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
