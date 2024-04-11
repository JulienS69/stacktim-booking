import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

class XErrorPage extends StatelessWidget {
  final String contentTitle;
  final String? titleButton;
  final void Function() onPressedRetry;
  final bool? withAppBar;
  final bool? withBottomBar;
  final int? bottomNavIndex;
  const XErrorPage({
    required this.contentTitle,
    required this.onPressedRetry,
    this.titleButton,
    this.withAppBar,
    this.withBottomBar,
    this.bottomNavIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XMobileScaffold(
      isShowBottomNavigationBar: withBottomBar ?? false ? true : false,
      bottomNavIndex: bottomNavIndex ?? 0,
      appBar: withAppBar ?? false
          ? const XPageHeader(
              title: '',
              centerTitle: true,
              imagePath: logoOverSlug,
            )
          : null,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    errorLottie,
                    fit: BoxFit.cover,
                    height: 350,
                    repeat: false,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        contentTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  onPressedRetry();
                },
                child: Text(
                  titleButton ?? "Réessayer",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
