// import 'package:flutter/material.dart';

// class UserTile extends StatelessWidget {
//   final String text;
//   final void Function() onTap;
//   const UserTile({super.key, required this.text, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.transparent, // Theme.of(context).colorScheme.secondary,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         child: Row(
//           children: [
//             // const Icon(Icons.person),
//             CircleAvatar(
//               radius: 20,
//               child: Text(text[0],
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   )),
//             ),
//             const SizedBox(width: 20),
//             Text(text,
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Theme.of(context).colorScheme.primary)),
//           ],
//         ),
//       ),
//     );
//   }
// }
