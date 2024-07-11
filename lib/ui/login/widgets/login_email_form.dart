import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacktim_booking/helper/connection_helper.dart';
import 'package:stacktim_booking/helper/snackbar.dart';
import 'package:stacktim_booking/helper/style.dart';
import 'package:stacktim_booking/ui/login/login_view_controller.dart';

import '../../../helper/color.dart';

// ignore: must_be_immutable
class LoginEmailForm extends StatefulWidget {
  LoginViewController loginViewController;
  LoginEmailForm({
    required this.loginViewController,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoginEmailFormState createState() => _LoginEmailFormState();
}

class _LoginEmailFormState extends State<LoginEmailForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.loginViewController.emailController,
          focusNode: widget.loginViewController.emailFocusNode,
          cursorColor: grey13,
          textAlign: TextAlign.center,
          onTap: () {
            widget.loginViewController.isUnfocus.value = false;
          },
          onTapOutside: (outside) {
            FocusScope.of(context).requestFocus(FocusNode());
            widget.loginViewController.isUnfocus.value = true;
          },
          onSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
            widget.loginViewController.isUnfocus.value = true;
          },
          onChanged: (value) {
            widget.loginViewController.isUnfocus.value = false;
          },
          decoration: const InputDecoration(
            hintText: "Email",
            hintStyle: antaStyle,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
          ),
          style: const TextStyle(
            color: Colors.white60,
            fontFamily: 'Anta',
            decoration: TextDecoration.none,
          ),
        ),
        TextField(
          controller: widget.loginViewController.passwordController,
          focusNode: widget.loginViewController.passwordFocusNode,
          cursorColor: grey13,
          textAlign: TextAlign.center,
          onTap: () {
            widget.loginViewController.isUnfocus.value = false;
          },
          onTapOutside: (outside) {
            FocusScope.of(context).requestFocus(FocusNode());
            widget.loginViewController.isUnfocus.value = true;
          },
          onSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
            widget.loginViewController.isUnfocus.value = true;
          },
          onChanged: (value) {
            widget.loginViewController.isUnfocus.value = false;
          },
          decoration: const InputDecoration(
            hintText: "Mot de passe",
            hintStyle: antaStyle,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
          ),
          style: const TextStyle(
            color: Colors.white60,
            fontFamily: 'Anta',
            decoration: TextDecoration.none,
          ),
          obscureText: true,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
          child: InkWell(
            onTap: () async {
              if (await ConnectionHelper.hasNoConnection()) {
                showSnackbar("Aucune connexion à internet trouvé",
                    SnackStatusEnum.error);
              } else {
                HapticFeedback.heavyImpact();
                if (widget
                        .loginViewController.emailController.text.isNotEmpty &&
                    widget.loginViewController.passwordController.text
                        .isNotEmpty) {
                  await widget.loginViewController.login();
                } else {
                  showSnackbar(
                      "Tu dois renseigner ton email ainsi que ton mot de passe pour pouvoir te connecter",
                      SnackStatusEnum.warning);
                }
              }
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(),
                color: black,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Se connecter".toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
