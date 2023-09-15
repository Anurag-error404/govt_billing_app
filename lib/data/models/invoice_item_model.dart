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

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
        desc: json["description"],
        qty: json["qty"],
        total: json["total"]?.toDouble(),
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "description": desc,
        "total": total,
        "qty": qty,
        "price": price,
      };
}
