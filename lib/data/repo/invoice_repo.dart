import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/invoice_model.dart';

class InvoiceRepo {
  static String invoiceCollection = "public_invoices";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future bulkAddInvoices(List<Map<String, dynamic>> data) async {
    for (var element in data) {
      try {
        print(element['id']);
        await firestore
            .collection(invoiceCollection)
            .doc(element['id'])
            .set(Invoice.fromJson(element).toJson());
      } catch (e, stackTrace) {
        log(e.toString(), stackTrace: stackTrace);
      }
    }
  }

  Future<List<Invoice>?> getInvoiceDetail() async {}
}
