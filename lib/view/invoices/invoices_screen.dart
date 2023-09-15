import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govt_billing/blocs/invoices/invoice_cubit.dart';
import 'package:govt_billing/common/constants/sizing.dart';
import 'package:govt_billing/view/invoices/add_new_invoice.dart';
import 'package:govt_billing/view/invoices/components/invoice_tile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InvoiceCubit, InvoiceState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ignore: prefer_is_empty
                  if (state.invoiceList?.length == 0)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                          "You dont have any invoices yet! Create one to get started with."),
                    ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        InvoiceTile(invoice: state.invoiceList![index]),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.invoiceList?.length ?? 0,
                  ),
                  verticalSpaceHuge,
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const AddNewInvoice(),
            withNavBar: false,
          );
          // showModalBottomSheet(
          //   isScrollControlled: true,
          //   context: context,
          //   builder: (context) {
          //     return const CreateInvoiceScreen();
          //   },
          // );
          // context.read<InvoiceCubit>().addInvoiceBulk();
        },
      ),
    );
  }
}
