// import 'package:flutter/material.dart';

// class ChatBubble extends StatelessWidget {
//   final String message;
//   final bool isCurrentUser;
//   const ChatBubble(
//       {super.key, required this.message, required this.isCurrentUser});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(
//         maxWidth: MediaQuery.of(context).size.width * 0.6,
//       ),
//       decoration: BoxDecoration(
//         color: isCurrentUser
//             ? Theme.of(context).colorScheme.secondary
//             : Theme.of(context).colorScheme.primary,
//         borderRadius: BorderRadius.only(
//           bottomLeft: const Radius.circular(20),
//           bottomRight: const Radius.circular(20),
//           topLeft: isCurrentUser ? const Radius.circular(20) : Radius.zero,
//           topRight: isCurrentUser ? Radius.zero : const Radius.circular(20),
//         ),
//       ),
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//       padding: const EdgeInsets.all(12),
//       child: Text(
//         message,
//         style: TextStyle(
//           color: isCurrentUser
//               ? Theme.of(context).colorScheme.primary
//               : Theme.of(context).colorScheme.secondary,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }
// }
