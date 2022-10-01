import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/settings/edit_interests.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class ShowInterests extends StatelessWidget {
  const ShowInterests({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            5,
            (index) {
              return interestCards('Interest');
            },
          ),
        ),
      ],
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
