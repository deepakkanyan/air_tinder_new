import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/flight_details/layover_details_provider.dart';
import 'package:air_tinder/view/widget/custom_date_picker.dart';
import 'package:air_tinder/view/widget/custom_time_picker.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayoverDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LayoverDetailsProvider(),
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
                  heading: 'Please enter your layover details',
                ),
                AuthSubHeading(
                  subHeading:
                      'Tell us about the layover. We can\'t wait to hear that. This is where the magic happens. Lets get you to the best layover of your life.',
                ),
                Consumer<LayoverDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: 'In which city is the layover?',
                      prefixIcon: Assets.imagesCity,
                      hintText: 'City',
                      controller: provider.cityCon,
                      iconSize: 15.11,
                    );
                  },
                ),
                Consumer<LayoverDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: 'At which Airport is the layover at?',
                      prefixIcon: Assets.imagesAirPlane,
                      hintText: 'Airport',
                      controller: provider.airportCon,
                      iconSize: 15.11,
                    );
                  },
                ),
                Consumer<LayoverDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: 'Please enter landing date at the layover',
                      prefixIcon: Assets.imagesCalendarBlack,
                      hintText: 'Layover landing date',
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
                              heading: 'Choose layover landing date',
                              initialDateTime: provider.landingDate,
                              onDateTimeChanged: (value) =>
                                  provider.onLandingDateChanged(value),
                              onDoneTap: () =>
                                  provider.setLayOverLandingDate(context),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                Consumer<LayoverDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: 'Please enter landing time at the layover',
                      hintText: 'Layover landing time',
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
                              heading: 'Choose layover landing time',
                              initialDateTime: provider.landingTime,
                              onDateTimeChanged: (value) =>
                                  provider.onLandingTimeChanged(value),
                              onDoneTap: () => provider.setLandingTime(context),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                Consumer<LayoverDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: 'What is the stay time at the layover',
                      hintText: 'Layover stay time',
                      prefixIcon: Assets.imagesClock,
                      iconSize: 15.83,
                      isReadOnly: true,
                      controller: provider.stayCon,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          builder: (_) {
                            return CustomTimePicker(
                              heading: 'Choose layover stay time',
                              initialDateTime: provider.stayTime,
                              onDateTimeChanged: (value) =>
                                  provider.onStayTimeChanged(value),
                              onDoneTap: () => provider.setStayTime(context),
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
                child: Consumer<LayoverDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyButton(
                      buttonIcon: Assets.imagesPlaneSolid,
                      iconSize: 14.56,
                      onTap: () => provider.uploadData(context,false),
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
