import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacktim_booking/helper/color.dart';
import 'package:stacktim_booking/helper/icons.dart';

import '../navigation/route.dart';

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
  int? bottomNavIndex;
  final GapLocation? gapLocation;
  final List<String> routeNames = [
    Routes.dashboard,
    Routes.calendar,
    Routes.profil,
  ];
  final Key? bottomKey;

  XMobileScaffold({
    Key? key,
    required this.body,
    this.bottomNavIndex,
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
    this.gapLocation,
    this.bottomKey,
  }) : super(key: key);

  @override
  State<XMobileScaffold> createState() => _XMobileScaffoldState();
}

class _XMobileScaffoldState extends State<XMobileScaffold> {
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
    int bottomNavIndex = widget.bottomNavIndex ?? 0;
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
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      extendBody: widget.extendBodyBehindAppBar ?? false,
      bottomNavigationBar: widget.isShowBottomNavigationBar
          ? AnimatedBottomNavigationBar(
              icons: [
                dashboardIcon,
                calendarIcon,
                profileIcon,
              ],
              key: widget.bottomKey,
              splashColor: Colors.white,
              inactiveColor: backgroundColor,
              activeColor: Colors.white,
              activeIndex: bottomNavIndex,
              gapLocation: widget.gapLocation ?? GapLocation.none,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              onTap: (index) {
                if (index != bottomNavIndex) {
                  HapticFeedback.selectionClick();
                  setState(() {
                    widget.bottomNavIndex = index;
                  });
                  Navigator.pushReplacementNamed(
                      context, widget.routeNames[index]);
                }
              },
              backgroundColor: Colors.black,
            )
          : null,
    );
  }
}
