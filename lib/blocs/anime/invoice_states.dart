import 'package:flutter/foundation.dart';
import '../../data/models/invoice_model.dart';

@immutable
abstract class InvoiceFetchState {}

class InvoiceFetchInitial extends InvoiceFetchState {}

class InvoiceFetchLoadingState extends InvoiceFetchState {}

class InvoiceFetchErrorState extends InvoiceFetchState {}

class InvoiceFetchSuccessfulState extends InvoiceFetchState {
  final List<Invoice> invoiceList;
  InvoiceFetchSuccessfulState({required this.invoiceList});
}
