import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govt_billing/blocs/auth/auth_bloc.dart';
import 'package:govt_billing/blocs/invoices/invoice_cubit.dart';
import 'package:govt_billing/common/routes/routes.dart';
import 'package:govt_billing/data/repo/auth_repo.dart';
import 'package:govt_billing/data/repo/invoice_repo.dart';
import 'package:govt_billing/services/dynamic_links_service.dart';

import 'blocs/auth/auth_events.dart';
import 'common/constants/color.dart';
import 'common/utils/app_bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Paint.enableDithering = true;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: primaryColor, // status bar color
  ));
  DynamicLinkService().handleDynamicLinks();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepo>(create: (context) => AuthRepo()),
        RepositoryProvider<InvoiceRepo>(create: (context) => InvoiceRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(create: (_) => AppBloc()..add(const AppEventInitialize())),
          BlocProvider(create: (context) => InvoiceCubit(InvoiceRepo())),
        ],
        child: MaterialApp.router(
          // home: const LandingScreen(),
          routerConfig: goRoutes,
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
