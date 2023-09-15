import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govt_billing/common/constants/color.dart';
import 'package:govt_billing/common/constants/sizing.dart';
import 'package:govt_billing/view/bottom_navigation_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../blocS/user/user_events.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_events.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_states.dart';
import '../../common/utils/size_config.dart';
import '../../dialogs/delete_account_dialog.dart';
import '../../dialogs/logout_dialog.dart';
import '../../helper_screens/loader_dialog.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final User? user = FirebaseAuth.instance.currentUser;
  final UserDataBloc _userBloc = UserDataBloc();
  final AppBloc _appBloc = AppBloc();
  @override
  void initState() {
    _userBloc.add(UserDataInitialFetchEvent(user!));
    _appBloc.add(const AppEventInitialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: RefreshIndicator(
        backgroundColor: bgColor,
        color: primaryColor,
        onRefresh: () {
          _userBloc.add(UserDataInitialFetchEvent(user!));
          return Future.delayed(const Duration(seconds: 1));
        },
        child: BlocConsumer<UserDataBloc, UserDataState>(
          bloc: _userBloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case UserDataFetchingLoadingState:
                return LoaderDialog(
                  w: SizeConfig.screenWidth * 0.4,
                );

              case UserDataFetchingSuccessfulState:
                final userState = state as UserDataFetchingSuccessfulState;
                print(userState.user.photoURL);
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints viewportConstraints) {
                    return SafeArea(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  child: Image.asset('assets/banner.png', fit: BoxFit.fitWidth),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.width * 0.05,
                                      vertical: MediaQuery.of(context).size.height * 0.1),
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        ClipRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: defaultPadding, horizontal: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  color: primaryColor),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Stack(
                                                        alignment: Alignment.bottomRight,
                                                        children: [
                                                          CachedNetworkImage(
                                                            imageUrl: userState.user.photoURL,
                                                            imageBuilder:
                                                                (context, imageProvider) =>
                                                                    Container(
                                                              width: MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.3,
                                                              height: MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.3,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                image: DecorationImage(
                                                                    image: imageProvider,
                                                                    fit: BoxFit.cover),
                                                              ),
                                                            ),
                                                            errorWidget: (context, url, error) =>
                                                                CachedNetworkImage(
                                                              imageUrl: user!.photoURL!,
                                                              errorWidget: (context, url, error) =>
                                                                  const CircleAvatar(),
                                                            ),
                                                            placeholder: (context, url) =>
                                                                Shimmer.fromColors(
                                                                    baseColor: whiteOpacity54,
                                                                    highlightColor: primaryColor,
                                                                    child: Container(
                                                                      color: whiteOpacity54,
                                                                    )),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Welcome",
                                                              style: TextStyle(
                                                                  color: bgColor,
                                                                  fontSize: SizeConfig.screenWidth *
                                                                      0.05)),
                                                          Text(
                                                              userState.user.name
                                                                  .split(" ")
                                                                  .sublist(0, 1)
                                                                  .join("\n"),
                                                              style: TextStyle(
                                                                  color: bgColor,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: SizeConfig.screenWidth *
                                                                      0.07)),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  verticalSpaceDefault,
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        verticalSpaceDefault,
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context, rootNavigator: true)
                                                .pushReplacement(MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BottomNavigationScreen()));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(5)),
                                            margin: const EdgeInsets.symmetric(vertical: 0),
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding, 0, defaultPadding, 0),
                                            height: MediaQuery.of(context).size.width * 0.15,
                                            width: MediaQuery.of(context).size.width,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "View",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: SizeConfig.screenWidth * 0.04),
                                                ),
                                                Text(
                                                  "Your Invoices",
                                                  style: TextStyle(
                                                      color: bgColor,
                                                      fontSize: SizeConfig.screenWidth * 0.04,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        verticalSpaceDefault,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            profileButton("Log", "Out", () async {
                                              final shouldLogOut = await showLogOutDialog(context);
                                              if (shouldLogOut) {
                                                context.read<AppBloc>().add(
                                                      const AppEventLogOut(),
                                                    );
                                              }
                                            }, primaryColor),
                                            const VerticalDivider(
                                              width: 3,
                                            ),
                                            profileButton("Delete", "Your Account", () async {
                                              final shouldDeleteAccount =
                                                  await showDeleteAccountDialog(context);
                                              if (shouldDeleteAccount) {
                                                context.read<AppBloc>().add(
                                                      const AppEventDeleteAccount(),
                                                    );
                                              }
                                            }, Colors.red),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                );

              case UserDataFetchingErrorState:
                return Container();

              default:
                return Container();
            }
          },
        ),
      ),
    );
  }

  Widget profileButton(String text1, String text2, Function func, Color color) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          func();
        },
        child: Container(
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.symmetric(vertical: 0),
          padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
          height: MediaQuery.of(context).size.width * 0.15,
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text1,
                style: TextStyle(color: bgColor, fontSize: SizeConfig.screenWidth * 0.04),
              ),
              Text(
                text2,
                style: TextStyle(
                    color: bgColor,
                    fontSize: SizeConfig.screenWidth * 0.04,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
