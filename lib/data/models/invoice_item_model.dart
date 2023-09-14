class InvoiceItem {
  final String desc;
  final int qty;
  final double price;
  final double total;

  const InvoiceItem({
    required this.qty,
    required this.price,
    required this.total,
    required this.desc,
  });
}
