import 'package:chatgpt_clone/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({super.key});

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider =
        Provider.of<ChatProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        right: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              enabled: !chatProvider.chatResponseLoader!,
              controller: chatProvider.textEditingController,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.mic, color: Colors.grey),
                hintText: "Message",
                hintStyle: const TextStyle(color: Colors.grey),
                // isDense: true,
                contentPadding: const EdgeInsets.only(
                    left: 20, top: 8, bottom: 8, right: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.5), width: 0.5)),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              minLines: 1,
              maxLines: 5,
            ),
          ),
          const Gap(8),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // print(chatProvider.textEditingController.text);
              if (!chatProvider.chatResponseLoader!) {
                chatProvider.sendMessage(
                  chatProvider.textEditingController.text.trim(),
                );
              }
            },
            icon: chatProvider.chatResponseLoader!
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white, size: 30)
                : const Icon(
                    Icons.send,
                  ),
          )
        ],
      ),
    );
  }
}
