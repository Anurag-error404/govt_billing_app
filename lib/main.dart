import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govt_billing/data/repo/auth_repo.dart';

import 'app.dart';
import 'blocs/authentication/auth_cubit.dart';
import 'common/constants/color.dart';
import 'common/utils/app_bloc_observer.dart';
import 'firebase_options.dart';
import 'view/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Paint.enableDithering = true;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: primaryColor, // status bar color
  ));
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider<AuthRepo>(create: (context) => AuthRepo()),
//       ],
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => AuthCubit(AuthRepo())),
//         ],
//         child: MaterialApp(
//           home: const LandingScreen(),
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData.light().copyWith(
//             appBarTheme: const AppBarTheme(
//                 backgroundColor: primaryColor,
//                 elevation: 0,
//                 iconTheme: IconThemeData(color: Colors.white)),
//             scaffoldBackgroundColor: bgColor,
//             textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme)
//                 .apply(bodyColor: Colors.black),
//             canvasColor: secondaryColor,
//           ),
//           themeMode: ThemeMode.light,
//         ),
//       ),
//     );
//   }
// }
