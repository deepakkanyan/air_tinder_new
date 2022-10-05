import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/flight_details/landing_details_provider.dart';
import 'package:air_tinder/view/widget/custom_date_picker.dart';
import 'package:air_tinder/view/widget/custom_time_picker.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LandingDetailsProvider(),
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
                  heading: 'Please enter your landing details',
                ),
                AuthSubHeading(
                  subHeading:
                      'Tell us about where you are going, It will help us and other know more about your travel',
                ),
                Consumer<LandingDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: 'Which city is your destination?',
                      prefixIcon: Assets.imagesCity,
                      hintText: 'City',
                      controller: provider.cityCon,
                      iconSize: 15.11,
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
                              onDoneTap: () => provider.setLandingDate(context),
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
                              onDoneTap: () => provider.setLandingTime(context),
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
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 167,
                child: Consumer<LandingDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyButton(
                      buttonIcon: Assets.imagesPlaneArrival,
                      iconSize: 11.59,
                      onTap: () => provider.uploadData(context, false),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
