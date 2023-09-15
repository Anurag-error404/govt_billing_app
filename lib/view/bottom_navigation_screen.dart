import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:govt_billing/blocs/invoices/invoice_cubit.dart';
import 'package:govt_billing/view/export_invoice_screen.dart';
import 'package:govt_billing/view/profile/profile_body.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../blocS/user/user_bloc.dart';
import '../blocS/user/user_events.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_events.dart';
import '../common/constants/color.dart';
import 'invoices/invoices_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final PersistentTabController _controller = PersistentTabController();

  final User? user = FirebaseAuth.instance.currentUser;
  final UserDataBloc _userBloc = UserDataBloc();
  final AppBloc _appBloc = AppBloc();

  @override
  void initState() {
    _userBloc.add(UserDataInitialFetchEvent(user!));
    _appBloc.add(const AppEventInitialize());
    context.read<InvoiceCubit>().getInvoiceList(user!.uid);
    super.initState();
  }

  final List<Widget> _screens = [
    const InvoicesScreen(),
    const ExportInvoiceScreen(),
    const ProfileBody(),
  ];

  final List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
      icon: const FaIcon(FontAwesomeIcons.receipt),
      title: "Invoices",
      activeColorPrimary: primaryColor,
      inactiveColorPrimary: Colors.black54,
    ),
    PersistentBottomNavBarItem(
      icon: const FaIcon(FontAwesomeIcons.fileExport),
      title: "Export",
      activeColorPrimary: primaryColor,
      inactiveColorPrimary: Colors.black54,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: "Profile",
      activeColorPrimary: primaryColor,
      inactiveColorPrimary: Colors.black54,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        // onWillPop: (context) async => false,
        screens: _screens,
        controller: _controller,
        items: _items,
        navBarStyle: NavBarStyle.style3,
        backgroundColor: const Color(0xfffcfdff),
      ),
    );
  }
}
