// import 'package:anime_track/size_config.dart';
import 'package:flutter/material.dart';

class LoaderDialog extends StatelessWidget {
  final double w;
  const LoaderDialog({super.key, required this.w});

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        child: Center(
          // child: Image.asset(
          //   'assets/loader/loader.gif', // Put your gif into the assets folder
          //   width: w,
          // ),
        ),
      ),
    );
  }
}
