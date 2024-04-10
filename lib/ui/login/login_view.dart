import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/functions.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/ui/login/login_view_controller.dart';
import 'package:stacktim_booking/widget/x_loader_stacktim.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

class LoginView extends GetView<LoginViewController> {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      onLoading: const XLoaderStacktim(),
      (state) => XMobileScaffold(
        isShowBottomNavigationBar: false,
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          child: loginImageListGenerate[0]),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 3,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: loginImageListGenerate[1],
                      ),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: loginImageListGenerate[2],
                      ),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: loginImageListGenerate[3],
                      ),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 2,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: loginImageListGenerate[4],
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
                  height: 60,
                ),
                //BUTTON CONNEXION WITH MICROSOFT
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: InkWell(
                    onTap: () async {
                      HapticFeedback.heavyImpact();
                      await controller.getMicrosftUrl();
                      controller.initialWebView();
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Se connecter avec Microsoft".toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Image.asset(
                              microsoftLogo,
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onDoubleTap: () {
                    controller.isShowingVersion.value = true;
                  },
                  child: Obx(
                    () => controller.isShowingVersion.value
                        ? InkWell(
                            onTap: () {
                              controller.incrementCounterFordDevelopers();
                            },
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                child: Text(
                                  '${controller.version}+${controller.buildNumber}',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Container(
                              height: 50,
                              width: 150,
                              color: Colors.transparent,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
