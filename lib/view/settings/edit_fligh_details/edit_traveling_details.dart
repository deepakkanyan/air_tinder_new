import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/flight_details/departure_details_provider.dart';
import 'package:air_tinder/view/widget/custom_date_picker.dart';
import 'package:air_tinder/view/widget/custom_time_picker.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTravellingDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DepartureDetailsProvider(),
      child: Scaffold(
        appBar: simpleAppBar(
          context: context,
          title: 'Travelling from',
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
                      Consumer<DepartureDetailsProvider>(
                        builder: (context, provider, child) {
                          return MyTextField(
                            labelText: 'Which city are you travelling from?',
                            prefixIcon: Assets.imagesCity,
                            hintText: 'City',
                            controller: provider.cityCon,
                            isAllWhite: true,
                            iconSize: 15.11,
                          );
                        },
                      ),
                      Consumer<DepartureDetailsProvider>(
                        builder: (context, provider, child) {
                          return MyTextField(
                            labelText:
                                'FromWhich Airport are you gonna fly from?',
                            prefixIcon: Assets.imagesAirPlane,
                            hintText: 'Airport',
                            isAllWhite: true,
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
                            isAllWhite: true,
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
                            isAllWhite: true,
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
                Consumer<DepartureDetailsProvider>(
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
