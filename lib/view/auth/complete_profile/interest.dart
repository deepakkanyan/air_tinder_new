import 'dart:developer';

import 'package:air_tinder/model/complete_profile_model/what_makes_you_happy_model.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/intertest_buttons.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Interest extends StatefulWidget {
  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  List<String> interests = [];
  List<InterestModels> _selectedInterest = [];
  List<InterestModels> _interestList = [
    InterestModels(interest: 'Love'),
    InterestModels(interest: 'Romance'),
    InterestModels(interest: 'Shopping Sprees'),
    InterestModels(interest: 'Resorts'),
    InterestModels(interest: 'Long-term'),
    InterestModels(interest: 'Movies'),
    InterestModels(interest: 'Mentor'),
    InterestModels(interest: 'Partner in Crime'),
    InterestModels(interest: 'Adventure'),
    InterestModels(interest: 'Gym Buddy'),
    InterestModels(interest: 'Short-term'),
    InterestModels(interest: 'Business Partner'),
    InterestModels(interest: 'Self-Care'),
    InterestModels(interest: 'Rent'),
    InterestModels(interest: 'Yoga'),
    InterestModels(interest: 'Massage'),
    InterestModels(interest: 'Swimming'),
    InterestModels(interest: 'Fine Dining'),
    InterestModels(interest: 'Cooking'),
    InterestModels(interest: 'Allowance'),
    InterestModels(interest: 'Cars'),
    InterestModels(interest: 'Lunch Date'),
    InterestModels(interest: 'Good Conversation'),
    InterestModels(interest: 'Pen Pal'),
    InterestModels(interest: 'Video Date'),
    InterestModels(interest: 'Wedding Date'),
    InterestModels(interest: 'Coffee Date'),
    InterestModels(interest: 'Brains and Beauty'),
    InterestModels(interest: 'Friends'),
    InterestModels(interest: 'Soul Mate'),
    InterestModels(interest: 'Private Jet'),
  ];

  void setSelectedInterest(String interest, int index) {
    setState(() {
      var data = _interestList[index];
      data.isSelected = !data.isSelected!;
      if (data.isSelected == true) {
        _selectedInterest.add(
          InterestModels(interest: interest, isSelected: true),
        );
        interests.add(interest);
        log(interests.toString());
      } else {
        _selectedInterest.removeWhere((element) => element.interest == data.interest);
        interests.removeWhere((element) => element == interest);
        log(interests.toString());
      }
    });
  }

  Future uploadData() async {
    if (_selectedInterest.isNotEmpty && _selectedInterest.length >= 3) {
      try {
        loadingDialog(context);
        await profiles.doc(auth.currentUser!.uid).update({
          'interests': interests,
        });
        Navigator.pop(context);
        Provider.of<GlobalProvider>(context, listen: false).updateStackIndex(context, 2);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showMsg(context, e.message.toString());
      }
    } else {
      showMsg(context, 'Choose minimum 3 interests!');
    }
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
                heading: 'What makes you feel happy?',
              ),
              AuthSubHeading(
                subHeading:
                    'Tell me about your interests as the person who is waiting for you at the layover has also told us.',
              ),
              Wrap(
                spacing: 13,
                runSpacing: 13,
                children: List.generate(
                  _interestList.length,
                  (index) {
                    var data = _interestList[index];
                    return InterestButtons(
                      interest: data.interest,
                      isSelected: data.isSelected,
                      index: index,
                      onTap: () => setSelectedInterest(data.interest!, index),
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
                onTap: uploadData,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
