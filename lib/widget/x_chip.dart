import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/style.dart';

class XChip<T> extends StatelessWidget {
  final String? label;
  final XChipColor chipColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? labelPadding;
  final Widget? body;
  const XChip._({
    Key? key,
    required this.label,
    required this.chipColor,
    this.textStyle,
    this.padding,
    this.labelPadding,
    this.body,
  }) : super(key: key);

  factory XChip.chipStatus({
    required String label,
    required XChipColor chipColor,
    String? toolTipsLabel,
    Function(T object)? onDeleted,
    Color? color,
    Widget? endIcon,
    T? object,
    final EdgeInsetsGeometry? padding = const EdgeInsets.all(0),
  }) {
    return XChip._(
      label: label,
      chipColor: chipColor,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      padding: padding,
      labelPadding: labelPadding,
      label: body ??
          Text(
            '$label',
            style: textStyle ??
                bodyText2.copyWith(
                    fontSize: 12,
                    fontFamily: 'Anta',
                    fontWeight: FontWeight.w500,
                    color: chipColor == XChipColor.green
                        ? greenChip
                        : chipColor == XChipColor.red
                            ? redChip
                            : chipColor == XChipColor.blue
                                ? blueChip
                                : redChip),
          ),
      backgroundColor: chipColor == XChipColor.green
          ? greenChip.withOpacity(0.2)
          : chipColor == XChipColor.red
              ? redChip.withOpacity(0.2)
              : chipColor == XChipColor.blue
                  ? blueChip.withOpacity(0.2)
                  : redChip.withOpacity(0.2),
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
