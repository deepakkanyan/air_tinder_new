import 'dart:developer';
import 'dart:io';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/settings/edit_interests.dart';
import 'package:air_tinder/view/widget/custom_date_picker.dart';
import 'package:air_tinder/view/widget/custom_dialog.dart';
import 'package:air_tinder/view/widget/custom_dob_picker.dart';
import 'package:air_tinder/view/widget/date_of_birthfield.dart';
import 'package:air_tinder/view/widget/edit_profile_photo.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:air_tinder/view/widget/pick_image.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:air_tinder/view/widget/upload_photo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String profileImage = '';
  TextEditingController fullNameCon = TextEditingController();
  TextEditingController dobCon = TextEditingController();
  TextEditingController aboutCon = TextEditingController();
  String selectedGender = '';
  int genderIndex = 0;
  List interests = [];
  List<dynamic> additionalImages = [];

  File? _pickedProfileImage;
  List<XFile> _additionalImages = [];
  DateTime _dateTime = DateTime.now();

  bool get isValid {
    if (_pickedProfileImage == null &&
        _additionalImages.isEmpty &&
        fullNameCon.text == userDetailModel.fullName &&
        dobCon.text == userDetailModel.dateOfBirth &&
        selectedGender == userDetailModel.gender &&
        aboutCon.text == userDetailModel.about) {
      showMsg(context, 'Nothing Changed!');
      return false;
    } else if (fullNameCon.text.isEmpty && fullNameCon.text == '') {
      showMsg(context, 'Name cannot be empty!');
    } else if (dobCon.text.isEmpty && dobCon.text == '') {
      showMsg(context, 'Date of birth cannot be empty!');
      return false;
    } else if (aboutCon.text.isEmpty && aboutCon.text == '') {
      showMsg(context, 'About of birth cannot be empty!');
      return false;
    }
    return true;
  }

  Future _uploadData() async {
    if (_pickedProfileImage == null &&
        _additionalImages.isEmpty &&
        fullNameCon.text == userDetailModel.fullName &&
        dobCon.text == userDetailModel.dateOfBirth &&
        selectedGender == userDetailModel.gender &&
        aboutCon.text == userDetailModel.about) {
      showMsg(context, 'Nothing Changed!');
    } else {
      try {
        String uId = userDetailModel.uId!;
        loadingDialog(context);
        _pickedProfileImage == null
            ? null
            : await _uploadProfileImage().then(
              (value) async {
            await profiles.doc(uId).update({
              'profileImage': profileImage,
            });
            Navigator.pop(context);
            showMsg(
              context,
              'Profile picture updated successfully',
              bgColor: kSuccessColor,
            );
          },
        );
        fullNameCon.text.isEmpty && fullNameCon.text == '' && fullNameCon.text != userDetailModel.fullName
            ? showMsg(context, 'Name cannot be empty!')
            : await profiles.doc(uId).update({
          'fullName': fullNameCon.text,
        }).then(
              (value) {
            Navigator.pop(context);
            showMsg(
              context,
              'Name updated successfully',
              bgColor: kSuccessColor,
            );
          },
        );

        selectedGender == userDetailModel.gender
            ? null
            : await profiles.doc(uId).update({
          'gender': selectedGender,
        }).then(
              (value) {
            Navigator.pop(context);
            showMsg(
              context,
              'Gender updated successfully',
              bgColor: kSuccessColor,
            );
          },
        );

        await profiles.doc(userDetailModel.uId).get().then(
              (value) {
            setState(() {
              userDetailModel = UserDetailModel.fromJson(
                value.data() as Map<String, dynamic>,
              );
              _pickedProfileImage = null;
              _additionalImages = [];
            });
          },
        );
        // _additionalImages.isEmpty ? null : await _uploadMultipleImage();
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showMsg(context, e.message.toString());
      }
    }
  }

  Future _getProfileImage(ImageSource source) async {
    try {
      final img = await ImagePicker().pickImage(source: source, imageQuality: imageQuality);
      if (img == null) {
        return;
      } else {
        setState(() {
          _pickedProfileImage = File(img.path);
          profileImage = '';
        });
        Navigator.pop(context);
      }
    } on PlatformException catch (e) {
      showMsg(context, 'Something went wrong!');
    }
  }

  Future _uploadProfileImage() async {
    Reference ref = await firebaseStorage.ref().child(
      'images/profile image/${DateTime.now().toString()}',
    );
    await ref.putFile(_pickedProfileImage!);
    await ref.getDownloadURL().then((value) {
      log(value.toString());
      setState(() {
        profileImage = value;
      });
    });
  }

  Future _getMoreImages() async {
    try {
      List<XFile>? _images = await ImagePicker().pickMultiImage();
      if (_images == null) {
        return;
      } else {
        setState(() {
          _additionalImages = _images;
        });
      }
    } on PlatformException catch (e) {
      showMsg(context, 'Something went wrong!');
    }
  }

  Future _uploadMultipleImage() async {
    for (int i = 0; i < _additionalImages.length; i++) {
      Reference ref = await firebaseStorage.ref().child(
        'images/profile images/${DateTime.now().toString()}',
      );
      await ref.putFile(File(_additionalImages[i].path));
      await ref.getDownloadURL().then((value) {
        setState(() {
          additionalImages.add(value);
        });
      });
      await profiles.doc(auth.currentUser!.uid).update({
        'additionalImages': additionalImages,
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _additionalImages.removeWhere((element) => element == _additionalImages[index]);
    });
  }

  void setGender(int index, String gender) {
    setState(() {
      genderIndex = index;
      selectedGender = gender;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    setState(() {
      profileImage = userDetailModel.profileImgUrl ?? "";
      fullNameCon.text = userDetailModel.fullName ?? "";
      userDetailModel.gender == 'Male' ? genderIndex = 0 : genderIndex = 1;
      genderIndex == 0 ? selectedGender = 'Male' : selectedGender = 'Female';
      dobCon.text = userDetailModel.dateOfBirth ?? "";
      aboutCon.text = userDetailModel.about ?? "";
      interests = userDetailModel.interests ?? [];
      additionalImages = userDetailModel.additionalImages ?? [];
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            EditProfilePhoto(
              profileImageURL: profileImage,
              filePath: _pickedProfileImage,
              onEditTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return PickImage(
                      pickFromCamera: () => _getProfileImage(ImageSource.camera),
                      pickFromGallery: () => _getProfileImage(ImageSource.gallery),
                    );
                  },
                  isScrollControlled: true,
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: List.generate(
                additionalImages.isNotEmpty ? additionalImages.length : 3,
                    (index) {
                  if (index < additionalImages.length) {
                    return UploadPhoto(
                      index: index,
                      // pickedImage: _additionalImages[index],
                      imgURL: additionalImages[index],
                      onTap: () {},
                      onRemoveTap: () async {
                        final imageUrl = additionalImages[index];
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
                        setState(() {
                          final imageUrl = additionalImages[index];
                        });
                      },
                    );
                  } else {
                    return UploadPhoto(
                      onTap: _getMoreImages,
                      index: index,
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MyTextField(
              havePrefix: false,
              haveLabel: false,
              isAllWhite: true,
              controller: fullNameCon,
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
                          onTap: () => setGender(
                            index,
                            genderIndex == 0 ? 'Male' : 'Female',
                          ),
                          child: Container(
                            height: 21,
                            width: 21,
                            decoration: BoxDecoration(
                              color: genderIndex == index ? kPrimaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 2.0,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              size: 17,
                              color: genderIndex == index ? kSecondaryColor : Colors.transparent,
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
              controller: dobCon,
              onCalenderTap: () {
                print("");
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  builder: (_) {
                    return CustomDOBDatePicker(
                      // initialDateTime: _dateTime,

                      maxYear: DateTime.now().year - 18,
                      maximumDate: DateTime(
                        DateTime.now().year - 18,
                        DateTime.now().month,
                        DateTime.now().day,
                      ),
                      initialDateTime: DateTime(
                        DateTime.now().year - 18,
                        DateTime.now().month,
                        DateTime.now().day,
                      ),

                      onDateTimeChanged: (value) {
                        setState(() {
                          _dateTime = value;
                        });
                      },
                      heading: "choose your birthday",
                      onDoneTap: () {
                        setState(() {
                          dobCon.text = DateFormat.yMEd().format(_dateTime).toString();
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    MyText(
                      text: 'Interests',
                      size: 16,
                      color: kPrimaryColor,
                      paddingRight: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditInterests(),
                        ),
                      ),
                      child: Image.asset(
                        Assets.imagesEdit,
                        height: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                    interests.length,
                        (index) {
                      return interestCards(interests[index]);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MyTextField(
              isAllWhite: true,
              havePrefix: false,
              isFilled: true,
              filledColor: kPrimaryColor,
              labelText: 'About me',
              controller: aboutCon,
              maxLines: 6,
            ),
            SizedBox(
              height: 10,
            ),
            SimpleButton(
              onTap: _uploadData,
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
                      content: 'All you data will be lost. You can create a new account later on.',
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

  Widget interestCards(String interest) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: kPrimaryColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 3,
      ),
      child: MyText(
        text: interest,
        size: 14,
        color: kSecondaryColor,
      ),
    );
  }
}

