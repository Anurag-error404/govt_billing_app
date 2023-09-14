// To parse this JSON data, do
//
//     final generalResponseModel = generalResponseModelFromJson(jsonString);

import 'dart:convert';

List<Invoice> generalResponseModelFromJson(List<dynamic> list) =>
    List<Invoice>.from(list.map((x) => Invoice.fromJson(x)));

String generalResponseModelToJson(List<Invoice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Invoice {
  final String? user;
  final String? id;
  final int? invNumber;
  final String? invDate;
  final String? toName;
  final String? toAddress;
  final String? toCity;
  final String? toState;
  final int? toZip;
  final String? toEmail;
  final String? fromName;
  final String? fromAddress;
  final String? fromCity;
  final String? fromState;
  final int? fromZip;
  final String? fromPhone;
  final String? companySlogan;
  final String? companyEmail;
  final List<Entry>? entries;
  final double? grandTotal;
  final double? subtotal;
  final double? taxRate;
  final double? tax;
  final double? discountRate;
  final double? discount;

  Invoice({
    this.user,
    this.id,
    this.invNumber,
    this.invDate,
    this.toName,
    this.toAddress,
    this.toCity,
    this.toState,
    this.toZip,
    this.toEmail,
    this.fromName,
    this.fromAddress,
    this.fromCity,
    this.fromState,
    this.fromZip,
    this.fromPhone,
    this.companySlogan,
    this.companyEmail,
    this.entries,
    this.grandTotal,
    this.subtotal,
    this.taxRate,
    this.tax,
    this.discountRate,
    this.discount,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        user: json["user"],
        id: json["id"],
        invNumber: json["inv_number"],
        invDate: json["inv_date"],
        toName: json["to_name"],
        toAddress: json["to_address"],
        toCity: json["to_city"],
        toState: json["to_state"],
        toZip: json["to_zip"],
        toEmail: json["to_email"],
        fromName: json["from_name"],
        fromAddress: json["from_address"],
        fromCity: json["from_city"],
        fromState: json["from_state"],
        fromZip: json["from_zip"],
        fromPhone: json["from_phone"],
        companySlogan: json["company_slogan"],
        companyEmail: json["company_email"],
        entries: json["entries"] == null
            ? []
            : List<Entry>.from(json["entries"]!.map((x) => Entry.fromJson(x))),
        grandTotal: json["grand_total"]?.toDouble(),
        subtotal: json["subtotal"]?.toDouble(),
        taxRate: json["tax_rate"]?.toDouble(),
        tax: json["tax"]?.toDouble(),
        discountRate: json["discount_rate"]?.toDouble(),
        discount: json["discount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "id": id,
        "inv_number": invNumber,
        "inv_date": invDate,
        "to_name": toName,
        "to_address": toAddress,
        "to_city": toCity,
        "to_state": toState,
        "to_zip": toZip,
        "to_email": toEmail,
        "from_name": fromName,
        "from_address": fromAddress,
        "from_city": fromCity,
        "from_state": fromState,
        "from_zip": fromZip,
        "from_phone": fromPhone,
        "company_slogan": companySlogan,
        "company_email": companyEmail,
        "entries": entries == null ? [] : List<dynamic>.from(entries!.map((x) => x.toJson())),
        "grand_total": grandTotal,
        "subtotal": subtotal,
        "tax_rate": taxRate,
        "tax": tax,
        "discount_rate": discountRate,
        "discount": discount,
      };
}

class Entry {
  final String? description;
  final int? qty;
  final double? total;
  final double? price;

  Entry({
    this.description,
    this.total,
    this.qty,
    this.price,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        description: json["description"],
        qty: json["qty"],
        total: json["total"]?.toDouble(),
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "total": total,
        "qty": qty,
        "price": price,
      };
}
