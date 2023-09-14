// import 'package:anime_track/screens/home/home_screen.dart';
// import 'package:anime_track/screens/landing.dart';
// import 'package:anime_track/screens/network_check.dart';
// import 'package:anime_track/screens/sign_in/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govt_billing/view/bottom_navigation_screen.dart';
import 'package:govt_billing/view/sign_in/signin_screen.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_states.dart';
import 'blocs/auth/auth_events.dart';
import 'package:bloc/bloc.dart';

import 'common/constants/color.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider<AppBloc>(
        create: (_) => AppBloc()..add(AppEventInitialize()),
        child: MaterialApp(
          home: BlocConsumer<AppBloc, AppState>(
            listener: (context, appState) {},
            builder: (context, appState) {
              print(appState);
              if (appState is AppStateLoggedOut) {
                return const SignInScreen();
              } else if (appState is AppStateLoggedIn) {
                return BottomNavigationScreen();
              } else {
                // this should never happen
                return Container();
              }
            },
          ),
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            appBarTheme: const AppBarTheme(
                backgroundColor: primaryColor,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white)),
            scaffoldBackgroundColor: bgColor,
            textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.black),
            canvasColor: secondaryColor,
          ),
          themeMode: ThemeMode.light,
        ),
      ),
    );
  }
}
