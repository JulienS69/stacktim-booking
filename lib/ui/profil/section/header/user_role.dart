import 'package:flutter/widgets.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/profil/profil_view_controller.dart';

class UserRole extends StatelessWidget {
  const UserRole({
    super.key,
    required this.controller,
  });

  final ProfilViewController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          logo,
          height: 15,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          controller.currentUserRole,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
