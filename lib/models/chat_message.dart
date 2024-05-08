import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String threadId;
  final String userId;
  String question;
  String response;
  final Timestamp timestamp;

  ChatMessage({
    required this.threadId,
    required this.userId,
    required this.question,
    required this.response,
    required this.timestamp,
  });

  //convert message to map
  Map<String, dynamic> toMap() {
    return {
      'threadId': threadId,
      'userId': userId,
      'question': question,
      'response': response,
      'timestamp': timestamp,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      threadId: map["threadId"],
      userId: map["userId"],
      question: map["question"],
      response: map["response"],
      timestamp: map["timestamp"],
    );
  }
}
