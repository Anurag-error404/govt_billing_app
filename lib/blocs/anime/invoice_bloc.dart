import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_bloc_with_apis/features/posts/models/post_data_ui_model.dart';
// import 'package:flutter_bloc_with_apis/features/posts/repos/posts_repo.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import '../../data/models/invoice_model.dart';
import '../../data/repo/invoices_repo.dart';
import 'invoice_events.dart';
import 'invoice_states.dart';

class InvoiceFetchBloc
    extends Bloc<InvoiceFetchEvent, InvoiceFetchState> {
  InvoiceFetchBloc() : super(InvoiceFetchInitial()) {
    on<InvoiceFetchInitialEvent>((event, emit) async {
      emit(InvoiceFetchLoadingState());
      try {
        List<Invoice> invoiceList =
            await InvoicesRepo().fetchInvoices(event.uid);
        emit(InvoiceFetchSuccessfulState(invoiceList: invoiceList));
      } catch (error) {
        emit(InvoiceFetchErrorState());
      }
    });
  }
}
