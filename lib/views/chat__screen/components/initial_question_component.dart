import 'package:chatgpt_clone/models/message.dart';
import 'package:chatgpt_clone/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class InitialQuestionComponent extends StatelessWidget {
  const InitialQuestionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider =
        Provider.of<ChatProvider>(context, listen: true);
    return chatProvider.chatMessageList.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                children: [
                  const Gap(10),
                  ...initialQuestionsList
                      .map((e) => _buildInitialListContainer(e, () {
                            chatProvider.sendMessage(e.initialQuestions);
                          }))
                ],
              ),
            ),
          )
        : const SizedBox();
  }

  Widget _buildInitialListContainer(
      InitialQuestions initialQuestion, Function callback) {
    return InkWell(
      onTap: () {
        callback();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(right: 10),
        decoration: const BoxDecoration(
          color: Color(0xff1F1E1E),
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              initialQuestion.initialQuestionsTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              initialQuestion.initialQuestionsSubtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
