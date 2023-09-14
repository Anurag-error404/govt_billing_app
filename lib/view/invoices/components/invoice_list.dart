import 'dart:io';
import 'dart:math';
import 'dart:ui';

// import 'package:anime_track/bloc/user/user_events.dart';
// import 'package:anime_track/models/watchlist_model.dart';
// import 'package:anime_track/bloc/anime/anime_bloc.dart';
// import 'package:anime_track/bloc/anime/anime_events.dart';
// import 'package:anime_track/helper_screens/error_screen.dart';
// import 'package:anime_track/helper_screens/no_results.dart';
// import 'package:anime_track/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:govt_billing/blocs/anime/invoice_bloc.dart';
import 'package:govt_billing/common/constants/color.dart';
import 'package:govt_billing/view/invoice_detail_screen.dart';
import 'package:path_provider/path_provider.dart';

import '../../../blocs/anime/invoice_events.dart';
import '../../../blocs/anime/invoice_states.dart';
import '../../../blocs/user/user_states.dart';
import '../../../blocS/user/user_bloc.dart';
import '../../../common/utils/size_config.dart';
import '../../../data/models/invoice_model.dart';
import '../../../helper_screens/loader_dialog.dart';
// import '../../bloc/user/user_bloc.dart';
// import '../../bloc/user/user_states.dart';
// import '../../colors.dart';
// import '../anime_detail/anime_detail.dart';
// import '../../bloc/anime/anime_states.dart';
// import '../../helper_screens/loader_dialog.dart';

// import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class InvoiceListBody extends StatefulWidget {
  const InvoiceListBody({
    super.key,
  });

  @override
  State<InvoiceListBody> createState() => _InvoiceListBodyState();
}

class _InvoiceListBodyState extends State<InvoiceListBody> {
  final User? user = FirebaseAuth.instance.currentUser;
  final InvoiceFetchBloc _invoiceFetchBloc = InvoiceFetchBloc();
  // final UserActivityBloc _userActivityBloc = UserActivityBloc();

  void initState() {
    // _favouritesFetchBloc.add(FavouritesFetchInitialEvent(user!.uid));
    _invoiceFetchBloc.add(InvoiceFetchInitialEvent(user!.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<InvoiceFetchBloc, InvoiceFetchState>(
      bloc: _invoiceFetchBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case InvoiceFetchLoadingState:
            return LoaderDialog(w: SizeConfig.screenWidth * 0.4);

          case InvoiceFetchSuccessfulState:
            final invoiceState = state as InvoiceFetchSuccessfulState;
            // List<InvoiceTile> watchlistAnime = watchlistState.watchlist;
            if (invoiceState.invoiceList.isNotEmpty) {
              invoiceState.invoiceList.sort((a, b) {
                return a.invDate!
                    .toLowerCase()
                    .compareTo(b.invDate!.toLowerCase());
              });
              return SingleChildScrollView(
                child: Container(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.transparent,
                      height: 2,
                    ),
                    itemCount: invoiceState.invoiceList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // padding: EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                                    builder: (context) => InvoiceDetailScreen(
                                          id: invoiceState
                                              .invoiceList[index].invNumber
                                              .toString(),
                                        )));
                          },
                          child: Card(
                            // color: kBgColor2,
                            borderOnForeground: true,
                            // shape: RoundedRectangleBorder(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(10))),
                            elevation: 0,
                            // shadowColor: kTextColor,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                // padding: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          "Invoice #${invoiceState.invoiceList[index].invNumber}",
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.04,
                                                color: hintcolor
                                          )),
                                    ),
                                    ListTile(
                                      leading: IconButton(
                                        icon: Icon(
                                          Icons.mail,
                                          color: primaryColor,
                                        ),
                                        onPressed: () {
                                          getCsv(
                                              invoiceState.invoiceList[index]);
                                        },
                                      ),
                                      title: Text(
                                          invoiceState
                                              .invoiceList[index].toName!,
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.05,
                                          )),
                                      subtitle: Text(invoiceState
                                          .invoiceList[index].invDate!),
                                      trailing: Text(
                                        "Rs. ${invoiceState.invoiceList[index].grandTotal!}",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.05,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            // return NoResultsScreen();
            return Container();

          case InvoiceFetchErrorState:
            // return ErrorScreen();
            return Container();

          default:
            return Container();
        }
      },
    );
  }

  late String filePath;

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    filePath = '$path/invoice.csv';
    return File('$path/invoice.csv').create();
  }

  getCsv(Invoice inv) async {
    List<List<dynamic>> rows = <List<dynamic>>[];

    rows.add([
      "Invoice Number",
      "Date Created",
      "Company Email",
      "Company Slogan",
      "Recipient Name",
      "Recipient Address",
      "Recipient City",
      "Recipient State",
      "Recipient Pincode",
      // "Recipient Phone"
      "Sender Name",
      "Sender Address",
      "Sender City",
      "Sender State",
      "Sender Pincode",
      "Sender Phone",
      "Subtotal",
      "Tax Rate",
      "Tax",
      "Grand Total",
      // "Entries"
    ]);

    if (inv != null) {
      List<dynamic> row = <dynamic>[];
      row.add(inv.invNumber);
      row.add(inv.invDate);
      row.add(inv.companyEmail);
      row.add(inv.companySlogan);
      row.add(inv.toName);
      row.add(inv.toAddress);
      row.add(inv.toCity);
      row.add(inv.toState);
      row.add(inv.toZip);
      row.add(inv.fromName);
      row.add(inv.fromAddress);
      row.add(inv.fromCity);
      row.add(inv.fromState);
      row.add(inv.fromZip);
      row.add(inv.fromPhone);
      row.add(inv.subtotal);
      row.add(inv.taxRate);
      row.add(inv.tax);
      row.add(inv.grandTotal);
      rows.add(row);

      File f = await _localFile;

      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
    }

    final Email email = Email(
      body: 'Hey, the CSV made it!',
      subject: 'Datum Entry for ${DateTime.now().toString()}',
      recipients: [user!.email!],
      isHTML: true,
      attachmentPaths: [filePath],
    );

    await FlutterEmailSender.send(email);
  }
}
