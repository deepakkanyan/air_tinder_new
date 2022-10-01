import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/auth/complete_profile/complete_profile.dart';
import 'package:air_tinder/view/widget/agree_to_terms.dart';
import 'package:air_tinder/view/widget/auth_fields.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
        return SignupBottomSheetData();
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

class SignupBottomSheetData extends StatefulWidget {
  const SignupBottomSheetData({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupBottomSheetData> createState() => _SignupBottomSheetDataState();
}

class _SignupBottomSheetDataState extends State<SignupBottomSheetData> {
  late TextEditingController emailCon;
  late TextEditingController passCon;
  late TextEditingController confirmPassCon;
  late TextEditingController fullNameCon;
  String gender = '';
  DateTime createdAt = DateTime.now();

  bool get isValid {
    if (emailCon.text.isEmpty && emailCon.text == '') {
      showMsg(context, 'Email cannot be empty!');
      return false;
    } else if (passCon.text.isEmpty && passCon.text == '') {
      showMsg(context, 'Password cannot be empty!');
      return false;
    } else if (passCon.text.length < 6) {
      showMsg(context, 'Password must be 6 characters long!');
      return false;
    } else if (passCon.text != confirmPassCon.text) {
      showMsg(context, 'Password do not match!');
      return false;
    } else if (fullNameCon.text.isEmpty && fullNameCon.text == '') {
      showMsg(context, 'Name cannot be empty');
      return false;
    }
    return true;
  }

  Future<void> signup() async {
    if (isValid) {
      try {
        loading(context);
        await auth.createUserWithEmailAndPassword(
          email: emailCon.text.trim(),
          password: passCon.text.trim(),
        );
        String uId = auth.currentUser!.uid;
        await profiles.doc(uId).set({
          'uId': uId,
          'email': emailCon.text,
          'fullName': fullNameCon.text,
          'gender': gender,
          'createdAt': DateFormat.yMEd().format(createdAt).toString(),
        });
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => CompleteProfile(),
          ),
          (route) => false,
        );
        clearValues();
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
    confirmPassCon = TextEditingController();
    fullNameCon = TextEditingController();
  }

  void clearValues() {
    emailCon.clear();
    passCon.clear();
    confirmPassCon.clear();
    fullNameCon.clear();
    gender = '';
  }

  @override
  void dispose() {
    super.dispose();
    emailCon.dispose();
    passCon.dispose();
    confirmPassCon.dispose();
    fullNameCon.dispose();
  }

  int genderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 569,
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
          AuthFields(
            labelText: 'Confirm Password',
            hintText: '123456',
            isObSecure: true,
            isPasswordField: true,
            controller: confirmPassCon,
          ),
          AuthFields(
            labelText: 'Full name',
            hintText: 'Full name',
            controller: fullNameCon,
          ),
          MyText(
            paddingBottom: 10,
            text: 'Gender',
            size: 16,
            color: kPrimaryColor,
            weight: FontWeight.w300,
          ),
          Row(
            children: List.generate(
              2,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            genderIndex = index;
                            gender = index == 0 ? 'Male' : 'Female';
                          });
                        },
                        child: Container(
                          height: 21,
                          width: 21,
                          decoration: BoxDecoration(
                            color: genderIndex == index
                                ? kSecondaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: kSecondaryColor,
                              width: 2.0,
                            ),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 17,
                            color: genderIndex == index
                                ? kTertiaryColor
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      MyText(
                        paddingLeft: 10,
                        text: index == 0 ? 'Male' : 'Female',
                        size: 16,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SimpleButton(
            onTap: signup,
            buttonText: 'Sign up',
            height: 40,
            textColor: kPrimaryColor,
            bgColor: kSecondaryColor,
          ),
          SizedBox(
            height: 10,
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
