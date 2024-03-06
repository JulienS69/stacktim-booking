import 'package:get/get.dart';
import 'package:stacktim_booking/navigation/route.dart';
import 'package:stacktim_booking/ui/calendar/calendar_view.dart';
import 'package:stacktim_booking/ui/calendar/calendar_view_controller_bindings.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view_controller_bindings.dart';
import 'package:stacktim_booking/ui/login/login_view.dart';
import 'package:stacktim_booking/ui/login/login_view_controller_bindings.dart';
import 'package:stacktim_booking/ui/profil/profil_view.dart';
import 'package:stacktim_booking/ui/profil/profil_view_controller_bindings.dart';
import 'package:stacktim_booking/ui/welcome/welcome_view.dart';
import 'package:stacktim_booking/ui/welcome/welcome_view_controller_bindings.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      title: 'login'.tr,
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginViewControllerBindings(),
    ),
    GetPage(
      title: 'welcome'.tr,
      name: Routes.welcome,
      binding: WelcomeViewControllerBindings(),
      page: () => WelcomeView(),
    ),
    GetPage(
      title: 'dashboard'.tr,
      name: Routes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardViewControllerBindings(),
    ),
    GetPage(
      title: 'profil'.tr,
      name: Routes.profil,
      page: () => const ProfilView(),
      binding: ProfilViewControllerBindings(),
    ),
    GetPage(
      title: 'profil'.tr,
      name: Routes.calendar,
      page: () => const CalendarPage(),
      binding: CalendarViewControllerBindings(),
    ),
  ];
}
