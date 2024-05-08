import 'package:chatgpt_clone/models/chat_message.dart';
import 'package:chatgpt_clone/services/auth/auth_service.dart';
import 'package:chatgpt_clone/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatMessage> chatMessageList = [];

  //initialise services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //get current userId
  String? curresntUserId;
  String? currentThreadId;

  //get Current UserName
  String? currentUserName;

  //text editing controller
  final TextEditingController textEditingController = TextEditingController();

  //scrollController
  final ScrollController scrollController = ScrollController();

  //loader
  bool? chatLoader = false;
  bool? chatResponseLoader = false;

  ChatProvider() {
    curresntUserId = _authService.getCurrentUser()!.uid;
    currentUserName = _authService.getCurrentUser()!.displayName;
  }

  setThreadId(String threadId) async {
    currentThreadId = threadId;
    chatMessageList = [];
    notifyListeners();
    chatMessageList = await _chatService.getMessagesFromStorage(
        curresntUserId!, currentThreadId!);
    print(chatMessageList);
    notifyListeners();
  }

  createNewChat() {
    currentThreadId = "";
    chatMessageList = [];
    notifyListeners();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 200), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      });
    }
    notifyListeners();
  }

  //send message to chatbot
  void sendMessage(String question) async {
    textEditingController.clear();
    print("Q $question");
    ChatMessage tempMessage = ChatMessage(
      threadId: currentThreadId ?? "",
      userId: curresntUserId!,
      question: question,
      response: "",
      timestamp: Timestamp.now(),
    );

    chatMessageList.add(tempMessage);
    scrollToBottom();
    chatResponseLoader = true;
    notifyListeners();

    // Batch accumulation of responses
    StringBuffer accumulatedResponse = StringBuffer();

    // Real-time streaming of chatbot response
    await _chatService.getRealTimeChatResponse(
        (String streamedText) {
          accumulatedResponse.write(streamedText); // Append streamed text
          tempMessage.response =
              accumulatedResponse.toString(); // Update the temp message
          notifyListeners(); // Update UI as each batch arrives
        },
        question,
        onComplete: () async {
          // This block executes after streaming is complete
          if (currentThreadId == null || currentThreadId == "") {
            currentThreadId = await _chatService.createThreadId(question);
            tempMessage.threadId = currentThreadId!;
          }

          // Save response to storage
          await _chatService.sendMessageToStorage(tempMessage);

          chatResponseLoader = false;
          scrollToBottom();
          notifyListeners(); // Final update once all data is processed
        });
  }
  // void sendMessage(String question) async {
  //   textEditingController.clear();
  //   notifyListeners();
  //   print("Q $question");
  //   ChatMessage tempMessage = ChatMessage(
  //     threadId: currentThreadId ?? "",
  //     userId: curresntUserId!,
  //     question: question,
  //     response: "",
  //     timestamp: Timestamp.now(),
  //   );
  //   chatMessageList.add(tempMessage);
  //   scrollToBottom();
  //   chatResponseLoader = true;
  //   notifyListeners();
  //   // Real-time streaming of chatbot response
  //   await _chatService.getRealTimeChatResponse((String streamedText) {
  //     tempMessage.response += streamedText; // Append streamed text
  //     notifyListeners(); // Update UI as each chunk arrives
  //   }, question);
  //   if (currentThreadId == null || currentThreadId == "") {
  //     currentThreadId = await _chatService.createThreadId(question);
  //     tempMessage.threadId = currentThreadId!;
  //     notifyListeners();
  //   }
  //   //save response to firebase now
  //   await _chatService.sendMessageToStorage(tempMessage);
  //   chatResponseLoader = false;
  //   scrollToBottom();
  //   notifyListeners();
  // }
}
