// import 'package:flutter/material.dart';

// class ChatTextField extends StatelessWidget {
//   final String hintText;
//   final bool obscureText;
//   final TextEditingController controller;
//   const ChatTextField(
//       {super.key,
//       required this.hintText,
//       required this.obscureText,
//       required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           contentPadding:
//               const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 15),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).colorScheme.secondary,
//             ),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).colorScheme.secondary,
//             ),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           fillColor: Theme.of(context).colorScheme.inversePrimary,
//           filled: true,
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: Theme.of(context).colorScheme.primary,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         // minLines: 1,
//         // maxLines: 3,
//       ),
//     );
//   }
// }
