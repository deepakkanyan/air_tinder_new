import 'dart:developer';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/flight_details/flight_number_details_provider.dart';
import 'package:air_tinder/view/widget/custom_date_picker.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightNumberDetails extends StatefulWidget {
  FlightNumberDetails({Key? key}) : super(key: key);

  @override
  State<FlightNumberDetails> createState() => _FlightNumberDetailsState();
}

class _FlightNumberDetailsState extends State<FlightNumberDetails> {
  String airlineName = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FlightNumberDetailsProvider(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                AuthHeading(heading: "Add your flight details"),
                AuthSubHeading(
                    subHeading:
                        "Add your flight number so that we can pull up information"),
                Consumer<FlightNumberDetailsProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "Please select your airline",
                          size: 16,
                          color: kTertiaryColor,
                          paddingBottom: 5,
                        ),
                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Assets.imagesAirPlane,
                                    height: 15.11,
                                  ),
                                ],
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: kTertiaryColor, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: kSecondaryColor,
                                  width: 1.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                            ),
                            items: provider.airlines.values
                                .toList()
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: "abc",
                                    child: Text("abc"),
                                  ),
                                )
                                .toList(),
                            // items: [
                            //   DropdownMenuItem(
                            //     value: "abc",
                            //     child: Text("abc"),
                            //   )
                            // ],
                            onChanged: (value) {
                              //provider.selectedAirline = value.toString();
                            }),
                      ],
                    );
                  },
                ),
                Consumer<FlightNumberDetailsProvider>(
                  builder: (context, provider, child) {
                    return MyTextField(
                      labelText: "Please enter your flight number",
                      prefixIcon: Assets.imagesAirPlane,
                      hintText: 'AirLine',
                      controller: provider.airlineCon,
                      iconSize: 15.11,
                    );
                  },
                ),
                Consumer<FlightNumberDetailsProvider>(
                    builder: (context, provider, child) {
                  return MyTextField(
                    labelText: "Please enter departure date",
                    prefixIcon: Assets.imagesCalendarBlack,
                    hintText: 'Depature date',
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
                                initialDateTime: provider.departureDate,
                                onDateTimeChanged: (value) {
                                  provider.onDepartureDateChanged(value);
                                },
                                heading: "Choose departure date",
                                onDoneTap: () {
                                  provider.onDepartureDateDoneTapped();
                                });
                          });
                    },
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
