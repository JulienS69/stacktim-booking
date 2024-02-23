import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/icons.dart';

class XMobileScaffold extends StatefulWidget {
  final Widget body;
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
  final int bottomNavIndex;

  const XMobileScaffold({
    Key? key,
    required this.body,
    required this.bottomNavIndex,
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
  }) : super(key: key);

  @override
  State<XMobileScaffold> createState() => _XMobileScaffoldState();
}

class _XMobileScaffoldState extends State<XMobileScaffold> {
  List<IconData> iconList = [
    dashboardIcon,
    calendarIcon,
    profileIcon,
    Icons.dangerous,
  ];

  late final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    if (widget.onLoad != null) {
      widget.onLoad!(scaffoldKey);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int bottomNavIndex = widget.bottomNavIndex;
    return Scaffold(
      bottomSheet: widget.bottomSheet,
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: widget.body,
          ),
        ],
      ),
      appBar: widget.appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: AnimatedBottomNavigationBar.builder(
          onTap: (index) {
            // if (index == 0 && Get.currentRoute != Routes.dashboard) {
            //   Get.offAllNamed(Routes.dashboard);
            // } else if (index == 2 && Get.currentRoute != Routes.profil) {
            //   Get.offAllNamed(Routes.profil);
            // }
            setState(() => bottomNavIndex = index);
          },
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: isActive ? Colors.red : Colors.white,
                ),
              ],
            );
          },
          activeIndex: bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          leftCornerRadius: 5,
          rightCornerRadius: 5,
          backgroundColor: Colors.black,
        ),
      ),
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? false,
    );
  }
}
