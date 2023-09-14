import 'dart:ffi';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../../data/models/invoice_model.dart';

class InvoicesRepo {
  final _firestore = FirebaseFirestore.instance;

  List<DioExceptionType> dioErrors = [
    DioExceptionType.connectionTimeout,
    DioExceptionType.sendTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.badCertificate,
    DioExceptionType.badResponse,
    DioExceptionType.cancel,
    DioExceptionType.connectionError,
    DioExceptionType.unknown,
  ];

  final Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5)));

  Future<List<Invoice>> fetchInvoices(String fetchedUid) async {
    try {
      var invColl = await _firestore.collection("public_invoices");

      List<Invoice> invoiceList = [];

      var querySnapshot = await invColl.get();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        invoiceList.add(
          Invoice.fromJson(data),
        ); // <-- Retrieving the value.
      }

      // await invColl.get().then(
      //       (value) => {
      //         value.docs.forEach(
      //           (element) {
      //             invoiceList.add(
      //               Invoice.fromJson(element.data()),
      //             );
      //           },
      //         ),
      //       },
      //     );
      print(invoiceList.length);
      return invoiceList;
    } catch (e) {
      rethrow;
    }
  }
}
