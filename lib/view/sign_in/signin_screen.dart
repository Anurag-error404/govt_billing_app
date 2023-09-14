import 'package:flutter/material.dart';

import 'components/body.dart';
import '../../common/constants/color.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Body(),
    );
  }
}
