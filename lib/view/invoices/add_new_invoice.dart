// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:govt_billing/blocs/invoices/invoice_cubit.dart';
import 'package:govt_billing/common/constants/color.dart';
import 'package:govt_billing/common/constants/sizing.dart';
import 'package:govt_billing/common/constants/textstyles.dart';
import 'package:govt_billing/common/widgets/custom_textfield.dart';
import 'package:govt_billing/data/models/invoice_item_model.dart';
import 'package:govt_billing/view/invoices/components/add_item_helper.dart';
import 'package:govt_billing/view/invoices/invoice_detail_screen.dart';
import 'package:intl/intl.dart';

import '../../common/widgets/submit_button.dart';
import '../../data/models/invoice_model.dart';

class AddNewInvoice extends StatefulWidget {
  const AddNewInvoice({super.key});

  @override
  State<AddNewInvoice> createState() => _AddNewInvoiceState();
}

class _AddNewInvoiceState extends State<AddNewInvoice> {
  final _formKey = GlobalKey<FormState>();
  String invNumber = "";

  final TextEditingController _toName = TextEditingController();
  final TextEditingController _toAddress = TextEditingController();
  final TextEditingController _toCity = TextEditingController();
  final TextEditingController _toState = TextEditingController();
  final TextEditingController _toZip = TextEditingController();
  final TextEditingController _toEmail = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _tax = TextEditingController();

  @override
  void initState() {
    getInvNo();
    getUserInfo();
    super.initState();
  }

  getInvNo() {
    int temp = Random().nextInt(99950) + 50;
    setState(() {
      invNumber = temp.toString();
    });
  }

  String? uid;
  String? email;
  String? name;

  getUserInfo() async {
    String? uidTemp = await const FlutterSecureStorage().read(key: 'uid');
    String? username = await const FlutterSecureStorage().read(key: 'name');
    String? emailTemp = await const FlutterSecureStorage().read(key: 'email');

    setState(() {
      uid = uidTemp;
      email = emailTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<InvoiceCubit, InvoiceState>(builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpaceDefault,
                  Text(
                    "Invoice #$invNumber",
                    style: textStlyeMed,
                  ),
                  Text(
                    "Invoice Date ${DateFormat.yMEd().format(DateTime.now())}",
                    style: textStlyeMed,
                  ),
                  verticalSpaceDefault,
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Customer Details",
                          style: textStlyeHeading,
                        ),
                        CustomTextField(
                          title: "Name",
                          textEditingController: _toName,
                          hintTxt: "Customer Name",
                          mandatory: true,
                        ),
                        CustomTextField(
                          title: "Email",
                          textEditingController: _toEmail,
                          hintTxt: "Customer Email",
                          mandatory: true,
                        ),
                        CustomTextField(
                          title: "Address",
                          textEditingController: _toAddress,
                          hintTxt: "Customer Address",
                          mandatory: true,
                        ),
                        CustomTextField(
                          title: "City",
                          textEditingController: _toCity,
                          hintTxt: "Customer City",
                          mandatory: true,
                        ),
                        CustomTextField(
                          title: "State",
                          textEditingController: _toState,
                          hintTxt: "Customer State",
                          mandatory: true,
                        ),
                        CustomTextField(
                          title: "Pin code",
                          textEditingController: _toZip,
                          hintTxt: "Customer pincode",
                          mandatory: true,
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceDefault,
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Item Details",
                          style: textStlyeHeading,
                        ),
                        verticalSpaceDefault,
                        Visibility(
                          visible: (state.invoiceItems?.length ?? 0) > 0,
                          child: Column(
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  InvoiceItem? q = state.invoiceItems?[index];
                                  return AddItemHelper(
                                    idx: index,
                                    key: Key("q$index"),
                                  );
                                },
                                separatorBuilder: (context, index) => verticalSpaceSmall,
                                itemCount: state.invoiceItems?.length ?? 0,
                              ),
                              verticalSpaceDefault,
                              verticalSpaceDefault,
                            ],
                          ),
                        ),
                        SubmitButton(
                          txt: "Add Item",
                          color: primaryColor,
                          icon: Icons.interests_rounded,
                          onTap: () {
                            context.read<InvoiceCubit>().addAdditionalQues("desc", 0, 0);
                          },
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceDefault,
                  const Divider(),
                  verticalSpaceDefault,
                  verticalSpaceDefault,
                  CustomTextField(
                    title: "Discount",
                    textEditingController: _discount,
                    hintTxt: "Discount %",
                  ),
                  CustomTextField(
                    title: "Tax",
                    textEditingController: _tax,
                    hintTxt: "Tax %",
                  ),
                  verticalSpaceDefault,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text(
                  //       "Subtotal",
                  //       style: textStlyeHeading,
                  //     ),
                  //     horizontalSpaceDefault,
                  //     Text(
                  //       "₹ ${state.subtotal}",
                  //       style: textStlyeHeading,
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text(
                  //       "Grand Total",
                  //       style: textStlyeHeading,
                  //     ),
                  //     horizontalSpaceDefault,
                  //     Text(
                  //       "₹ ${state.subtotal! - state.subtotal! * (double.tryParse(_discount.text) ?? 0) * 0.01 + state.subtotal! * (double.tryParse(_tax.text) ?? 0) * 0.01}",
                  //       style: textStlyeHeading,
                  //     ),
                  //   ],
                  // ),
                  // verticalSpaceDefault,
                  SubmitButton(
                    txt: "Create Invoice",
                    onTap: () async {
                      var res = await context.read<InvoiceCubit>().addNewInvoice(
                          Invoice(
                            id: "INV$invNumber",
                            toName: _toName.text.trim(),
                            toAddress: _toAddress.text.trim(),
                            toCity: _toCity.text.trim(),
                            toState: _toState.text.trim(),
                            toZip: int.tryParse(_toZip.text),
                            toEmail: _toEmail.text.trim(),
                            fromName: "$name",
                            fromEmail: "$email",
                            invNumber: int.tryParse(invNumber),
                            invDate: DateFormat.yMEd().format(DateTime.now()),
                            entries: state.invoiceItems,
                            subtotal: state.subtotal,
                            grandTotal: state.subtotal! -
                                state.subtotal! * (double.tryParse(_discount.text) ?? 0) * 0.01 +
                                state.subtotal! * (double.tryParse(_tax.text) ?? 0) * 0.01,
                            tax: state.subtotal! * (double.tryParse(_tax.text) ?? 0) * 0.01,
                            discount:
                                state.subtotal! * (double.tryParse(_discount.text) ?? 0) * 0.01,
                            discountRate: double.tryParse(_discount.text.trim()),
                            taxRate: double.tryParse(_tax.text.trim()),
                          ),
                          "$uid");

                      if (res == true) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => InvoiceDetailScreen(id: "INV$invNumber")));

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Invoices Sent"),
                        ));
                      }
                    },
                  ),
                  verticalSpaceDefault,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
