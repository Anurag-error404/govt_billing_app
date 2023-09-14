// import 'package:anime_track/colors.dart';
// import 'package:anime_track/size_config.dart';
// import 'package:flutter/material.dart';

// class ErrorScreen extends StatelessWidget {
//   const ErrorScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints viewportConstraints) {
//       return SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         child: ConstrainedBox(
//           constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
//           child: SizedBox(
//             // padding: EdgeInsets.all(16),
//             width: double.infinity,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/errors/notFound.png',
//                   width: SizeConfig.screenWidth * 0.7,
//                 ),
//                 Text(
//                   "Oops!",
//                   style: TextStyle(
//                       color: kTextColor,
//                       fontFamily: 'Muli',
//                       fontWeight: FontWeight.bold,
//                       fontSize: SizeConfig.screenWidth * 0.1),
//                   textAlign: TextAlign.center,
//                 ),
//                 Text(
//                   "Some error occurred.\nPlease try again.",
//                   style: TextStyle(
//                       color: kTextColor,
//                       fontFamily: 'Muli',
//                       // fontWeight: FontWeight.bold,
//                       fontSize: SizeConfig.screenWidth * 0.05),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
