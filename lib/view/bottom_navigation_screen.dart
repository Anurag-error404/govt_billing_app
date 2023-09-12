import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../common/constants/color.dart';
import 'home_screen.dart';
import 'invoices_screen.dart';
import 'profile_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final PersistentTabController _controller = PersistentTabController();

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const InvoicesScreen(),
    const ProfileScreen(),
  ];

  final List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
      icon: const FaIcon(FontAwesomeIcons.moneyBillTransfer),
      title: "Home",
      activeColorPrimary: primaryColor,
      inactiveColorPrimary: Colors.black54,
    ),
    PersistentBottomNavBarItem(
      icon: const FaIcon(FontAwesomeIcons.receipt),
      title: "Invoices",
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
        onWillPop: (context) async => false,
        screens: _screens,
        controller: _controller,
        items: _items,
        navBarStyle: NavBarStyle.style3,
        backgroundColor: const Color(0xfffcfdff),
      ),
    );
  }
}
