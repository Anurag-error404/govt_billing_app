import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govt_billing/common/constants/sizing.dart';

import '../../../blocs/auth/auth_events.dart';
import '../../../blocs/auth/auth_bloc.dart';

import '../../../common/constants/color.dart';
import '../../../common/utils/size_config.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                context.read<AppBloc>().add(
                      AppEventLogIn(),
                    );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, defaultPadding, 0, defaultPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/icons/google_logo.png"),
                      height: SizeConfig.screenWidth*0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: SizeConfig.screenWidth*0.05,
                          color: bgColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
