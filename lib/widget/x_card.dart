import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/widget/x_chip.dart';

class BookingCard extends StatelessWidget {
  final bool? disableStartIcon;
  final bool? disableMiddleIcon;
  final bool? disableEndIcon;
  final String startDate;
  final String endDate;
  final String? isSubmittedStatus;
  final String statutReason;
  final bool isSlidable;
  final void Function()? startOnPressedIcon;
  final void Function()? middleOnPressedIcon;
  final void Function()? endOnPressedIcon;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final String? traitedBy;
  final TextStyle? traitedByStyle;
  final XChip chip;
  final void Function()? onTap;
  final Icon? icon;
  final String? textFirstIcon;

  const BookingCard._({
    this.isSubmittedStatus,
    this.disableStartIcon = true,
    this.disableMiddleIcon = true,
    this.disableEndIcon = true,
    this.isSlidable = true,
    this.startOnPressedIcon,
    this.middleOnPressedIcon,
    this.endOnPressedIcon,
    required this.endDate,
    required this.startDate,
    required this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.traitedBy,
    this.traitedByStyle,
    required this.chip,
    this.onTap,
    this.icon,
    this.textFirstIcon,
    required this.statutReason,
  });

  factory BookingCard.basic({
    String? isSubmittedStatus,
    bool? disableStartIcon,
    bool? disableMiddleIcon,
    bool? disableEndIcon,
    required String startDate,
    required String endDate,
    bool isSlidable = true,
    void Function()? startOnPressedIcon,
    void Function()? middleOnPressedIcon,
    void Function()? endOnPressedIcon,
    required String title,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subtitleStyle,
    String? traitedBy,
    TextStyle? traitedByStyle,
    required XChip chip,
    void Function()? onTap,
    Icon? icon,
    String? textFirstIcon,
    required String statutReason,
  }) {
    return BookingCard._(
      isSubmittedStatus: isSubmittedStatus,
      disableStartIcon: disableStartIcon,
      disableMiddleIcon: disableMiddleIcon,
      disableEndIcon: disableEndIcon,
      startDate: startDate,
      endDate: endDate,
      isSlidable: isSlidable,
      startOnPressedIcon: startOnPressedIcon,
      middleOnPressedIcon: middleOnPressedIcon,
      endOnPressedIcon: endOnPressedIcon,
      title: title,
      titleStyle: titleStyle,
      subtitle: subtitle,
      subtitleStyle: subtitleStyle,
      traitedBy: traitedBy,
      traitedByStyle: traitedByStyle,
      chip: chip,
      onTap: onTap,
      icon: icon,
      textFirstIcon: textFirstIcon,
      statutReason: statutReason,
    );
  }

  @override
  Widget build(BuildContext context) {
    return getContainerBillCard(
      context,
    );
  }

  Widget getContainerBillCard(
    BuildContext context,
  ) {
    return Container(
      height: 90,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: backgroundChip,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Tooltip(
                                message: title,
                                child: Text(
                                  title,
                                  style: titleStyle ??
                                      bodyTextMonserat14.copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Anta',
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Tooltip(
                                      message:
                                          (subtitle != null) ? subtitle! : '',
                                      child: Text(
                                        (subtitle != null) ? subtitle! : '',
                                        style: subtitleStyle ??
                                            Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color:
                                                        const Color(0xffBDBDBD),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Text(
                                        '${'Le'.tr.capitalizeFirst} $startDate ${'de'.tr} $endDate',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff8D8D8D)),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Tooltip(
                                        message: (traitedBy == null)
                                            ? "${"traitedBy".tr} ${"anAdministrator".tr}"
                                            : "${"traitedBy".tr} $traitedBy",
                                        child: ((isSubmittedStatus!
                                                .contains("submitted")))
                                            ? _buildTreatedBy(context)
                                            : statutReason.isNotEmpty
                                                ? _buildStatusReason(context)
                                                : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: chip,
                ),
                icon ??
                    const Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: blueChip,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTreatedBy(BuildContext context) {
    return Text(
      "${"traitedBy".tr} ${traitedBy ?? "anAdministrator".tr}",
      style: traitedByStyle ??
          Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: const Color(0xffFFBE0B),
              fontSize: 10,
              fontWeight: FontWeight.w600),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildStatusReason(BuildContext context) {
    return Text(
      statutReason.tr,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.red, fontSize: 10, fontWeight: FontWeight.w600),
      overflow: TextOverflow.ellipsis,
    );
  }

  static XChip getChipByStatusTag(String? tag) {
    switch (tag) {
      case StatusSlugs.passee:
        return XChip.chipStatus(
          label: "Passée".tr.capitalizeFirst!,
          chipColor: XChipColor.green,
        );
      case StatusSlugs.inComming:
        return XChip.chipStatus(
          label: "A venir".tr.capitalizeFirst!,
          chipColor: XChipColor.red,
        );
      case StatusSlugs.inProgress:
        return XChip.chipStatus(
          label: "En cours".tr.capitalizeFirst!,
          chipColor: XChipColor.blue,
        );
      default:
        return XChip.chipStatus(
          label: "Aucun status".tr.capitalizeFirst!,
          chipColor: XChipColor.red,
        );
    }
  }
}
