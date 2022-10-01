import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/auth_provider/auth_provider.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
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
                heading: 'Please enter your landing details',
              ),
              AuthSubHeading(
                subHeading:
                'Tell us about where you are going, It will help us and other know more about your travel',
              ),
              MyTextField(
                labelText: 'Which city is your destination?',
                prefixIcon: Assets.imagesCity,
                hintText: 'City',
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'At which Airport are you gonna land?',
                prefixIcon: Assets.imagesAirPlane,
                hintText: 'Airport',
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'Please enter landing date',
                prefixIcon: Assets.imagesCalendarBlack,
                hintText: 'Landing date',
                iconSize: 15.98,
              ),
              MyTextField(
                labelText: 'Please enter landing time',
                hintText: 'Landing time',
                prefixIcon: Assets.imagesClock,
                iconSize: 15.83,
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
                buttonIcon: Assets.imagesPlaneArrival,
                iconSize: 11.59,
                onTap: () => provider.updateStackIndex(context, 4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
