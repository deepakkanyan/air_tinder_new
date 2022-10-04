import 'dart:developer';
import 'dart:io';
import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/widget/pick_image.dart';
import 'package:air_tinder/view/widget/upload_photo.dart';
import 'package:air_tinder/view/widget/date_of_birthfield.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPhotos extends StatefulWidget {
  @override
  State<AddPhotos> createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  TextEditingController dobCon = TextEditingController();
  String profileImage = '';
  List<String> additionalImages = [];

  File? _pickedProfileImage;
  List<XFile> _additionalImages = [];
  DateTime _dateTime = DateTime.now();

  bool get isValid {
    if (_pickedProfileImage == '') {
      showMsg(context, 'Please select profile photo!');
      return false;
    } else if (dobCon.text.isEmpty && dobCon.text == '') {
      showMsg(context, 'Date of birth cannot be empty!');
      return false;
    }
    return true;
  }

  Future _uploadData() async {
    if (isValid) {
      try {
        loadingDialog(context);
        await _uploadProfileImage();
        await profiles.doc(auth.currentUser!.uid).update({
          'profileImage': profileImage,
          'dateOfBirth': dobCon.text,
        });
        Navigator.pop(context);
        Provider.of<GlobalProvider>(context, listen: false)
            .updateStackIndex(context, 1);
        await _uploadMultipleImage();
        setState(() {
          _pickedProfileImage = null;
          profileImage = '';
          _additionalImages = [];
          additionalImages = [];
          dobCon.clear();
        });
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showMsg(context, e.message.toString());
      }
    }
  }

  Future _getProfileImage(ImageSource source) async {
    try {
      final img = await ImagePicker().pickImage(source: source);
      if (img == null) {
        return;
      } else {
        setState(() {
          _pickedProfileImage = File(img.path);
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
      _additionalImages.removeWhere(
        (element) => element == _additionalImages[index],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  void _fetchProfileData() async {
    await profiles.doc(auth.currentUser!.uid).get().then(
      (value) {
        if (value.exists) {
          setState(() {
            Map<String, dynamic> _data = value.data() as Map<String, dynamic>;
            profileImage = _data['profileImage'];
            // additionalImages = _data['additionalImages'];
            // dobCon = _data['dateOfBirth'];
            log(profileImage.toString());
          });
        } else {
          setState(() {
            // additionalImages = [];
            // dobCon.text = '';
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              AuthHeading(
                heading: 'When did this beautiful face land on this planet?',
              ),
              AuthSubHeading(
                subHeading:
                    'Add your DOB and beautiful photos, lets get the spark going.',
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 130,
                      width: 130,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.0,
                          color: kSecondaryColor,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return PickImage(
                                pickFromCamera: () =>
                                    _getProfileImage(ImageSource.camera),
                                pickFromGallery: () =>
                                    _getProfileImage(ImageSource.gallery),
                              );
                            },
                            isScrollControlled: true,
                          ),
                          child: profileImage != ''
                              ? Image.network(
                                  profileImage,
                                  height: height(1.0, context),
                                  width: width(1.0, context),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return loadingWidget(context);
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return loadingWidget(context);
                                  },
                                )
                              : _pickedProfileImage != null
                                  ? Image.file(
                                      File(_pickedProfileImage!.path),
                                      height: height(1.0, context),
                                      width: width(1.0, context),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      Assets.imagesUser,
                                      height: height(1.0, context),
                                      width: width(1.0, context),
                                      fit: BoxFit.cover,
                                      color: kSecondaryColor,
                                    ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Image.asset(
                        Assets.imagesAddPhoto,
                        height: 26,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: List.generate(
                  _additionalImages.isNotEmpty ? 3 : 3,
                  (index) {
                    if (index < _additionalImages.length) {
                      return UploadPhoto(
                        index: index,
                        onRemoveTap: () => _removePhoto(index),
                        onTap: _getMoreImages,
                        pickedImage: _additionalImages[index],
                      );
                    } else if (index < additionalImages.length) {
                      return UploadPhoto(
                        index: index,
                        onRemoveTap: () => _removePhoto(index),
                        onTap: _getMoreImages,
                        imgURL: additionalImages[index],
                      );
                    } else {
                      return UploadPhoto(
                        index: index,
                        onRemoveTap: () {},
                        onTap: _getMoreImages,
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.5,
                ),
                child: DateOfBirthField(
                  controller: dobCon,
                  onCalenderTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      builder: (_) {
                        return pickDateOfBirth(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 167,
              child: MyButton(
                onTap: _uploadData,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget pickDateOfBirth(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Container(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyText(
                  paddingLeft: 15,
                  paddingTop: 10,
                  text: 'Choose your birthday',
                  size: 16,
                  align: TextAlign.center,
                  weight: FontWeight.w600,
                ),
                Expanded(
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.black,
                        ),
                      ),
                      scaffoldBackgroundColor: Colors.transparent,
                      primaryColor: Colors.red,
                    ),
                    child: CupertinoDatePicker(
                      initialDateTime: _dateTime,
                      mode: CupertinoDatePickerMode.date,
                      backgroundColor: kPrimaryColor,
                      minimumYear: 1900,
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (value) {
                        setState(
                          () {
                            _dateTime = value;
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: MyButton(
                    onTap: () {
                      setState(() {
                        dobCon.text =
                            DateFormat.yMEd().format(_dateTime).toString();
                      });
                      Navigator.pop(context);
                    },
                    buttonText: 'Done',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
