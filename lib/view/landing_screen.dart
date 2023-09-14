import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_states.dart';
import 'bottom_navigation_screen.dart';
import 'sign_in/signin_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
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
    );
  }
}
