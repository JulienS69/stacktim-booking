import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/profil/profil_view_controller.dart';

class FavoriteGameWidget extends StatelessWidget {
  const FavoriteGameWidget({
    super.key,
    required this.controller,
  });

  final ProfilViewController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 15),
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: controller.isExpanded.value
            ? 400
            : (controller.currentUser.gamesList?.isNotEmpty ?? false)
                ? 135
                : 0,
        child: controller.isExpanded.value
            ? GridView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: Get.size.width / 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 15,
                ),
                itemCount: controller.gameList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      GameCard(
                        controller: controller,
                        index: index,
                        isExpanded: true,
                      ),
                      Visibility(
                        visible: controller.gameList[index].isSelected == true,
                        child: Positioned(
                          top: 0,
                          right: 15,
                          child: Image.asset(
                            checkVector,
                            height: 25,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: controller.currentUser.gamesList != null
                    ? (controller.currentUser.gamesList!.length >= 3
                        ? 3
                        : controller.currentUser.gamesList!.length)
                    : 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Stack(
                      children: [
                        GameCard(
                          controller: controller,
                          index: index,
                          isExpanded: false,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              // AwesomeDialog(
                              //   context: context,
                              //   dialogType: DialogType.question,
                              //   dialogBackgroundColor: backgroundColor,
                              //   animType: AnimType.rightSlide,
                              //   title: 'Attention',
                              //   desc: "Veux-tu vraiment retirer ce jeux de tes favoris ?",
                              //   btnCancelText: 'Je confirme',
                              //   btnCancelOnPress: () async {
                              //    await controller.toggleFavoriteGame(
                              // gameId: controller.gameList[index].id ?? "",
                              // isDetachmode: true);
                              //   },
                              //   btnOkText: 'Retour',
                              //   btnOkOnPress: () {},
                              //   btnOkColor: Colors.black,
                              // ).show();
                            },
                            child: Image.asset(
                              cancelVector,
                              height: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.controller,
    required this.index,
    required this.isExpanded,
  });

  final ProfilViewController controller;
  final int index;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isExpanded
          ? () async {
              // Logique pour la sélection de l'image
              if (controller.currentUser.gamesList?.length == 3 &&
                  controller.gameList[index].isSelected != true) {
                showSnackbar(
                    "Veuillez d'abord retirer l'un de vos jeux favoris. 3 Jeux favoris maximum",
                    SnackStatusEnum.warning);
              } else if (controller.gameList[index].isSelected == true) {
                // AwesomeDialog(
                //   context: context,
                //   dialogType: DialogType.question,
                //   dialogBackgroundColor: backgroundColor,
                //   animType: AnimType.rightSlide,
                //   title: 'Attention',
                //   desc: "Veux-tu vraiment retirer ce jeux de tes favoris ?",
                //   btnCancelText: 'Je confirme',
                //   btnCancelOnPress: () async {
                //    await controller.toggleFavoriteGame(
                // gameId: controller.gameList[index].id ?? "",
                // isDetachmode: true);
                //   },
                //   btnOkText: 'Retour',
                //   btnOkOnPress: () {},
                //   btnOkColor: Colors.black,
                // ).show();
              } else {
                // AwesomeDialog(
                //   context: context,
                //   dialogType: DialogType.question,
                //   dialogBackgroundColor: backgroundColor,
                //   animType: AnimType.rightSlide,
                //   title: 'Attention',
                //   desc: "Veux-tu vraiment ajouter ce jeux à tes favoris ?",
                //   btnCancelText: 'Je confirme',
                //   btnCancelOnPress: () async {
                //     await controller.toggleFavoriteGame(
                // gameId: controller.gameList[index].id ?? "",
                // isDetachmode: false);
                //   },
                //   btnOkText: 'Retour',
                //   btnOkOnPress: () {},
                //   btnOkColor: Colors.black,
                // ).show();
              }
            }
          : null,
      borderRadius: BorderRadius.circular(5),
      overlayColor: WidgetStateProperty.all(const Color(0xffFF0808)),
      child: Container(
        decoration: BoxDecoration(
          border: isExpanded && controller.gameList[index].isSelected == true
              ? Border.all(color: const Color(0xffFF0808))
              : null,
          borderRadius: BorderRadius.circular(5),
        ),
        height: 130,
        width: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: CachedNetworkImage(
              imageUrl: isExpanded
                  ? controller.gameList[index].media?.first.originalUrl ?? ""
                  : controller.currentUser.gamesList![index].media?.first
                          .originalUrl ??
                      "",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
