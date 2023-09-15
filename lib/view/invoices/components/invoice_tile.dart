import 'package:flutter/material.dart';
import 'package:govt_billing/common/constants/color.dart';
import 'package:govt_billing/common/constants/sizing.dart';
import 'package:govt_billing/common/constants/textstyles.dart';
import 'package:govt_billing/data/models/invoice_model.dart';
import 'package:govt_billing/view/invoices/invoice_detail_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class InvoiceTile extends StatelessWidget {
  final Invoice invoice;
  const InvoiceTile({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: InvoiceDetailScreen(id: invoice.id ?? ""),
          withNavBar: false,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Invoice #${invoice.invNumber}",
                  style: textStlyeMedbold.copyWith(color: Colors.grey.shade700),
                ),
              ],
            ),
            verticalSpaceDefault,
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withOpacity(0.5),
                  ),
                  child: Text(
                    invoice.toName?[0].toUpperCase() ?? "A",
                    style: textStlyebodyBold.copyWith(color: Colors.white),
                  ),
                ),
                horizontalSpaceDefault,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${invoice.toName}",
                        style: textStlyeHeading,
                      ),
                      Text(
                        "${invoice.toEmail}",
                        style: textStlyeMed,
                      ),
                      Text(
                        "${invoice.invDate}",
                        style: textStlyebody,
                      ),
                    ],
                  ),
                ),
                horizontalSpaceDefault,
                Text(
                  "₹ ${invoice.grandTotal?.toStringAsFixed(2)}",
                  style: textStlyeMedbold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
