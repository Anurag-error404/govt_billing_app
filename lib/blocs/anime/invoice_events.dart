import 'package:flutter/foundation.dart';
import '../../data/models/invoice_model.dart';

@immutable
abstract class WatchStatusFetchEvent {}

class WatchStatusFetchInitialEvent extends WatchStatusFetchEvent {
  final String uid;
  final Invoice invoice;
  WatchStatusFetchInitialEvent(this.uid, this.invoice);
}

@immutable
abstract class InvoiceFetchEvent {}

class InvoiceFetchInitialEvent extends InvoiceFetchEvent {
  final String uid;

  InvoiceFetchInitialEvent(this.uid);
}
