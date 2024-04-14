import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class XProfilDetail extends StatelessWidget {
  String fullName;
  String nickName;
  List<String> roleSlug;
  String userMail;
  XProfilDetail({
    required this.fullName,
    required this.nickName,
    required this.roleSlug,
    required this.userMail,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: grey10,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName,
                          style: const TextStyle(
                            color: blueChip,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          nickName,
                          style: const TextStyle(
                            color: grey5,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    width: 75,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                        'https://picsum.photos/200',
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Rôles du membre : ',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      roleSlug.isNotEmpty
                          ? roleSlug
                              .map((role) => role.replaceFirst('Stacktim ', ''))
                              .join(', ')
                              .substring(1)
                              .trimLeft()
                          : '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (userMail.isNotEmpty) {
                    launchUrl(
                      mode: LaunchMode.externalApplication,
                      Uri.parse(
                        teamsUrlOfUser(userMail: userMail),
                      ),
                    );
                  } else {
                    showSnackbar(
                        "Impossible de contacter cet utilisateur pour le moment",
                        SnackStatusEnum.warning);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      const Text(
                        'Contacter sur Teams',
                        style: TextStyle(
                            fontSize: 12, decoration: TextDecoration.underline),
                      ),
                      const Spacer(),
                      Image.asset(
                        teams,
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
