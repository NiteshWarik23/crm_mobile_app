// import 'package:flutter/material.dart';

// class AppointmentScreen extends StatelessWidget {
//   const AppointmentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const TabHeader(),
//         const Divider(
//           color: Colors.grey,
//         ),
//         SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: AppointmentCard(isHighlighted: true),
//         ),
//       ],
//     );
//   }
// }

// class TabHeader extends StatelessWidget {
//   const TabHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Spacer(),
//           GestureDetector(
//             onTap: () {},
//             child: const Text(
//               'Today',
//               style: TextStyle(
//                 fontSize: 16.0,
//                 decoration: TextDecoration.underline,
//                 decorationColor: Color(0xFF009963),
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//           ),
//           const SizedBox(width: 16.0),
//           GestureDetector(
//             onTap: () {},
//             child: const Text(
//               'This Month',
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const Spacer(),
//           Container(
//             padding: const EdgeInsets.all(6.0),
//             decoration: BoxDecoration(
//               color: Colors.white, // Button background color
//               shape: BoxShape.circle, // Makes it circular
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.shade300,
//                   // Shadow color
//                   spreadRadius: 0.5,
//                   // Reduce spread for a smaller shadow
//                   blurRadius: 5,
//                   // Soften the shadow
//                   offset: const Offset(
//                       0, 2), // Subtle vertical shadow
//                 ),
//               ],
//             ),
//             child: const Icon(
//               Icons.add, // Search icon
//               color: Colors.black, // Icon color
//               size: 20, // Icon size
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AppointmentCard extends StatelessWidget {
//   final bool isHighlighted;

//   const AppointmentCard({required this.isHighlighted, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.0),
//         border: isHighlighted
//             ? Border.all(color: Colors.blue, width: 2.0)
//             : Border.all(color: Colors.transparent),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade400,
//             spreadRadius: 2,
//             blurRadius: 6,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const CircleAvatar(
//                 backgroundColor: Colors.grey,
//                 radius: 24.0,
//               ),
//               const SizedBox(width: 16.0),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     'Carla Mintos',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                   Text(
//                     'Manager',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               _RoundIconButton(
//                 icon: Icons.message,
//                 backgroundColor: Colors.yellow,
//               ),
//               const SizedBox(width: 8.0),
//               _RoundIconButton(
//                 icon: Icons.phone,
//                 backgroundColor: Colors.yellow,
//               ),
//             ],
//           ),
//           const SizedBox(height: 16.0),
//           const Text(
//             '123 Serenity Lane, Greenview Heights\nBlissville, AB 45678',
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 14.0,
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text(
//                 '03:30 PM',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '14.12.2024',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16.0),
//           Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade50,
//                     foregroundColor: Colors.green,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text('Done'),
//                 ),
//               ),
//               Checkbox(
//                 value: false,
//                 // fillColor: WidgetStateProperty.all<Color>(Colors.transparent),
//               overlayColor:WidgetStateProperty.all<Color>(Colors.grey),
//                 onChanged: (bool? value) {},
//               ),
//               const SizedBox(width: 16.0),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red.shade50,
//                     foregroundColor: Colors.red,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text('Cancel'),
//                 ),
//               ),
//               Checkbox(
//                 value: true, // Set true for checked, false for unchecked
//                 onChanged: (bool? value) {
//                   // Handle checkbox toggle
//                 },
//                 side: BorderSide(
//                   color: Colors.transparent, // Black border
//                   width: 2.0, // Border width
//                 ),
//                 checkColor: Colors.black, // Black check icon
//                 // fillColor: MaterialStateProperty.all(Colors.transparent), // Transparent background
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _RoundIconButton extends StatelessWidget {
//   final IconData icon;
//   final Color backgroundColor;

//   const _RoundIconButton({
//     required this.icon,
//     required this.backgroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: backgroundColor,
//       ),
//       padding: const EdgeInsets.all(8.0),
//       child: Icon(icon, size: 20.0, color: Colors.black),
//     );
//   }
// }