import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/strings.dart';

class BookingDetail extends StatelessWidget {
  String fullName;
  String nickName;
  String bookingTitle;
  String bookingDate;
  bool isCurrentUser;
  BookingDetail({
    required this.fullName,
    required this.nickName,
    required this.bookingTitle,
    required this.bookingDate,
    required this.isCurrentUser,
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
                      'Titre de la réservation : $bookingTitle',
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
                    child: Text(
                      'Réservation prise le $bookingDate',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  showSnackbar('TODO CONTACTER LA PERSONNE SUR TEAMS',
                      SnackStatusEnum.warning);
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
