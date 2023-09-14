import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govt_billing/blocs/invoices/invoice_cubit.dart';

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
      body: const Center(child: Text("Hi")),
      floatingActionButton: FloatingActionButton(
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
