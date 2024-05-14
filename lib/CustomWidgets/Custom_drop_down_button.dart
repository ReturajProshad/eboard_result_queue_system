import 'package:flutter/material.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final InputDecoration decoration;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final T? value;
  final FormFieldValidator<T>? validator;
  final List<Widget> Function(BuildContext)?
      selectedItemBuilder; // Change the type here
  final Color? dropdownColor;

  const CustomDropdownButtonFormField({
    Key? key,
    required this.decoration,
    required this.items,
    this.onChanged,
    this.value,
    this.validator,
    this.selectedItemBuilder,
    this.dropdownColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: decoration,
      items: items,
      onChanged: onChanged,
      value: value,
      validator: validator,
      selectedItemBuilder: selectedItemBuilder != null
          ? (BuildContext context) => selectedItemBuilder!(context)
          : // Return custom builder if provided
          null, // Otherwise, use default behavior
      dropdownColor: dropdownColor,
    );
  }
}
