import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:govt_billing/data/models/invoice_item_model.dart';
import 'package:govt_billing/data/repo/invoice_repo.dart';

import '../../data/models/invoice_model.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final InvoiceRepo invoiceRepo;
  InvoiceCubit(this.invoiceRepo) : super(const InvoiceState());

  addInvoiceBulk() async {
    List<Map<String, dynamic>> data = [
      {
        "user": "user123",
        "id": "20231001",
        "inv_number": 1001,
        "inv_date": "2023-09-12",
        "to_name": "John Doe",
        "to_address": "123 Main St",
        "to_city": "Anytown",
        "to_state": "CA",
        "to_zip": 12345,
        "to_email": "receiver@gmail.com",
        "from_name": "ABC Inc",
        "from_address": "456 Elm St",
        "from_city": "Anotherville",
        "from_state": "NY",
        "from_zip": 67890,
        "from_phone": "555-123-4567",
        "company_slogan": "Quality and Service",
        "company_email": "contact@abcinc.com",
        "entries": [
          {"description": "Product A", "total": 100.0, "qty": 1, "price": 100.0},
          {"description": "Service B", "total": 250.0, "qty": 5, "price": 50.0}
        ],
        "grand_total": 350.0,
        "subtotal": 350.0,
        "tax_rate": 0.08,
        "tax": 28.0,
        "discount_rate": 0.05,
        "discount": 10
      },
      {
        "user": "user123",
        "id": "20243046",
        "inv_number": 1001,
        "inv_date": "2023-09-12",
        "to_name": "John Doe",
        "to_address": "123 Main St",
        "to_city": "Anytown",
        "to_state": "CA",
        "to_zip": 12345,
        "to_email": "receiver@gmail.com",
        "from_name": "ABC Inc",
        "from_address": "456 Elm St",
        "from_city": "Anotherville",
        "from_state": "NY",
        "from_zip": 67890,
        "from_phone": "555-123-4567",
        "company_slogan": "Quality and Service",
        "company_email": "contact@abcinc.com",
        "entries": [
          {"description": "Product A", "total": 100.0, "qty": 1, "price": 100.0},
          {"description": "Service B", "total": 250.0, "qty": 5, "price": 50.0}
        ],
        "grand_total": 350.0,
        "subtotal": 350.0,
        "tax_rate": 0.08,
        "tax": 28.0,
        "discount_rate": 0.05,
        "discount": 10
      }
    ];
    await invoiceRepo.bulkAddInvoices(data);
  }

  Future<bool> addNewInvoice(Invoice inv, String uid) async {
    emit(state.copyWith(addInvState: AddInvState.loading));
    var res = await invoiceRepo.addNewInvoice(invoice: inv, userId: uid);
    if (res == true) {
      emit(state.copyWith(addInvState: AddInvState.done));
      await getInvoiceList(uid);
      print("true");
      return true;
    } else {
      emit(state.copyWith(addInvState: AddInvState.error));
      print("false");
      return false;
    }
  }

  getInvoiceList(String userId) async {
    try {
      var res = await invoiceRepo.getInvoiceList(userId);
      emit(state.copyWith(invoiceList: res));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
    }
  }

  getInvoiceDetail(String invoiceId) async {
    var res = await invoiceRepo.getInvoiceDetail(invoiceId);
    emit(state.copyWith(invoiceDetail: res));
  }

  addAdditionalQues(String desc, int qty, double price) {
    List<InvoiceItem>? itemsList = List<InvoiceItem>.from(state.invoiceItems ?? []);
    InvoiceItem newItem = InvoiceItem(desc: desc, qty: qty, price: price, total: qty * price);

    double newSubtotal = (state.subtotal ?? 0) + qty * price;
    itemsList.add(newItem);
    emit(state.copyWith(invoiceItems: itemsList, subtotal: newSubtotal));
  }

  editAdditionalQues(int idx, InvoiceItem newItem) {
    List<InvoiceItem>? itemsList = List<InvoiceItem>.from(state.invoiceItems ?? []);
    InvoiceItem delItem = itemsList[idx];

    double newSubtotal = (state.subtotal ?? 0) - delItem.total + newItem.total;
    itemsList[idx] = newItem;
    emit(state.copyWith(invoiceItems: itemsList, subtotal: newSubtotal));
  }

  deleteAdditionalQues(int idx) {
    List<InvoiceItem>? itemsList = List<InvoiceItem>.from(state.invoiceItems ?? []);
    InvoiceItem delItem = itemsList[idx];

    double newSubtotal = (state.subtotal ?? 0) - delItem.total;
    itemsList.removeAt(idx);
    emit(state.copyWith(invoiceItems: itemsList, subtotal: newSubtotal));
  }
}
