import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govt_billing/blocs/invoices/invoice_cubit.dart';
import 'package:govt_billing/common/constants/color.dart';
import 'package:govt_billing/common/constants/sizing.dart';
import 'package:govt_billing/common/constants/textstyles.dart';
import 'package:govt_billing/data/models/invoice_item_model.dart';
import 'package:govt_billing/services/dynamic_links_service.dart';
import 'package:share_plus/share_plus.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final String id;
  const InvoiceDetailScreen({super.key, required this.id});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  @override
  void initState() {
    context.read<InvoiceCubit>().getInvoiceDetail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Invoice Detail",
          style: textStlyeHeading.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                var res = await DynamicLinkService().createNewDynamicLink(widget.id);
                Share.share("Checkout this invoice $res");
              },
              icon: const Icon(Icons.share)),
        ],
      ),
      body: BlocBuilder<InvoiceCubit, InvoiceState>(
        builder: (context, state) {
          return SafeArea(
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
                                state.invoiceDetail?.toName?[0].toUpperCase() ?? "A",
                                style: textStlyeMed.copyWith(color: Colors.white),
                              ),
                            ),
                            horizontalSpaceDefault,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Invoice #${state.invoiceDetail?.invNumber}",
                                    style: textStlyeHeading,
                                  ),
                                  Text(
                                    "${state.invoiceDetail?.fromName}",
                                    style: textStlyeMed,
                                  ),
                                  Text(
                                    "${state.invoiceDetail?.fromEmail}",
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
                                  children: [
                                    const Text(
                                      'Bill to :',
                                      style: textStlyebody,
                                    ),
                                    verticalSpaceSmall,
                                    Text(
                                      "${state.invoiceDetail?.toName}",
                                      style: textStlyeMedbold,
                                    ),
                                    verticalSpaceSmall,
                                    Text(
                                      "${state.invoiceDetail?.toEmail}",
                                      style: textStlyebody,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${state.invoiceDetail?.toAddress}, ${state.invoiceDetail?.toCity}, ${state.invoiceDetail?.toState}, Pincode - ${state.invoiceDetail?.toZip}",
                                      style: textStlyebody,
                                    ),
                                  ],
                                ),
                              ),
                              horizontalSpaceDefault,
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Invoice Date :',
                                      style: textStlyebody,
                                    ),
                                    verticalSpaceDefault,
                                    Text(
                                      "${state.invoiceDetail?.invDate}",
                                      style: textStlyeMedbold,
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Invoice Status :',
                                      style: textStlyebody,
                                    ),
                                    const Text(
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
                          itemBuilder: (context, index) =>
                              InvoiceItemTile(item: state.invoiceDetail!.entries![index]),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: state.invoiceDetail?.entries?.length ?? 0,
                        ),
                        verticalSpaceDefault,
                        verticalSpaceDefault,
                        Row(
                          children: [
                            const Expanded(
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
                                "${state.invoiceDetail?.subtotal}",
                                style: textStlyebodyBold,
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceDefault,
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Discount (${state.invoiceDetail?.discountRate}%)",
                                textAlign: TextAlign.end,
                                style: textStlyebody,
                              ),
                            ),
                            horizontalSpaceDefault,
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${state.invoiceDetail?.discount}",
                                style: textStlyebodyBold,
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceDefault,
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Tax (${state.invoiceDetail?.taxRate}%)",
                                textAlign: TextAlign.end,
                                style: textStlyebody,
                              ),
                            ),
                            horizontalSpaceDefault,
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${state.invoiceDetail?.tax}",
                                style: textStlyebodyBold,
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceDefault,
                        const Divider(),
                        Row(
                          children: [
                            const Expanded(
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
                                "${state.invoiceDetail?.grandTotal}",
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
          );
        },
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
