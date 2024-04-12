import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/logic/models/role/role.dart';
import 'package:stacktim_booking/logic/models/user/user.dart';
import 'package:stacktim_booking/ui/profil/profil_view_controller.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_error_page.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';
import 'package:stacktim_booking/widget/x_profil_detail.dart';

class AdministratorView extends GetView<ProfilViewController> {
  const AdministratorView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    controller.showTutorialOnDashboard(context);
    return XMobileScaffold(
      appBar: const XPageHeader(
        title: 'Administrateurs',
        imagePath: logoOverSlug,
      ),
      gapLocation: GapLocation.end,
      isShowBottomNavigationBar: false,
      body: controller.obx(
        (state) {
          return controller.administratorList.isNotEmpty
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.administratorList.length,
                          itemBuilder: (context, index) {
                            User user = controller.administratorList[index];
                            List<Role> roles = user.roles ?? [];
                            List<String> userRoles = [""];
                            for (Role role in roles) {
                              userRoles.add(role.roleName ?? "");
                            }
                            return XProfilDetail(
                              fullName: user.fullName,
                              nickName: user.nickName ?? "",
                              roleSlug: userRoles,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : XErrorPage(
                  contentTitle: "Impossible de récupérer contacter le serveur",
                  onPressedRetry: () {
                    controller.getAdministratorUser();
                    //TODO RETRY LES REQUÊTES
                  },
                  bottomNavIndex: 2,
                );
        },
      ),
    );
  }
}
