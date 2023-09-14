import 'package:flutter/material.dart';
import 'package:govt_billing/common/constants/color.dart';
import 'package:govt_billing/common/constants/sizing.dart';
import 'package:govt_billing/common/constants/textstyles.dart';
import 'package:govt_billing/data/models/invoice_item_model.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final String id;
  const InvoiceDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    List<InvoiceItem> items = [
      const InvoiceItem(qty: 1, price: 50, total: 50, desc: "Air Bag"),
      const InvoiceItem(qty: 1, price: 50, total: 50, desc: "Air Bag"),
      const InvoiceItem(qty: 1, price: 50, total: 50, desc: "Air Bag"),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "G",
                            style: textStlyeMed.copyWith(color: Colors.white),
                          ),
                        ),
                        horizontalSpaceDefault,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                "Invoice #000153",
                                style: textStlyeHeading,
                              ),
                              Text(
                                "Tnp NSUT",
                                style: textStlyeMed,
                              ),
                              Text(
                                "tnpnsut@gmail.com",
                                style: textStlyebody,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceDefault,
                    const Divider(),
                    verticalSpaceDefault,
                    SizedBox(
                      // decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                      height: 130,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Bill to :',
                                  style: textStlyebody,
                                ),
                                verticalSpaceSmall,
                                Text(
                                  "Anurag Verma",
                                  style: textStlyeMedbold,
                                ),
                                verticalSpaceSmall,
                                Text(
                                  "anuragdl2276@gmail.com",
                                  style: textStlyebody,
                                ),
                                Spacer(),
                                Text(
                                  "H no 75 Gali no 13 vipin garden extn dwarka mor, uttam nagar, new delhi - 59",
                                  style: textStlyebody,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  'Invoice Date :',
                                  style: textStlyebody,
                                ),
                                verticalSpaceDefault,
                                Text(
                                  "Aug 17, 2023",
                                  style: textStlyeMedbold,
                                ),
                                Spacer(),
                                Text(
                                  'Invoice Status :',
                                  style: textStlyebody,
                                ),
                                Text(
                                  "Paid",
                                  style: textStlyeMedbold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceDefault,
                    const Divider(),
                    const Text(
                      'Items',
                      style: textStlyebody,
                    ),
                    verticalSpaceSmall,
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      color: Colors.blueGrey.shade100,
                      child: Row(
                        children: const [
                          Expanded(flex: 5, child: Text("Description")),
                          horizontalSpaceSmall,
                          Expanded(flex: 1, child: Text("Qty")),
                          horizontalSpaceSmall,
                          Expanded(flex: 2, child: Text("Price")),
                          horizontalSpaceSmall,
                          Expanded(flex: 2, child: Text("Total")),
                        ],
                      ),
                    ),
                    verticalSpaceDefault,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InvoiceItemTile(item: items[index]),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: items.length,
                    ),
                    verticalSpaceDefault,
                    verticalSpaceDefault,
                    Row(
                      children: const [
                        Expanded(
                          flex: 8,
                          child: Text(
                            "Subtotal",
                            textAlign: TextAlign.end,
                            style: textStlyebody,
                          ),
                        ),
                        horizontalSpaceDefault,
                        Expanded(
                          flex: 2,
                          child: Text(
                            "2500",
                            style: textStlyebodyBold,
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceDefault,
                    Row(
                      children: const [
                        Expanded(
                          flex: 8,
                          child: Text(
                            "Discount (5%)",
                            textAlign: TextAlign.end,
                            style: textStlyebody,
                          ),
                        ),
                        horizontalSpaceDefault,
                        Expanded(
                          flex: 2,
                          child: Text(
                            "-125",
                            style: textStlyebodyBold,
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceDefault,
                    Row(
                      children: const [
                        Expanded(
                          flex: 8,
                          child: Text(
                            "Tax (3%)",
                            textAlign: TextAlign.end,
                            style: textStlyebody,
                          ),
                        ),
                        horizontalSpaceDefault,
                        Expanded(
                          flex: 2,
                          child: Text(
                            "54",
                            style: textStlyebodyBold,
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceDefault,
                    const Divider(),
                    Row(
                      children: const [
                        Expanded(
                          flex: 8,
                          child: Text(
                            "Grand Total",
                            textAlign: TextAlign.end,
                            style: textStlyebodyBold,
                          ),
                        ),
                        horizontalSpaceDefault,
                        Expanded(
                          flex: 2,
                          child: Text(
                            "2945",
                            style: textStlyebodyBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceItemTile extends StatelessWidget {
  final InvoiceItem item;
  const InvoiceItemTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        horizontalSpaceSmall,
        Expanded(flex: 5, child: Text(item.desc)),
        horizontalSpaceSmall,
        Expanded(
            flex: 1,
            child: Text(
              "${item.qty}",
              textAlign: TextAlign.center,
            )),
        horizontalSpaceSmall,
        Expanded(flex: 2, child: Text("${item.price}")),
        horizontalSpaceSmall,
        Expanded(flex: 2, child: Text("${item.total}")),
      ],
    );
  }
}
