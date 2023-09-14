// import 'dart:ui';

// import 'package:anime_track/colors.dart';
// import 'package:anime_track/size_config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class NoInternetScreen extends StatelessWidget {
//   const NoInternetScreen({super.key});

//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       backgroundColor: kBgColor,
//       appBar: PreferredSize(
//         preferredSize: Size(
//           double.infinity,
//           AppBar().preferredSize.height,
//         ),
//         child: ClipRRect(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//             child: AppBar(
//               title: Image.asset(
//                 'assets/appbar/logo.png',
//                 height: AppBar().preferredSize.height,
//                 fit: BoxFit.fitHeight,
//               ),
//               backgroundColor: kBgColor.withOpacity(0),
//               centerTitle: true,
//               elevation: 0,
//             ),
//           ),
//         ),
//       ),
//       body: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints viewportConstraints) {
//         return SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
//             child: SizedBox(
//               // padding: EdgeInsets.all(16),
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/errors/noInternet.png',
//                     width: SizeConfig.screenWidth * 0.8,
//                   ),
//                   Text(
//                     "No Internet!",
//                     style: TextStyle(
//                         color: kTextColor,
//                         fontFamily: 'Muli',
//                         fontWeight: FontWeight.bold,
//                         fontSize: SizeConfig.screenWidth * 0.1),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     "Check your connection.",
//                     style: TextStyle(
//                         color: kTextColor,
//                         fontFamily: 'Muli',
//                         // fontWeight: FontWeight.bold,
//                         fontSize: SizeConfig.screenWidth * 0.05),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
//   // Widget build(BuildContext context) {
//   //   SizeConfig().init(context);
//   //   return Scaffold(
//   //     backgroundColor: kBgColor,
//   //     body: SafeArea(
//   //       child: SizedBox(
//   //         width: double.infinity,
//   //         child: Padding(
//   //           padding: EdgeInsets.all(16),
//   //           child: Column(
//   //             children: [
//   //               Spacer(
//   //                 flex: 2,
//   //               ),
//   //               Image.asset(
//   //                 'assets/errors/noInternet.png',
//   //                 width: SizeConfig.screenWidth * 0.8,
//   //               ),
//   //               Spacer(),
//   //               Text(
//   //                 "No Internet!",
//   //                 style: TextStyle(
//   //                     color: kTextColor,
//   //                     fontFamily: 'Muli',
//   //                     fontWeight: FontWeight.bold,
//   //                     fontSize: SizeConfig.screenWidth * 0.1),
//   //                 textAlign: TextAlign.center,
//   //               ),
//   //               Text(
//   //                 "Check your connection.",
//   //                 style: TextStyle(
//   //                     color: kTextColor,
//   //                     fontFamily: 'Muli',
//   //                     // fontWeight: FontWeight.bold,
//   //                     fontSize: SizeConfig.screenWidth * 0.05),
//   //                 textAlign: TextAlign.center,
//   //               ),
//   //               Spacer(
//   //                 flex: 2,
//   //               )
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
