// import 'package:flutter/material.dart';
// import 'package:pockettasks/widgets/custom_text.dart';

// class CustomButton extends StatelessWidget {
//   final double? height;
//   final double? width;
//   final String text;
//   final VoidCallback onPressed;

//   CustomButton({
//     super.key,
//     this.height,
//     this.width,
//     required this.text,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           color: Colors.amberAccent,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: CustomText(
//             text: text,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
