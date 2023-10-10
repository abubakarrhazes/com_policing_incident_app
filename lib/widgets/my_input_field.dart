// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  const MyInputField(
      {Key? key,
      this.isPassword = false,
      this.hintText,
      this.icon,
      this.keyboardType,
      this.validator,
      this.formFieldHeight,
      this.max,
      this.maxLength,
      this.prefix,
      this.min,
      this.expandable,
      this.onSaved,
      this.controller})
      : super(key: key);

  final bool isPassword;
  final String? hintText;
  final Icon? icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final double? formFieldHeight;
  final int? max;
  final int? min;
  final int? maxLength;
  final bool? expandable;
  final Icon? prefix;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  bool visiblePassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.formFieldHeight,
      child: TextFormField(
        minLines: widget.min,
        maxLines: widget.max,
        expands: widget.expandable == true,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onSaved: widget.onSaved,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            hintText: widget.hintText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            prefix: widget.prefix,
            suffixIcon: widget.isPassword == false
                ? null
                : IconButton(
                    onPressed: () {
                      setState(() {
                        visiblePassword = true;
                      });
                    },
                    icon: Icon(visiblePassword
                        ? Icons.visibility
                        : Icons.visibility_off))),
      ),
    );
  }
}
