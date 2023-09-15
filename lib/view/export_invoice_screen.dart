import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:govt_billing/common/constants/sizing.dart';
import 'package:govt_billing/common/constants/textstyles.dart';
import 'package:path_provider/path_provider.dart';

import '../data/models/invoice_model.dart';

class ExportInvoiceScreen extends StatefulWidget {
  const ExportInvoiceScreen({super.key});

  @override
  State<ExportInvoiceScreen> createState() => _ExportInvoiceScreenState();
}

class _ExportInvoiceScreenState extends State<ExportInvoiceScreen> {
  String? filePath;

  String? currentProcess;
  bool isProcessing = false;

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    filePath = '$path/data.csv';
    return File('$path/data.csv').create();
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  String? uid;
  String? useremail;

  getUserInfo() async {
    String? uidTemp = await const FlutterSecureStorage().read(key: 'uid');
    String? emailTemp = await const FlutterSecureStorage().read(key: 'email');

    setState(() {
      uid = uidTemp;
      useremail = emailTemp;
    });
  }

  getCsv() async {
    setState(() {
      currentProcess = "Getting data from the cloud";
      isProcessing = true;
    });
    List<List<dynamic>> rows = [];
    var res = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("invoices")
        .get()
        .whenComplete(() {
      setState(() {
        currentProcess = "Decoding data";
      });
    });
    rows.add([
      "Id",
      "Name",
      "Email",
      "Address",
      "City",
      "State",
      "Pincode",
      "Subtotal",
      "Discount %",
      "Discount",
      "Tax %",
      "Tax",
      "Grand Total",
    ]);

    List<Invoice> resInvoiceList = [];
    for (var element in res.docs) {
      resInvoiceList.add(Invoice.fromJson(element.data()));
    }
    for (int i = 0; i < resInvoiceList.length; i++) {
      List<dynamic> row = [];
      row.add(resInvoiceList[i].id);
      row.add(resInvoiceList[i].toName);
      row.add(resInvoiceList[i].toEmail);
      row.add(resInvoiceList[i].toAddress);
      row.add(resInvoiceList[i].toCity);
      row.add(resInvoiceList[i].toState);
      row.add(resInvoiceList[i].toZip);
      row.add(resInvoiceList[i].subtotal);
      row.add(resInvoiceList[i].discountRate);
      row.add(resInvoiceList[i].discount);
      row.add(resInvoiceList[i].taxRate);
      row.add(resInvoiceList[i].tax);
      row.add(resInvoiceList[i].grandTotal);
      rows.add(row);
    }

    File f = await _localFile.whenComplete(() {
      setState(() {
        currentProcess = "Writing to CSV";
      });
    });
    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);
  }

  sendMailAndAttachment() async {
    final Email email = Email(
      body: 'Hey, checkout the invoices',
      subject: 'Invoices Entry for ${DateTime.now().toString()}',
      recipients: [useremail.toString()],
      isHTML: true,
      attachmentPaths: [filePath.toString()],
    );

    // await FlutterEmailSender.send(email);
    try {
      await FlutterEmailSender.send(email);
      // platformResponse = 'success';
    } catch (error) {
      print(error);
      // platformResponse = error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Export Invoice",
          style: textStlyeHeading.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Request Invoices mailed to you at at anuragdl2276@gmail.com",
                style: textStlyeMed,
              ),
            ),
            verticalSpaceDefault,
            MaterialButton(
              onPressed: () async {
                await getCsv().then((v) {
                  setState(() {
                    currentProcess = "Compiling and sending mail";
                  });
                  sendMailAndAttachment().whenComplete(() {
                    setState(() {
                      isProcessing = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Invoices Sent"),
                    ));
                  });
                });
              },
              color: Colors.orangeAccent,
              child: const Text("Export Invoices"),
            )
          ],
        ),
      ),
    );
  }
}
