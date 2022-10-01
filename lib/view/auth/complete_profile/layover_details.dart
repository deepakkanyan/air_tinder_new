import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayoverDetails extends StatelessWidget {
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
                heading: 'Please enter your layover details',
              ),
              AuthSubHeading(
                subHeading:
                    'Tell us about the layover. We can\'t wait to hear that. This is where the magic happens. Lets get you to the best layover of your life.',
              ),
              MyTextField(
                labelText: 'In which city is the layover?',
                prefixIcon: Assets.imagesCity,
                hintText: 'City',
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'At which Airport is the layover at?',
                prefixIcon: Assets.imagesAirPlane,
                hintText: 'Airport',
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'Please enter landing date at the layover',
                prefixIcon: Assets.imagesCalendarBlack,
                hintText: 'Layover landing date',
                iconSize: 15.98,
              ),
              MyTextField(
                labelText: 'Please enter landing time at the layover',
                hintText: 'Layover landing time',
                prefixIcon: Assets.imagesClock,
                iconSize: 15.83,
              ),
              MyTextField(
                labelText: 'What is the stay time at the layover',
                hintText: 'Layover stay time',
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
                buttonIcon: Assets.imagesPlaneSolid,
                iconSize: 14.56,
                onTap: () => provider.updateStackIndex(context, 5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
