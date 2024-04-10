import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacktim_booking/game/game.dart';
import 'package:stacktim_booking/helper/strings.dart';
import 'package:stacktim_booking/widget/x_app_bar.dart';
import 'package:stacktim_booking/widget/x_mobile_scaffold.dart';

class GameSurprise {
  Widget build(BuildContext context) {
    return XMobileScaffold(
      appBar: const XPageHeader(
        title: '',
        imagePath: logoOverSlug,
      ),
      isShowBottomNavigationBar: false,
      body: TRexGameWrapper(),
    );
  }
}

class TRexGameWrapper extends StatefulWidget {
  @override
  _TRexGameWrapperState createState() => _TRexGameWrapperState();
}

class _TRexGameWrapperState extends State<TRexGameWrapper> {
  bool splashGone = false;
  TRexGame? game;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    Flame.images.loadAll(["sprite.png"]).then(
      (image) => {
        setState(() {
          game = TRexGame(spriteImage: image[0]);
          _focusNode.requestFocus();
        })
      },
    );
  }

  void onRawKeyEvent(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.space) {
      game!.onAction();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (game == null) {
      return const Center(
        child: Text("Chargement en cours"),
      );
    }
    return Container(
      color: Colors.black,
      constraints: const BoxConstraints.expand(),
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: onRawKeyEvent,
        child: GameWidget(
          game: game!,
        ),
      ),
    );
  }
}
