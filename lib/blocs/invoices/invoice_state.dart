part of 'invoice_cubit.dart';

class InvoiceState extends Equatable {
  final List<Invoice>? invoiceList;
  final Invoice? invoiceDetail;
  final AddInvState? addInvState;

  final List<InvoiceItem>? invoiceItems;
  final double? subtotal;

  const InvoiceState({
    this.invoiceList,
    this.invoiceDetail,
    this.invoiceItems,
    this.subtotal,
    this.addInvState,
  });

  InvoiceState copyWith({
    List<Invoice>? invoiceList,
    Invoice? invoiceDetail,
    List<InvoiceItem>? invoiceItems,
    double? subtotal,
    AddInvState? addInvState,
  }) {
    return InvoiceState(
      invoiceList: invoiceList ?? this.invoiceList,
      invoiceDetail: invoiceDetail ?? this.invoiceDetail,
      invoiceItems: invoiceItems ?? this.invoiceItems,
      subtotal: subtotal ?? 0,
      addInvState: addInvState ?? this.addInvState,
    );
  }

  @override
  List<Object?> get props => [
        invoiceList,
        invoiceDetail,
        invoiceItems,
        subtotal,
      ];
}

enum AddInvState { loading, done, error }
