part of 'invoice_cubit.dart';

class InvoiceState extends Equatable {
  final List<Invoice>? invoiceList;

  const InvoiceState({this.invoiceList});

  @override
  List<Object?> get props => [
        invoiceList,
      ];
}
