import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/upload_photo.dart';
import 'package:air_tinder/view/widget/custom_dialog.dart';
import 'package:air_tinder/view/widget/date_of_birthfield.dart';
import 'package:air_tinder/view/widget/edit_profile_photo.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:air_tinder/view/widget/show_interests.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int genderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        context: context,
        title: 'Edit profile',
      ),
      body: Container(
        decoration: redBg,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          children: [
            EditProfilePhoto(
              profileImage: Assets.imagesDummyMan,
              onEditTap: () {},
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: List.generate(
                3,
                (index) => UploadPhoto(
                  index: index,
                  onTap: () {},
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MyTextField(
              havePrefix: false,
              haveLabel: false,
              isAllWhite: true,
              hintText: 'Full name',
            ),
            MyText(
              paddingBottom: 10,
              text: 'Gender',
              size: 16,
              color: kPrimaryColor,
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
                            });
                          },
                          child: Container(
                            height: 21,
                            width: 21,
                            decoration: BoxDecoration(
                              color: genderIndex == index
                                  ? kPrimaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 2.0,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              size: 17,
                              color: genderIndex == index
                                  ? kSecondaryColor
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
              height: 30,
            ),
            DateOfBirthField(
              isAllWhite: true,
            ),
            ShowInterests(),
            SizedBox(
              height: 30,
            ),
            MyTextField(
              isAllWhite: true,
              havePrefix: false,
              isFilled: true,
              filledColor: kPrimaryColor,
              labelText: 'About me',
              maxLines: 6,
            ),
            SizedBox(
              height: 10,
            ),
            SimpleButton(
              onTap: () {},
              height: 40,
              buttonText: 'Save',
            ),
            SizedBox(
              height: 5,
            ),
            SimpleButton(
              bgColor: kTertiaryColor,
              textColor: kPrimaryColor,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return CustomDialog(
                      heading: 'Are you sure you want to delete your account?',
                      content:
                          'All you data will be lost. You can create a new account later on.',
                      onYesTap: () {},
                      onNoTap: () {},
                    );
                  },
                );
              },
              height: 40,
              buttonText: 'Delete my profile',
            ),
          ],
        ),
      ),
    );
  }
}
