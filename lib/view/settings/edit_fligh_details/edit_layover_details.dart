import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:flutter/material.dart';

class EditLayoverDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        context: context,
        title: 'Layover',
      ),
      body: Container(
        decoration: redBg,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  children: [
                    MyTextField(
                      labelText: 'In which city is the layover?',
                      prefixIcon: Assets.imagesCity,
                      hintText: 'City',
                      iconSize: 15.11,
                      isAllWhite: true,
                    ),
                    MyTextField(
                      labelText: 'At which Airport is the layover at?',
                      prefixIcon: Assets.imagesAirPlane,
                      hintText: 'Airport',
                      iconSize: 15.11,
                      isAllWhite: true,
                    ),
                    MyTextField(
                      labelText: 'Please enter landing date at the layover',
                      prefixIcon: Assets.imagesCalendarBlack,
                      hintText: 'Layover landing date',
                      iconSize: 15.98,
                      isAllWhite: true,
                    ),
                    MyTextField(
                      labelText: 'Please enter landing time at the layover',
                      hintText: 'Layover landing time',
                      prefixIcon: Assets.imagesClock,
                      iconSize: 15.83,
                      isAllWhite: true,
                    ),
                    MyTextField(
                      labelText: 'What is the stay time at the layover',
                      hintText: 'Layover stay time',
                      prefixIcon: Assets.imagesClock,
                      iconSize: 15.83,
                      isAllWhite: true,
                    ),
                  ],
                ),
              ),
              SimpleButton(
                onTap: () {},
                height: 40,
                buttonText: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
