import 'package:flutter/material.dart';
import 'package:healthycart/utils/constants/colors/colors.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    super.key,
    this.controller,
    this.readOnly = false,
    this.keyboardType = TextInputType.name,
    this.validator,
    this.maxlines,
    this.minlines,
    this.labelText,
    required this.style,
    this.hintText,
    this.textInputAction,
    this.onChanged,
  });
  final TextEditingController? controller;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxlines;
  final int? minlines;
  final String? labelText;
  final String? hintText;
  final TextStyle style;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onChanged: onChanged,
        textInputAction: textInputAction,
        textCapitalization: TextCapitalization.sentences,
        minLines: maxlines,
        maxLines: maxlines,
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        readOnly: readOnly!,
        cursorColor: BColors.black,
        style: style,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.labelMedium,
          hintStyle: Theme.of(context).textTheme.labelMedium,
          hintText: hintText,
          labelText: labelText,
          contentPadding: const EdgeInsets.all(16),
          filled: true,
          fillColor: BColors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
