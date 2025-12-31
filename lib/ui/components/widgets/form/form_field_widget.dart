import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const FormFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      maxLines: 3,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.titleMedium,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
