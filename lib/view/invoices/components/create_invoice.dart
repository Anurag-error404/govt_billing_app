import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:govt_billing/common/constants/color.dart';
import 'package:govt_billing/common/constants/sizing.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/utils/size_config.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController invoiceID = TextEditingController();
    TextEditingController invoiceDate = TextEditingController();

    TextEditingController toName = TextEditingController();
    TextEditingController toAddress = TextEditingController();
    TextEditingController toCity = TextEditingController();
    TextEditingController toState = TextEditingController();
    TextEditingController toZip = TextEditingController();
    TextEditingController toPhone = TextEditingController();

    TextEditingController fromName = TextEditingController();
    TextEditingController fromAddress = TextEditingController();
    TextEditingController fromCity = TextEditingController();
    TextEditingController fromState = TextEditingController();
    TextEditingController fromZip = TextEditingController();
    TextEditingController fromPhone = TextEditingController();

    TextEditingController companyName = TextEditingController();
    TextEditingController companyEmail = TextEditingController();

    DateTime date = DateTime.now();

    List<Map<String, double>> ls = [
      {
        'a': 100,
      },
      {'b': 200}
    ];
    double total = ls.fold(0, (i, el) {
      return i + el.values.first;
    });

    void initState() {
      invoiceDate.text = ""; //set the initial value of text field
      super.initState();
    }

    return Container(
      // padding: EdgeInsets.symmetric(vertical: 20),
      color: Color.fromARGB(179, 240, 240, 240),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      verticalSpaceDefault,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: invoiceID,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be blank";
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.receipt,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "INVOICE # :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Muli',
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: invoiceDate,
                            readOnly: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be blank";
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.calendar,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              // labelText: "INVOICE # :",
                              // labelStyle: TextStyle(
                              //     fontSize: SizeConfig.screenWidth * 0.04),
                              hintText: "INVOICE DATE :",
                              hintStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            onTap: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2100));

                              if (newDate == null) return;
                              String formattedDate =
                                  DateFormat.yMMMd().format(newDate);

                              setState(() => invoiceDate.text = formattedDate);
                              print(invoiceDate.text);
                            },
                          ),
                        ),
                      ),
                      verticalSpaceDefault
                    ],
                  ),
                ),
                // SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      verticalSpaceDefault,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: toName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be blank";
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "BILL TO :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: toAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be blank";
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.streetview,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "ADDRESS :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: toCity,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be blank";
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "CITY :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: toState,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be blank";
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.share_location,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "STATE :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: toZip,
                            validator: (value) {
                              String patttern = r'(^[1-9][0-9]{5}$)';
                              RegExp regExp = new RegExp(patttern);
                              if (value!.length != 6 ||
                                  !regExp.hasMatch(value)) {
                                return 'Please enter valid pincode';
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.place,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "PINCODE :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: toPhone,
                            validator: (value) {
                              String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                              RegExp regExp = new RegExp(patttern);
                              if (value!.length != 10 ||
                                  !regExp.hasMatch(value)) {
                                return 'Please enter valid mobile number';
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "PHONE :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceDefault
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      verticalSpaceDefault,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: fromName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be blank";
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "FROM :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: fromAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be blank";
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.streetview,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "ADDRESS :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: fromCity,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be blank";
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "CITY :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: fromState,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be blank";
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.share_location,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "STATE :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: fromZip,
                            validator: (value) {
                              String patttern = r'(^[1-9][0-9]{5}$)';
                              RegExp regExp = new RegExp(patttern);
                              if (value!.length != 6 ||
                                  !regExp.hasMatch(value)) {
                                return 'Please enter valid pincode';
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.place,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "PINCODE :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: fromPhone,
                            validator: (value) {
                              String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                              RegExp regExp = new RegExp(patttern);
                              if (value!.length != 10 ||
                                  !regExp.hasMatch(value)) {
                                return 'Please enter valid mobile number';
                              }
                              return null;
                            },
                            cursorColor: primaryColor,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: "PHONE :",
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              // hintText: widget.userLog.name,
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.screenWidth * 0.04),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceDefault
                    ],
                  ),
                ),

                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            ...List.generate(ls.length, (index) {
                              return ListTile(
                                leading: Text((index + 1).toString() + '.'),
                                trailing:
                                    Text(ls[index].values.first.toString()),
                                title: Text(ls[index].keys.first),
                                subtitle: Text('ss'),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 40,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(),
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1),
                        child: DecoratedBox(
                          child: Center(
                            child: Text(
                              'Add Item',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    verticalSpaceDefault,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(color: hintcolor, fontSize: 15),
                        ),
                        Text(
                          "\$ $total",
                          style: TextStyle(color: hintcolor, fontSize: 15),
                        )
                      ],
                    ),
                    verticalSpaceDefault,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tax(tax_rate%)",
                          style: TextStyle(color: hintcolor, fontSize: 15),
                        ),
                        Text(
                          "\$ $total",
                          style: TextStyle(color: hintcolor, fontSize: 15),
                        )
                      ],
                    ),
                    verticalSpaceDefault,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$ $total",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    verticalSpaceDefault,
                  ]),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
