import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
}
