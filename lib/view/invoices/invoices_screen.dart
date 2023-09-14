import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govt_billing/blocs/invoices/invoice_cubit.dart';
import 'package:govt_billing/common/constants/color.dart';
import 'package:govt_billing/view/invoices/components/invoice_list.dart';

import 'components/create_invoice.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(179, 240, 240, 240),
      body: InvoiceListBody(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: const SizedBox(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
              size: 40,
            ),
          ),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const CreateInvoiceScreen();
              },
            );
            // context.read<InvoiceCubit>().addInvoiceBulk();
          }),
    );
  }
}
