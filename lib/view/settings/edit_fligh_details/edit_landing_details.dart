import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/flight_details/landing_details_provider.dart';
import 'package:air_tinder/view/widget/custom_date_picker.dart';
import 'package:air_tinder/view/widget/custom_time_picker.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditLandingDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LandingDetailsProvider(),
      child: Scaffold(
        appBar: simpleAppBar(
          context: context,
          title: 'Landing at',
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
                      Consumer<LandingDetailsProvider>(
                        builder: (context, provider, child) {
                          return MyTextField(
                            labelText: 'Which city is your destination?',
                            prefixIcon: Assets.imagesCity,
                            hintText: 'City',
                            controller: provider.cityCon,
                            iconSize: 15.11,
                            isAllWhite: true,
                          );
                        },
                      ),
                      Consumer<LandingDetailsProvider>(
                        builder: (context, provider, child) {
                          return MyTextField(
                            labelText: 'At which Airport are you gonna land?',
                            prefixIcon: Assets.imagesAirPlane,
                            hintText: 'Airport',
                            controller: provider.airportCon,
                            iconSize: 15.11,
                            isAllWhite: true,
                          );
                        },
                      ),
                      Consumer<LandingDetailsProvider>(
                        builder: (context, provider, child) {
                          return MyTextField(
                            labelText: 'Please enter landing date',
                            prefixIcon: Assets.imagesCalendarBlack,
                            hintText: 'Landing date',
                            iconSize: 15.98,
                            isReadOnly: true,
                            isAllWhite: true,
                            controller: provider.landingDateCon,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                builder: (_) {
                                  return CustomDatePicker(
                                    heading: 'Choose landing date',
                                    initialDateTime: provider.landingDate,
                                    onDateTimeChanged: (value) =>
                                        provider.onDateChanged(value),
                                    onDoneTap: () =>
                                        provider.setLandingDate(context),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      Consumer<LandingDetailsProvider>(
                        builder: (context, provider, child) {
                          return MyTextField(
                            labelText: 'Please enter landing time',
                            hintText: 'Landing time',
                            prefixIcon: Assets.imagesClock,
                            iconSize: 15.83,
                            isReadOnly: true,
                            isAllWhite: true,
                            controller: provider.landingTimeCon,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                builder: (_) {
                                  return CustomTimePicker(
                                    heading: 'Choose landing time',
                                    initialDateTime: provider.landingTime,
                                    onDateTimeChanged: (value) =>
                                        provider.onTimeChanged(value),
                                    onDoneTap: () =>
                                        provider.setLandingTime(context),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Consumer<LandingDetailsProvider>(
                  builder: (context, provider, child) {
                    return SimpleButton(
                      onTap: () => provider.uploadData(context, true),
                      height: 40,
                      buttonText: 'Save',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
