import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetail extends StatelessWidget {
  String fullName;
  String nickName;
  String bookingTitle;
  String bookingDate;
  String startedBookingHourPicked;
  String endedBookingHourPicked;
  bool isCurrentUser;
  String userMail;
  int? computerSelected;
  void Function()? onTap;
  bool? isWithSeat;
  BookingDetail({
    required this.fullName,
    required this.nickName,
    required this.bookingTitle,
    required this.bookingDate,
    required this.isCurrentUser,
    required this.userMail,
    required this.startedBookingHourPicked,
    required this.endedBookingHourPicked,
    this.computerSelected,
    this.onTap,
    this.isWithSeat,
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
                          style: TextStyle(
                            color: isCurrentUser ? redLiquidSwipe : blueChip,
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
              Divider(
                color: isCurrentUser ? redLiquidSwipe : blueChip,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Nom de la réservation : $bookingTitle',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      strutStyle: const StrutStyle(fontFamily: 'Anta'),
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Réservation prise le : ',
                            style: TextStyle(fontFamily: 'Anta'),
                          ),
                          TextSpan(
                            text: bookingDate,
                            style: const TextStyle(
                              color: greenChip,
                              fontFamily: 'Anta',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      strutStyle: const StrutStyle(fontFamily: 'Anta'),
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Crénau choisi : ',
                            style: TextStyle(fontFamily: 'Anta'),
                          ),
                          const TextSpan(
                            text: 'de ',
                            style: TextStyle(fontFamily: 'Anta'),
                          ),
                          TextSpan(
                            text: '${startedBookingHourPicked}h',
                            style: const TextStyle(
                              color: greenChip,
                              fontFamily: 'Anta',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                              text: ' à ',
                              style: TextStyle(fontFamily: 'Anta')),
                          TextSpan(
                              text: '${endedBookingHourPicked}h',
                              style: const TextStyle(
                                color: greenChip,
                                fontFamily: 'Anta',
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              isWithSeat ?? false
                  ? InkWell(
                      onTap: () async {
                        if (onTap != null) {
                          onTap!();
                        }
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Siège choisi : $computerSelected",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.search,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              !isCurrentUser
                  ? InkWell(
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
                                  fontSize: 12,
                                  decoration: TextDecoration.underline),
                            ),
                            const Spacer(),
                            Image.asset(
                              teams,
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
