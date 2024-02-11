import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/navigation/route.dart';
import 'package:stacktim_booking/ui/login/login_view_controller.dart';

class LoginView extends GetView<LoginViewController> {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) => SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 0,
                children: [
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        controller.imageList[0],
                      ),
                    ),
                  ),
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        controller.imageList[1],
                      ),
                    ),
                  ),
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        controller.imageList[2],
                      ),
                    ),
                  ),
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        controller.imageList[3],
                      ),
                    ),
                  ),
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        controller.imageList[4],
                      ),
                    ),
                  ),
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        controller.imageList[5],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Image(
                height: 150,
                image: AssetImage(
                  logo,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Stacktim Booking",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const Text(
                "Connectez-vous et réservez votre place dans\n notre salle gaming",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              //BUTTON CONNEXION WITH MICROSOFT
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: InkWell(
                  onTap: () {
                    Get.offAllNamed(Routes.welcome);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: const Color.fromRGBO(225, 6, 0, 1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Se connecter avec Microsoft".toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    microsoftLogo,
                    height: 60,
                  ),
                  const Text(
                    "Microsoft",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
