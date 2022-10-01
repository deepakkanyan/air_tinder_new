import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepartureDetails extends StatelessWidget {
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
                heading: 'Add your departure details',
              ),
              AuthSubHeading(
                subHeading:
                    'Tell us from where you are flying from, lets make out travel fun together',
              ),
              MyTextField(
                labelText: 'Which city are you travelling from?',
                prefixIcon: Assets.imagesCity,
                hintText: 'City',
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'FromWhich Airport are you gonna fly from?',
                prefixIcon: Assets.imagesAirPlane,
                hintText: 'Airport',
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'Please enter departure date',
                prefixIcon: Assets.imagesCalendarBlack,
                hintText: 'Departure date',
                iconSize: 15.98,
              ),
              MyTextField(
                labelText: 'Please enter departure time',
                hintText: 'Departure time',
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
                buttonIcon: Assets.imagesDeparture,
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
