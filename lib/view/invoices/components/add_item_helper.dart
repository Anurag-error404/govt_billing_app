import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govt_billing/blocs/invoices/invoice_cubit.dart';
import 'package:govt_billing/common/constants/textstyles.dart';
import 'package:govt_billing/data/models/invoice_item_model.dart';

import '../../../common/constants/color.dart';
import '../../../common/constants/sizing.dart';
import '../../../common/widgets/custom_textfield.dart';

class AddItemHelper extends StatefulWidget {
  final int idx;
  const AddItemHelper({
    super.key,
    required this.idx,
  });

  @override
  State<AddItemHelper> createState() => _AddItemHelperState();
}

class _AddItemHelperState extends State<AddItemHelper> {
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _price = TextEditingController();

  bool isEditing = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: isEditing ? bgColor : secondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white10)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: primaryColor),
                child: Text(
                  "${widget.idx + 1}",
                  style: textStlyebody.copyWith(color: Colors.white),
                ),
              ),
              horizontalSpaceDefault,
              Expanded(
                child: Column(
                  children: [
                    CustomTextField(
                      title: "Description",
                      enabled: isEditing,
                      textEditingController: _desc,
                    ),
                    CustomTextField(
                      title: "Quantity",
                      enabled: isEditing,
                      textEditingController: _qty,
                    ),
                    CustomTextField(
                      title: "Price",
                      enabled: isEditing,
                      textEditingController: _price,
                    ),
                  ],
                ),
              ),
              horizontalSpaceDefault,
            ],
          ),
          verticalSpaceDefault,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: () {
                  context.read<InvoiceCubit>().deleteAdditionalQues(widget.idx);
                },
                color: Colors.white,
                child: Text(
                  "Delete",
                  style: textStlyebody.copyWith(color: Colors.redAccent),
                ),
              ),
              horizontalSpaceDefault,
              isEditing
                  ? MaterialButton(
                      onPressed: () {
                        context.read<InvoiceCubit>().editAdditionalQues(
                              widget.idx,
                              InvoiceItem(
                                desc: _desc.text.trim(),
                                qty: int.tryParse(_qty.text) ?? 1,
                                price: double.tryParse(_price.text) ?? 1,
                                total: (int.tryParse(_qty.text) ?? 1) *
                                    (double.tryParse(_price.text) ?? 1),
                              ),
                            );
                        setState(() {
                          isEditing = false;
                        });
                      },
                      color: Colors.green,
                      child: Text(
                        "Save",
                        style: textStlyebody.copyWith(color: Colors.white),
                      ),
                    )
                  : MaterialButton(
                      onPressed: () {
                        setState(() {
                          isEditing = true;
                        });
                      },
                      color: Colors.blueAccent,
                      child: Text(
                        "Edit",
                        style: textStlyebody.copyWith(color: Colors.white),
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
