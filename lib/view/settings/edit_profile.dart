import 'dart:developer';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/provider/edit_profile_provider/edit_profile_provider.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/widget/upload_photo.dart';
import 'package:air_tinder/view/widget/custom_dialog.dart';
import 'package:air_tinder/view/widget/date_of_birthfield.dart';
import 'package:air_tinder/view/widget/edit_profile_photo.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:air_tinder/view/widget/show_interests.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final _provider = Provider.of<EditProfileProvider>(context, listen: false);
      getUserDetails(_provider);
    });
  }

  void getUserDetails(EditProfileProvider provider) {
    setState(() {
      provider.fullNameCon.text = userDetailModel.fullName!;
      provider.dobCon.text = userDetailModel.dateOfBirth!;
      provider.aboutCon.text = userDetailModel.about!;
      userDetailModel.gender == 'Male'
          ? provider.genderIndex = 0
          : provider.genderIndex = 1;

      log(provider.fullNameCon.text.toString());
    });
  }

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
              profileImage: userDetailModel.profileImgUrl,
              onEditTap: () {},
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: List.generate(
                userDetailModel.additionalImages!.isNotEmpty
                    ? userDetailModel.additionalImages!.length + 1
                    : 3,
                    (index) {
                  if (index < userDetailModel.additionalImages!.length) {
                    return UploadPhoto(
                      index: index,
                      imgURL: userDetailModel.additionalImages![index],
                      onTap: () {},
                      onRemoveTap: () async {
                        final imageUrl =
                        userDetailModel.additionalImages![index];
                        await profiles.doc(userDetailModel.uId).update(
                          {
                            'additionalImages': FieldValue.arrayRemove(
                              [
                                imageUrl,
                              ],
                            ),
                          },
                        );
                        await firebaseStorage.refFromURL(imageUrl).delete();
                      },
                    );
                  } else {
                    return UploadPhoto(
                      onTap: () {},
                      index: index,
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Consumer<EditProfileProvider>(
              builder: (context, provider, child) {
                return MyTextField(
                  havePrefix: false,
                  haveLabel: false,
                  isAllWhite: true,
                  hintText: 'Full name',
                  controller: provider.fullNameCon,
                );
              },
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
                        Consumer<EditProfileProvider>(
                          builder: (context, provider, child) {
                            return GestureDetector(
                              onTap: () => provider.setGender(
                                index,
                                provider.genderIndex == 0 ? 'Male' : 'Female',
                              ),
                              child: Container(
                                height: 21,
                                width: 21,
                                decoration: BoxDecoration(
                                  color: provider.genderIndex == index
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
                                  color: provider.genderIndex == index
                                      ? kSecondaryColor
                                      : Colors.transparent,
                                ),
                              ),
                            );
                          },
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
            Consumer<EditProfileProvider>(
              builder: (context, provider, child) {
                return DateOfBirthField(
                  isAllWhite: true,
                  controller: provider.dobCon,
                );
              },
            ),
            ShowInterests(),
            SizedBox(
              height: 30,
            ),
            Consumer<EditProfileProvider>(
              builder: (context, provider, child) {
                return MyTextField(
                  isAllWhite: true,
                  havePrefix: false,
                  isFilled: true,
                  filledColor: kPrimaryColor,
                  labelText: 'About me',
                  controller: provider.aboutCon,
                  maxLines: 6,
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<EditProfileProvider>(
              builder: (context, provider, child) {
                return SimpleButton(
                  onTap: () {},
                  height: 40,
                  buttonText: 'Save',
                );
              },
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
                      heading:
                      'Are you sure you want to delete your account?',
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
