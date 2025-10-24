// import 'package:flutter/material.dart';
// import 'package:tsb_mini/frame/button/back_button.dart';
// import 'package:tsb_mini/package_mode.dart';
// import 'package:tsb_mini/theme/color_theme.dart';

// class RewardDetailCard extends StatefulWidget {
//   const RewardDetailCard({super.key});

//   @override
//   State<RewardDetailCard> createState() => _RewardDetailCardState();
// }

// class _RewardDetailCardState extends State<RewardDetailCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background image
//         PackageAssets.image(
//           'assets/home_images/starbucks_latest_reward.png',
//           width: double.infinity,
//           height: 300,
//           fit: BoxFit.cover,
//         ),

//         // Frosted back button on top-left
//         Positioned(
//           top: 60,
//           left: 20,
//           child: FrostedBackButton(
//             onBack: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ),

//         // Bottom overlay with rounded top corners
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: AppColors.cardBackground,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsetsGeometry.only(top: 20, left: 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Free Handcrafted Drink',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                       color: AppColors.textBlack,
//                     ),
//                     softWrap: true,
//                     overflow: TextOverflow.ellipsis,
//                   ),

//                   Text(
//                     'Starbucks',
//                     style: TextStyle(
//                       color: AppColors.textLight,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),

//         Positioned(
//           top: 170,
//           left: 20,
//           child: Container(
//             width: 57,
//             height: 58,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.textGrey.withOpacity(
//                     0.15,
//                   ), // very light shadow
//                   spreadRadius: 1, // smaller spread
//                   blurRadius: 3, // softer blur
//                   offset: const Offset(0, 1), // subtle vertical offset
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(50),
//               child: PackageAssets.image(
//                 'assets/icon/starbuck.png',
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
