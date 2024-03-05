import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/style.dart';

class XSelectableChip extends StatefulWidget {
  const XSelectableChip({
    super.key,
    required this.label,
    this.chipColor,
    this.onChanged,
    this.padding,
    this.isSelected = false,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.borderColor,
    this.selectedBorderColor,
    this.labelColor,
    this.selectedLabelColor,
    this.borderWidth,
    this.selectedBorderWidth,
  });

  final String label;
  final XChipColor? chipColor;
  final EdgeInsetsGeometry? padding;
  final void Function(bool)? onChanged;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? labelColor;
  final Color? selectedLabelColor;
  final Color? borderColor;
  final Color? selectedBorderColor;
  final double? borderWidth;
  final double? selectedBorderWidth;

  @override
  State<XSelectableChip> createState() => _XSelectableChipState();
}

class _XSelectableChipState extends State<XSelectableChip> {
  Color getChipColor() {
    return widget.chipColor == XChipColor.green
        ? greenChip
        : widget.chipColor == XChipColor.red
            ? redChip
            : widget.chipColor == XChipColor.blue
                ? blueChip
                : redChip;
  }

  Color getChipColorWithOpacity() {
    return widget.chipColor == XChipColor.green
        ? greenChip.withOpacity(0.2)
        : widget.chipColor == XChipColor.red
            ? redChip.withOpacity(0.2)
            : widget.chipColor == XChipColor.blue
                ? blueChip.withOpacity(0.2)
                : redChip.withOpacity(0.2);
  }

  late bool isSelected;
  @override
  void initState() {
    isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(isSelected);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? widget.selectedBackgroundColor ?? getChipColorWithOpacity()
              : widget.backgroundColor ?? getChipColorWithOpacity(),
          border: Border.all(
            color: isSelected
                ? widget.selectedBorderColor ?? getChipColor()
                : widget.borderColor ?? Colors.transparent,
            width: (isSelected
                    ? widget.selectedBorderWidth
                    : widget.borderWidth) ??
                2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: widget.padding ?? const EdgeInsets.all(8.0),
          child: Text(
            widget.label,
            style: bodyText2.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? widget.selectedLabelColor ?? getChipColor()
                  : widget.labelColor ?? getChipColor(),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
