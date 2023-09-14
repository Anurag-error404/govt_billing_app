// import 'package:anime_track/bloc/auth/auth_events.dart';
// import 'package:anime_track/bloc/auth/auth_bloc.dart';
import '../../../common/constants/color.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/size_config.dart';
import '../../../common/constants/sizing.dart';
import 'google_button.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/govt_billing_app_logo.png',
                    width: SizeConfig.screenWidth * 0.4,
                  ),
                  verticalSpaceDefault,
                  Text(
                    'Govt Billing',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: SizeConfig.screenWidth * 0.1,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '&',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: SizeConfig.screenWidth * 0.1,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Invoices',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: SizeConfig.screenWidth * 0.1,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpaceLarge,
                  GoogleSignInButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
