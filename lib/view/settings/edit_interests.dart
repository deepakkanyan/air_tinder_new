import 'dart:developer';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/model/complete_profile_model/what_makes_you_happy_model.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/intertest_buttons.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:air_tinder/utils/instances.dart';

class EditInterests extends StatefulWidget {
  @override
  State<EditInterests> createState() => _EditInterestsState();
}

class _EditInterestsState extends State<EditInterests> {
  List interests = [];
  List<InterestModels> selectedInterests = [];
  List<InterestModels> interestList = [
    InterestModels(
      interest: 'Love',
    ),
    InterestModels(
      interest: 'Romance',
    ),
    InterestModels(
      interest: 'Shopping Sprees',
    ),
    InterestModels(
      interest: 'Resorts',
    ),
    InterestModels(
      interest: 'Long-term',
    ),
    InterestModels(
      interest: 'Movies',
    ),
    InterestModels(
      interest: 'Mentor',
    ),
    InterestModels(
      interest: 'Partner in Crime',
    ),
    InterestModels(
      interest: 'Adventure',
    ),
    InterestModels(
      interest: 'Gym Buddy',
    ),
    InterestModels(
      interest: 'Short-term',
    ),
    InterestModels(
      interest: 'Business Partner',
    ),
    InterestModels(
      interest: 'Self-Care',
    ),
    InterestModels(
      interest: 'Rent',
    ),
    InterestModels(
      interest: 'Yoga',
    ),
    InterestModels(
      interest: 'Massage',
    ),
    InterestModels(
      interest: 'Swimming',
    ),
    InterestModels(
      interest: 'Fine Dining',
    ),
    InterestModels(
      interest: 'Cooking',
    ),
    InterestModels(
      interest: 'Allowance',
    ),
    InterestModels(
      interest: 'Cars',
    ),
    InterestModels(
      interest: 'Lunch Date',
    ),
    InterestModels(
      interest: 'Good Conversation',
    ),
    InterestModels(
      interest: 'Pen Pal',
    ),
    InterestModels(
      interest: 'Video Date',
    ),
    InterestModels(
      interest: 'Wedding Date',
    ),
    InterestModels(
      interest: 'Coffee Date',
    ),
    InterestModels(
      interest: 'Brains and Beauty',
    ),
    InterestModels(
      interest: 'Friends',
    ),
    InterestModels(
      interest: 'Soul Mate',
    ),
    InterestModels(
      interest: 'Private Jet',
    ),
  ];

  void setSelectedInterest(
    String interest,
    int index,
  ) {
    setState(
      () {
        var data = interestList[index];
        data.isSelected = !data.isSelected!;
        if (data.isSelected == true) {
          selectedInterests.add(
            InterestModels(
              interest: interest,
              isSelected: true,
            ),
          );
          interests.add(interest);
        } else {
          selectedInterests.removeWhere(
            (element) => element.interest == data.interest,
          );
          interests.removeWhere((element) => element == interest);
        }
      },
    );
  }

  Future uploadData() async {
    if (selectedInterests.isNotEmpty && selectedInterests.length >= 3) {
      try {
        loadingDialog(context);
        await profiles.doc(userDetailModel.uId).update({
          'interests': interests,
        });
        await profiles.doc(userDetailModel.uId).get().then(
          (value) {
            userDetailModel = UserDetailModel.fromJson(
              value.data() as Map<String, dynamic>,
            );
          },
        );
        Navigator.pop(context);
        showMsg(
          context,
          'Successfully updated!',
          bgColor: kSuccessColor,
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showMsg(context, e.message.toString());
      }
    } else {
      showMsg(context, 'Choose minimum 3 interests!');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInterests();
  }

  void getInterests() async {
    await profiles.doc(userDetailModel.uId).get().then(
      (value) {
        UserDetailModel uDM = UserDetailModel.fromJson(
          value.data() as Map<String, dynamic>,
        );
        interests = uDM.interests!;
        interestList.forEach(
          (element) {
            if (interests.contains(element.interest)) {
              element.isSelected = true;
              selectedInterests.add(
                InterestModels(
                  interest: element.interest,
                  isSelected: true,
                ),
              );
            }
          },
        );
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        leadingWidth: 30,
        elevation: 0,
        backgroundColor: kSecondaryColor,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              padding: EdgeInsets.only(left: 15),
              onPressed: () => Navigator.pop(context),
              icon: Image.asset(
                Assets.imagesArrowBack,
                height: 15.87,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.80),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  AuthHeading(
                    heading: 'What makes you feel happy?',
                  ),
                  AuthSubHeading(
                    subHeading:
                        'Please select all your interests and then click save.',
                  ),
                  Wrap(
                    spacing: 13,
                    runSpacing: 13,
                    children: List.generate(
                      interestList.length,
                      (index) {
                        var data = interestList[index];
                        return InterestButtons(
                          interest: data.interest,
                          isSelected: data.isSelected,
                          onTap: () => setSelectedInterest(
                            data.interest!,
                            index,
                          ),
                          index: index,
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
                  child: SimpleButton(
                    onTap: () => uploadData(),
                    buttonText: 'Save',
                    bgColor: kSecondaryColor,
                    textColor: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
