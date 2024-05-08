import 'dart:convert';

import 'package:chatgpt_clone/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ChatService {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get thread stream from firebase
  Stream<List<Map<String, dynamic>>> getThreadsStream(String userID) {
    return _firestore
        .collection('Users')
        .doc(userID)
        .snapshots()
        .map((snapshot) {
      final user = snapshot.data();
      if (user != null && user['threads'] != null) {
        return List<Map<String, dynamic>>.from(user["threads"]);
      } else {
        return [];
      }
    });
  }

  Future<String> createThreadId(String userFirstQuestion) async {
    final String currentUserID = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    int unixTimestamp = timestamp.seconds;

    //construct thread room Id for the two user (sorted to ensure uniqueness)
    List<String> ids = [
      currentUserID,
      unixTimestamp.toString(),
    ];
    String threadRoomId = ids.join('_');
    String threadId = threadRoomId;
    await _firestore.collection('Users').doc(currentUserID).update({
      "threads": FieldValue.arrayUnion([
        {
          "threadId": threadId,
          "title": userFirstQuestion,
          "timestamp": timestamp,
        }
      ]),
    });

    return threadId;
  }

  //send message to firebase
  Future<void> sendMessageToStorage(ChatMessage message) async {
    //get current user
    final String currentUserID = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    ChatMessage newMessage = ChatMessage(
      threadId: message.threadId,
      userId: currentUserID,
      question: message.question,
      response: message.response,
      timestamp: timestamp,
    );

    //add new message to database
    await _firestore
        .collection('thread_rooms')
        .doc(message.threadId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get message from firebase
  Future<List<ChatMessage>> getMessagesFromStorage(
      String userId, String threadId) async {
    //construct chatroom Id for the two users
    QuerySnapshot querySnapshot = await _firestore
        .collection('thread_rooms')
        .doc(threadId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data())
        .where((data) => data != null)
        .map((data) => ChatMessage.fromMap(data as Map<String, dynamic>))
        .toList();
  }

  //get message from chatbot
  Future<String?> getChatResponse() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    return "Chat response";
  }

  Future<void> getRealTimeChatResponse(
    Function(String) onStreamedText,
    String question, {
    Function? onComplete,
  }) async {
    try {
      final uri = Uri.parse('https://api.anthropic.com/v1/messages');
      final headers = {
        'x-api-key':
            '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', // Replace with your actual API key
        'anthropic-version': '2023-06-01',
        'content-type': 'application/json'
      };
      final body = jsonEncode({
        'model': 'claude-3-opus-20240229',
        'max_tokens': 1024,
        'messages': [
          {'role': 'user', 'content': question}
        ],
        'stream': true
      });

      final request = http.Request('POST', uri)
        ..headers.addAll(headers)
        ..body = body;

      final responseStream = await http.Client().send(request);
      print("HTTP Status Code: ${responseStream.statusCode}");

      // Read and process the stream data line by line
      await for (String line in responseStream.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
        line = line.trim(); // Remove extra whitespaces
        if (line.startsWith('data:')) {
          // Extract only the JSON data by stripping off the 'data:' prefix
          final String jsonLine = line.substring(5).trim();
          try {
            final Map<String, dynamic> json = jsonDecode(jsonLine);
            if (json['type'] == 'content_block_delta') {
              final text = json['delta']['text'];
              onStreamedText(text); // Trigger the callback
            }
          } catch (jsonError) {
            print("Error parsing JSON: $jsonError");
          }
        } else if (line.startsWith('event:')) {
          // Optionally handle or ignore event lines
          print("Received event line: $line");
        }
      }

      print("Streaming ends.");
      if (onComplete != null) {
        onComplete(); // Trigger the completion callback
      }
    } catch (e) {
      print("Error in streaming: $e");
      if (onComplete != null) {
        onComplete(); // Ensure the callback is called even on errors
      }
    }
  }

  // Future<void> getRealTimeChatResponse(
  //     Function(String) onStreamedText, String question) async {
  //   try {
  //     final uri = Uri.parse('https://api.anthropic.com/v1/messages');
  //     final headers = {
  //       'x-api-key':
  //           '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', // Replace with your actual API key
  //       'anthropic-version': '2023-06-01',
  //       'content-type': 'application/json'
  //     };
  //     final body = jsonEncode({
  //       'model': 'claude-3-opus-20240229',
  //       'max_tokens': 1024,
  //       'messages': [
  //         {'role': 'user', 'content': question}
  //       ],
  //       'stream': true
  //     });
  //     final request = http.Request('POST', uri)
  //       ..headers.addAll(headers)
  //       ..body = body;
  //     final responseStream = await http.Client().send(request);
  //     print("HTTP Status Code: ${responseStream.statusCode}");
  //     // Read and process the stream data line by line
  //     await for (String line in responseStream.stream
  //         .transform(utf8.decoder)
  //         .transform(const LineSplitter())) {
  //       line = line.trim(); // Remove extra whitespaces
  //       if (line.startsWith('data:')) {
  //         // Extract only the JSON data by stripping off the 'data:' prefix
  //         final String jsonLine = line.substring(5).trim();
  //         try {
  //           final Map<String, dynamic> json = jsonDecode(jsonLine);
  //           if (json['type'] == 'content_block_delta') {
  //             final text = json['delta']['text'];
  //             onStreamedText(text); // Trigger the callback
  //           }
  //         } catch (jsonError) {
  //           print("Error parsing JSON: $jsonError");
  //         }
  //       } else if (line.startsWith('event:')) {
  //         // Optionally handle or ignore event lines
  //         print("Received event line: $line");
  //       }
  //     }
  //     print("Streaming ends.");
  //   } catch (e) {
  //     print("Error in streaming: $e");
  //   }
  // }
}
