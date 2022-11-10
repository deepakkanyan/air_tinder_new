import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/flight_details/departure_details_provider.dart';
import 'package:air_tinder/view/widget/custom_date_picker.dart';
import 'package:air_tinder/view/widget/custom_time_picker.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepartureDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DepartureDetailsProvider(),
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
                  heading: 'Add your departure details',
                ),
                AuthSubHeading(
                  subHeading:
                      'Tell us from where you are flying from, lets make our travel fun together',
                ),
                Consumer<DepartureDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: 'Which city are you travelling from?',
                      prefixIcon: Assets.imagesCity,
                      hintText: 'City',
                      controller: provider.cityCon,
                      iconSize: 15.11,
                    );
                  },
                ),
                Consumer<DepartureDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: 'FromWhich Airport are you gonna fly from?',
                      prefixIcon: Assets.imagesAirPlane,
                      hintText: 'Airport',
                      controller: provider.airportCon,
                      iconSize: 15.11,
                    );
                  },
                ),
                Consumer<DepartureDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: 'Please enter departure date',
                      prefixIcon: Assets.imagesCalendarBlack,
                      hintText: 'Departure date',
                      iconSize: 15.98,
                      isReadOnly: true,
                      controller: provider.departureDateCon,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          builder: (_) {
                            return CustomDatePicker(
                              heading: 'Choose departure date',
                              initialDateTime: provider.departureDate,
                              onDateTimeChanged: (value) =>
                                  provider.onDateChanged(value),
                              onDoneTap: () =>
                                  provider.setDepartureDate(context),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                Consumer<DepartureDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: 'Please enter departure time',
                      hintText: 'Departure time',
                      prefixIcon: Assets.imagesClock,
                      iconSize: 15.83,
                      isReadOnly: true,
                      controller: provider.departureTimeCon,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          builder: (_) {
                            return CustomTimePicker(
                              heading: 'Choose departure time',
                              initialDateTime: provider.departureTime,
                              onDateTimeChanged: (value) =>
                                  provider.onTimeChanged(value),
                              onDoneTap: () =>
                                  provider.setDepartureTime(context),
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
                child: Consumer<DepartureDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyButton(
                      buttonIcon: Assets.imagesDeparture,
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
