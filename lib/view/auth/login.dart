import 'dart:io';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/auth/signup.dart';
import 'package:air_tinder/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:air_tinder/view/widget/agree_to_terms.dart';
import 'package:air_tinder/view/widget/auth_fields.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(
        seconds: 1,
      ),
      () => triggerBottomSheet(),
    );
  }

  void triggerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return LoginBottomSheetData();
      },
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: false,
      barrierColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(
          top: height(0.15, context),
        ),
        height: height(1.0, context),
        width: width(1.0, context),
        decoration: loginBg,
        child: Column(
          children: [
            Image.asset(
              Assets.imagesWhiteLogo,
              height: 76.65,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginBottomSheetData extends StatefulWidget {
  @override
  State<LoginBottomSheetData> createState() => _LoginBottomSheetDataState();
}

class _LoginBottomSheetDataState extends State<LoginBottomSheetData> {
  late TextEditingController emailCon;
  late TextEditingController passCon;

  Future<void> login() async {
    if (emailCon.text.isEmpty &&
        emailCon.text == '' &&
        passCon.text.isEmpty &&
        passCon.text == '') {
      showMsg(context, 'Field cannot be empty!');
    } else {
      try {
        loading(context);
        await auth.signInWithEmailAndPassword(
          email: emailCon.text.trim(),
          password: passCon.text.trim(),
        );
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => BottomNavBar(),
          ),
          (route) => false,
        );
        emailCon.clear();
        passCon.clear();
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showMsg(context, e.message.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailCon = TextEditingController();
    passCon = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailCon.dispose();
    passCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 406,
      decoration: BoxDecoration(
        color: kTertiaryColor.withOpacity(0.80),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          AuthHeading(
            heading: 'Welcome to JetLatch',
            color: kPrimaryColor,
          ),
          AuthSubHeading(
            subHeading: 'You will never forget a flight with JetLatch',
            color: kPrimaryColor,
          ),
          SizedBox(
            height: 10,
          ),
          AuthFields(
            labelText: 'Email',
            hintText: 'example@gmail.com',
            controller: emailCon,
          ),
          AuthFields(
            labelText: 'Password',
            hintText: '123456',
            isObSecure: true,
            isPasswordField: true,
            controller: passCon,
          ),
          MyText(
            text: 'Forgot your password?',
            size: 12,
            decoration: TextDecoration.underline,
            weight: FontWeight.w300,
            color: kPrimaryColor,
            paddingBottom: 15,
          ),
          SimpleButton(
            onTap: login,
            buttonText: 'Login',
            height: 40,
            textColor: kPrimaryColor,
            bgColor: kSecondaryColor,
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              MyText(
                text: 'New here? ',
                size: 12,
                weight: FontWeight.w300,
                color: kPrimaryColor,
              ),
              MyText(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Signup(),
                  ),
                ),
                text: 'Create an account!',
                size: 12,
                decoration: TextDecoration.underline,
                weight: FontWeight.w300,
                color: kPrimaryColor,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          agreeToTerms(),
        ],
      ),
    );
  }
}
