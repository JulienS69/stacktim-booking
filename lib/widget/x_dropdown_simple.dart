import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';

class XDropDownSimple<T> extends StatefulWidget {
  final Widget? hint;
  final T? value;
  final Widget? icon;
  final List<DropdownMenuItem<T>> items;
  final void Function(T value) onChanged;
  final String? Function(T?)? validator;
  final Radius? borderRadius;
  final Color borderColor;
  final Color textColor;
  final EdgeInsetsGeometry? padding;
  final double? textSize;
  final void Function(T?)? onSaved;
  final Color? color;
  final bool enabled;
  final double? menuMaxHeight;
  final GlobalKey? dropdownKey;

  XDropDownSimple({
    super.key,
    this.hint,
    required this.items,
    this.icon,
    this.value,
    required this.onChanged,
    this.validator,
    this.borderRadius = const Radius.circular(5.0),
    this.borderColor = Colors.black,
    this.textColor = Colors.grey,
    this.padding,
    this.textSize = 12,
    this.onSaved,
    this.color,
    this.enabled = true,
    this.menuMaxHeight,
    this.dropdownKey,
  });

  @override
  createState() => XDropDownSimpleState<T>();
}

class XDropDownSimpleState<T> extends State<XDropDownSimple<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: SizedBox(
        height: (widget.validator != null) ? 71 : 50,
        child: DropdownButtonFormField<T>(
          key: widget.dropdownKey,
          hint: widget.hint ?? const Text(''),
          dropdownColor: backgroundColor,
          menuMaxHeight: widget.menuMaxHeight,
          icon: widget.enabled
              ? widget.icon ??
                  const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Color(0xffFF0808),
                  )
              : null,
          onSaved: widget.onSaved,
          style: Get.textTheme.bodyLarge,
          iconSize: 18,
          validator: widget.validator,
          value: (widget.value == "") && widget.items.isNotEmpty
              ? widget.items.first.value
              : widget.value,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor, // Set the background color here
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12), // Adjust padding as needed
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(widget.borderRadius!),
              borderSide: BorderSide(color: widget.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(widget.borderRadius!),
              borderSide: BorderSide(color: widget.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(widget.borderRadius!),
              borderSide: BorderSide(color: widget.borderColor, width: 0.5),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          isExpanded: true,
          onChanged: widget.enabled
              ? (e) {
                  if (e != null) {
                    widget.onChanged(e);
                  }
                }
              : null,
          items: widget.items,
        ),
      ),
    );
  }
}
