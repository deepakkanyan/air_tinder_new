import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/auth_provider/auth_provider.dart';
import 'package:air_tinder/view/widget/custom_container.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/intertest_buttons.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditInterests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
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
                  // Wrap(
                  //   spacing: 13,
                  //   runSpacing: 13,
                  //   children: List.generate(
                  //     provider.interests.length,
                  //     (index) {
                  //       var data = provider.interests[index];
                  //       return InterestButtons(
                  //         interest: data.interest,
                  //         isSelected: data.isSelected,
                  //         onTap: provider,
                  //         index: index,
                  //       );
                  //     },
                  //   ),
                  // ),
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
                    onTap: () {},
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
