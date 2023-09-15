import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color.dart';
import '../constants/sizing.dart';
import '../utils/form_validator.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final bool mandatory;
  final String hintTxt;
  final int? maxLen;
  final int? maxLines;
  final bool obscureText;
  final bool isFilled;
  final Color? fillColor;
  final bool? enabled;
  final Function? validatorFunc;
  final void Function(String?)? func;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  final bool? errorState;
  final String? message;
  final Color? txtColor;
  final Color? borderColor;

  const CustomTextField({
    super.key,
    this.title,
    this.enabled = true,
    this.obscureText = false,
    this.mandatory = false,
    this.validator,
    this.validatorFunc,
    this.hintTxt = "Enter value",
    this.maxLen,
    this.maxLines = 1,
    this.func,
    this.fillColor,
    this.txtColor,
    this.borderColor,
    this.isFilled = false,
    this.textEditingController,
    this.errorState,
    this.message,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            "$title",
            maxLines: 3,
            style: TextStyle(
              fontSize: 16,
              height: 2,
              color: txtColor?.withOpacity(0.8) ?? labelcolor,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (title != null)
          const SizedBox(
            height: 5,
          ),
        TextFormField(
          key: ValueKey(title),
          enabled: enabled,
          controller: textEditingController,
          validator: (value) {
            if (validatorFunc != null) {
              return validatorFunc!(value);
            }
            if (mandatory) {
              FormValidator().mandatoryFieldValidator(value);
            }
            return null;
          },
          onChanged: func,
          // onSaved: func,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(defaultPadding),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor ?? fillColor ?? Colors.black26)
                // borderSide: BorderSide.none,
                ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor ?? fillColor ?? Colors.black26),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor ?? fillColor ?? Colors.black26),
            ),
            fillColor: fillColor ?? Colors.transparent,
            filled: isFilled,
            counterText: '',
            hintText: hintTxt,
            hintStyle: TextStyle(
              fontSize: 14,
              color: txtColor ?? hintcolor,
              fontWeight: FontWeight.w500,
            ),
          ),
          cursorColor: primaryColor,
          style: TextStyle(
            color: txtColor ?? Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLength: maxLen,
          maxLines: obscureText == true ? 1 : maxLines,
        ),
        const SizedBox(
          height: 5,
        ),
        errorState != null
            ? Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: errorState == true ? Colors.green : Colors.red,
                    ),
                    child: Icon(
                      errorState == true ? Icons.done : Icons.cancel,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  horizontalSpaceDefault,
                  Text(
                    message ?? "",
                    style: TextStyle(color: errorState == true ? Colors.green : Colors.red),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
