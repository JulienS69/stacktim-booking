import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacktim_booking/helper/bottom_colors.dart';
import 'package:stacktim_booking/helper/icons.dart';
import 'package:stacktim_booking/helper/tab_icon_data.dart';
import 'package:stacktim_booking/navigation/x_bottom_navigation_bar.dart';
import 'package:stacktim_booking/ui/dashboard/dashboard_view.dart';

import '../navigation/route.dart';

class XMobileScaffold extends StatefulWidget {
  final bool isShowBottomNavigationBar;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Widget? bottomSheet;
  final void Function(GlobalKey<ScaffoldState> key)? onLoad;
  final void Function(int unreadNotifCount)? onCloseDrawer;
  final bool? withHeader;
  final bool? withPadding;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? leadingWidget;
  final bool? extendBodyBehindAppBar;
  final Widget content;

  const XMobileScaffold({
    Key? key,
    this.isShowBottomNavigationBar = true,
    this.floatingActionButton,
    this.appBar,
    this.onLoad,
    this.bottomSheet,
    this.onCloseDrawer,
    this.withHeader = true,
    this.withPadding = true,
    this.title,
    this.titleStyle,
    this.leadingWidget,
    this.extendBodyBehindAppBar,
    required this.content,
  }) : super(key: key);

  @override
  State<XMobileScaffold> createState() => _XMobileScaffoldState();
}

class _XMobileScaffoldState extends State<XMobileScaffold>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  List<IconData> iconList = [
    dashboardIcon,
    calendarIcon,
    profileIcon,
    Icons.dangerous,
  ];

  Widget tabBody = Container(
    color: BottomTheme.background,
  );

  late final GlobalKey<ScaffoldState> scaffoldKey;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    for (final TabIconData tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;
    tabBody = DashboardView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: widget.bottomSheet,
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          widget.content,
        ],
      ),
      appBar: widget.appBar,
      bottomNavigationBar: customBottomBar(),
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? false,
    );
  }

  Widget customBottomBar() {
    return SizedBox(
      height: 100,
      child: Column(
        children: <Widget>[
          BottomBarView(
            tabIconsList: tabIconsList,
            addClick: () {},
            changeIndex: (int index) {
              if (index == 0 || index == 2) {
                animationController.reverse().then<dynamic>((_) {
                  if (mounted) {
                    return Get.offAllNamed(Routes.dashboard);
                  }
                });
              } else if (index == 1 || index == 3) {
                animationController.reverse().then<dynamic>((_) {
                  if (mounted) {
                    return Get.offAllNamed(Routes.profil);
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
