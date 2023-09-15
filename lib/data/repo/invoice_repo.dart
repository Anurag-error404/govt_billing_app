import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/invoice_model.dart';

class InvoiceRepo {
  static String invoiceCollection = "public_invoices";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future bulkAddInvoices(List<Map<String, dynamic>> data) async {
    for (var element in data) {
      try {
        await firestore
            .collection(invoiceCollection)
            .doc(element['id'])
            .set(Invoice.fromJson(element).toJson());
      } catch (e, stackTrace) {
        log(e.toString(), stackTrace: stackTrace);
      }
    }
  }

  Future addNewInvoice({required Invoice invoice, required String userId}) async {
    try {
      String? uid = await const FlutterSecureStorage().read(key: 'uid');
      await firestore.collection(invoiceCollection).doc(invoice.id).set(invoice.toJson());
      await firestore
          .collection("users")
          .doc(uid)
          .collection("invoices")
          .doc(invoice.id)
          .set(invoice.toJson());

      return true;
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
    }
    return false;
  }

  Future<Invoice?> getInvoiceDetail(String invoiceId) async {
    var res = await firestore.collection(invoiceCollection).doc(invoiceId).get();
    if (res.data() != null) {
      return Invoice.fromJson(res.data()!);
    } else {
      return Invoice();
    }
  }

  Future<List<Invoice>?> getInvoiceList(String userId) async {
    try {
      // var res = await firestore.collection(invoiceCollection).get();
      String? uid = await const FlutterSecureStorage().read(key: 'uid');

      var res = await firestore.collection("users").doc(uid).collection("invoices").get();
      List<Invoice> resInvoiceList = [];
      for (var element in res.docs) {
        resInvoiceList.add(Invoice.fromJson(element.data()));
      }
      return resInvoiceList;
    } catch (e, stacktrace) {
      log(e.toString(), stackTrace: stacktrace);
    }

    return null;
  }

  Future<List<Invoice>?> getRangeInvoice({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      var res = await firestore
          .collection("users")
          .doc(userId)
          .collection("invoices")
          .where(
            'inv_date',
            isGreaterThanOrEqualTo: startDate,
            isLessThanOrEqualTo: endDate,
          )
          .get();
      List<Invoice> resInvoiceList = [];
      for (var element in res.docs) {
        resInvoiceList.add(Invoice.fromJson(element.data()));
      }
      return resInvoiceList;
    } catch (e, stacktrace) {
      log(e.toString(), stackTrace: stacktrace);
    }

    return null;
  }
}
