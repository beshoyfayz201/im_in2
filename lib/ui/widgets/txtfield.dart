import 'package:flutter/material.dart';

class TxtField extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  String? Function(String?) validation;
  bool obsecure;
  Widget? suffix;
  TxtField(
      {required this.validation,
      Key? key,
      this.obsecure = false,
      required this.label,
      required this.textEditingController,
      this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: textEditingController,
              obscureText: obsecure,
              validator: (value) {
                if (value!.isEmpty)
                  return "please fill in this form";
                else if (value.length < 3)
                  return "$label is too short";
                else
                  return validation(value);
              },
              decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: suffix,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ],
        ));
  }
}
