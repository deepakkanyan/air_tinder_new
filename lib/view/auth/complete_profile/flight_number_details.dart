import 'dart:developer';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/flight_details/flight_number_details_provider.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/utils/amadeus_utility.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:air_tinder/view/widget/custom_date_picker.dart';
import 'package:air_tinder/view/widget/custom_time_picker.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../model/layover_model.dart';

class FlightNumberDetails extends StatefulWidget {
  FlightNumberDetails({Key? key}) : super(key: key);

  @override
  State<FlightNumberDetails> createState() => _FlightNumberDetailsState();
}

class _FlightNumberDetailsState extends State<FlightNumberDetails> {
  String airlineName = "";

  List<String> airlines = [
    "ABSA",
    "ANA All Nippon Cargo",
    "Adria Airways",
    "Aegean Airlines",
    "Aer Lingus Cargo",
    "AeroUnion",
    "Aeroflot",
    "Aeromexico Cargo",
    "Aeromexpress Cargo",
    "Aerosvit",
    "Africa West",
    "Air ALM",
    "Air Algerie",
    "Air Armenia",
    "Air Astana",
    "Air Baltic",
    "Air Canada",
    "Air China",
    "Air Europa Cargo",
    "Air France",
    "Air Greenland",
    "Air Hong Kong",
    "Air India",
    "Air Jamaica",
    "Air Macau",
    "Air Madagascar",
    "Air Malta",
    "Air Mauritius",
    "Air Moldova",
    "Air New Zealand",
    "Air Niugini",
    "Air Seychelles",
    "AirBridge Cargo",
    "Alaska Airlines",
    "Alitalia",
    "American Airlines",
    "Amerijet International",
    "Arrow Air",
    "Asiana Airlines",
    "Atlantic Southeast Airlines",
    "Atlas Air",
    "Austrian Cargo",
    "Avient",
    "Azerbaijan Airlines",
    "Biman Bangladesh",
    "British Airways",
    "British Midland Airways",
    "Brussels Airlines",
    "Bulgaria Air",
    "Buraq Air Transport (Arabic only)",
    "CAL Cargo Air Lines",
    "Cameroon Airlines",
    "Canadian Airlines Int'l",
    "CargoItalia (alternate)",
    "Cargolux Airlines",
    "Cargolux Italia",
    "Caribbean Airlines",
    "Cathay Pacific Airways",
    "Cayman Airways",
    "Centurion Air Cargo",
    "China Airlines",
    "China Cargo Airlines",
    "China Eastern Airlines",
    "China Southern Airlines",
    "Cielos Airlines",
    "Comair",
    "Condor Flugdienst",
    "Continental Airlines",
    "Copa Airlines Cargo",
    "Coyne Airways",
    "Croatia Airlines",
    "Cyprus Airways",
    "Czech Airlines",
    "DHL Aviation / European Air Transport",
    "DHL Aviation/DHL Airways",
    "Delta Air Lines",
    "Dragonair",
    "EL ALLY, ETIHAD Airways",
    "Egyptair",
    "Emirates",
    "Estonian Air",
    "Ethiopian Airlines",
    "Eva Airways",
    "Far Eastern Air Transport",
    "Fedex",
    "Finnair",
    "Florida West International Airways",
    "Garuda Indonesia",
    "Global Aviation and Services",
    "Grandstar Cargo",
    "Great Wall Airlines",
    "Gulf Air",
    "Hainan Airlines (Chinese)",
    "Hong Kong Airlines",
    "Iberia",
    "Icelandair",
    "Indian Airlines",
    "Insel Air Cargo",
    "Iran Air",
    "JAT Airways",
    "Jade Cargo International",
    "Japan Air System",
    "Japan Airlines",
    "Jet Airways",
    "KD Avia",
    "KLM Cargo",
    "Kalitta Air",
    "Kenya Airways",
    "Kingfisher Airlines",
    "Korean Air",
    "Kuwait Airways",
    "LACSA Airlines of Costa Rica",
    "LAN Chile",
    "LIAT Airlines",
    "LOT Polish Airlines",
    "LTU (Leisure Cargo)",
    "Lauda Air",
    "Libyan Airlines",
    "Lufthansa Cargo AG",
    "MASAir",
    "MNG Airlines",
    "Malaysian Airline System",
    "Malev Hungarian Airlines",
    "Mandarin Airlines",
    "Mario's Air",
    "Martinair Cargo",
    "Middle East Airlines",
    "National Air Cargo",
    "Nippon Cargo Airlines",
    "Northern Air Cargo",
    "Northwest Airlines (alternate site)",
    "Olympic Airways",
    "Pakistan Int'l Airlines",
    "Philippine Airlines",
    "Polar Air Cargo",
    "Qantas Airways",
    "Qatar Airways",
    "Royal Air Maroc",
    "Royal Brunei Airlines",
    "Royal Jordanian",
    "SAC South American Airways",
    "SAS-Scandinavian Airlines System",
    "SATA Air Acores",
    "Saudi Arabian Airlines",
    "Shandong Airlines (Chinese)",
    "Shanghai Airlines Cargo",
    "Shanghai Airlines",
    "Shenzhen Airlines (Chinese)",
    "Siberia Airlines",
    "Sichuan Airlines",
    "Singapore Airlines",
    "Sky West Airlines",
    "South African Airways",
    "Southwest Airlines",
    "SriLankan Cargo",
    "Sun Express",
    "Swiss",
    "Syrian Arab Airlines",
    "TAAG Angola Airlines",
    "TAB Cargo",
    "TACA",
    "TAM Brazilian Airlines",
    "TAP Air Portugal",
    "TNT Airways",
    "Tampa Airlines",
    "Thai Airways",
    "Trans Mediterranean Airways",
    "Turkish Airlines",
    "UPS Air Cargo",
    "USAirways",
    "Ukraine Int'l Airlines",
    "United Airlines Cargo",
    "VARIG Brazilian Airlines",
    "Vietnam Airlines",
    "Virgin Atlantic",
    "Xiamen Airlines",
    "Yangtze River Express Airlines",
    "Yemenia Yemen Airways",
    "more AWB tracking"
  ];

  List<LayoverModel> layovers = [
    LayoverModel(),
  ];

  void updateLayovers(
      {required int index,
      String? layoverLocation,
      DateTime? layover_date,
      DateTime? layoverStarttime,
      DateTime? layoverEndTime}) {
    layovers[index].layoverLocation = layoverLocation == null
        ? layovers[index].layoverLocation
        : layoverLocation;
    layovers[index].layover_date =
        layover_date == null ? layovers[index].layover_date : layover_date;
    layovers[index].layoverStarttime = layoverStarttime == null
        ? layovers[index].layoverStarttime
        : layoverStarttime;
    layovers[index].layoverEndTime = layoverEndTime == null
        ? layovers[index].layoverEndTime
        : layoverEndTime;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AmadeusUtility.getAmadeusAuthKey();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FlightNumberDetailsProvider(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ElevatedButton(
          //   onPressed: () async {
          //     await AmadeusUtility.getAmadeusAuthKey();
          //     await AmadeusUtility.getAmadeusAirports('New');
          //   },
          //   child: Text('Get'),
          // ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                AuthHeading(heading: "Please enter your flight details"),
                AuthSubHeading(
                    subHeading:
                        "Tell us about the flight and layover. We can't wait to hear that. Let's get you to the best layover of your life."),
                Consumer<FlightNumberDetailsProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...layovers.asMap().entries.map((layover) {
                          return LayoverInputWidget(
                              layover.key, updateLayovers);
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: layovers.length > 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (layovers.length >= 2) {
                                  layovers.removeLast();
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset(
                                Assets.circleMinusSolid,
                                height: 18.11,
                                color: kSecondaryColor,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (layovers.length <= 2) {
                                layovers.add(
                                  LayoverModel(),
                                );
                              } else {
                                showMsg(context,
                                    'A maximum of three layovers can be added!');
                              }
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              Assets.circlePlusSolid,
                              height: 18.11,
                              color: kSecondaryColor,
                            ),
                          ),
                        ),

                        // DropdownButtonFormField(
                        //     decoration: InputDecoration(
                        //       prefixIcon: Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Image.asset(
                        //             Assets.imagesAirPlane,
                        //             height: 15.11,
                        //           ),
                        //         ],
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide(color: kTertiaryColor, width: 1.0),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide(
                        //           color: kSecondaryColor,
                        //           width: 1.0,
                        //         ),
                        //       ),
                        //       contentPadding: EdgeInsets.symmetric(
                        //         horizontal: 15,
                        //       ),
                        //     ),
                        //     items: provider.airlines.values
                        //         .toList()
                        //         .map(
                        //           (e) => DropdownMenuItem(value: e, child: Text(e)),
                        //         )
                        //         .toList(),
                        //     // items: [
                        //     //   DropdownMenuItem(
                        //     //     value: "abc",
                        //     //     child: Text("abc"),
                        //     //   )
                        //     // ],
                        //     onChanged: (value) {
                        //       //provider.selectedAirline = value.toString();
                        //     }),
                      ],
                    );
                  },
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 167,
                      child: MyButton(
                        onTap: () => uploadData(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  uploadData() {
    Provider.of<GlobalProvider>(context, listen: false)
        .updateStackIndex(context, 4);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => BottomNavBar(),
      ),
      (route) => false,
    );
  }
}

class LayoverInputWidget extends StatefulWidget {
  final int index;
  final Function(
      {required int index,
      String? layoverLocation,
      DateTime? layover_date,
      DateTime? layoverStarttime,
      DateTime? layoverEndTime}) updateThisLayover;

  @override
  LayoverInputWidget(this.index, this.updateThisLayover);

  @override
  State<LayoverInputWidget> createState() => _LayoverInputWidgetState();
}

class _LayoverInputWidgetState extends State<LayoverInputWidget> {
  final TextEditingController layoverDateController = TextEditingController();
  final TextEditingController layoverStartTimeController =
      TextEditingController();
  final TextEditingController layoverEndTimeController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    layoverDateController.text = DateFormat.yMMMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Autocomplete<String>(
            fieldViewBuilder:
                (context, controller, focusNode, onEditingComplete) {
              return MyTextField(
                labelText: "Where is the layover?",
                prefixIcon: Assets.imagesCity,
                hintText: 'Layover',
                controller: controller,
                focusNode: focusNode,
                onEditingComplete: onEditingComplete,
                iconSize: 15.11,
              );
            },
            optionsBuilder: (TextEditingValue textEditingValue) async {
              List<String> airports = await AmadeusUtility.getAmadeusAirports(
                  textEditingValue.text);
              if (textEditingValue.text == '') {
                return [];
              }
              return airports;
            },
            onSelected: (String selectedValue) {
              widget.updateThisLayover(
                  index: widget.index, layoverLocation: selectedValue);
            },
          ),
          MyTextField(
            controller: layoverDateController,
            labelText: 'Layover date',
            prefixIcon: Assets.imagesCalendarBlack,
            hintText: 'Layover landing date',
            iconSize: 15.98,
            isReadOnly: true,
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                elevation: 0,
                builder: (_) {
                  return CustomDatePicker(
                    heading: 'Choose layover landing date',
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (value) {
                      setState(() {
                        layoverDateController.text =
                            DateFormat.yMMMd().format(value);
                      });
                    },
                    onDoneTap: () {
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              'Layover time',
              style: TextStyle(
                color: kTertiaryColor,
                fontSize: 16,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: MyTextField(
                    haveLabel: false,
                    prefixIcon: Assets.imagesClock,
                    hintText: '7 AM',
                    fontSize: 11,
                    iconSize: 15.98,
                    isReadOnly: true,
                    controller: layoverStartTimeController,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        builder: (_) {
                          return CustomTimePicker(
                            heading: 'Choose layover landing time',
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (value) {
                              layoverStartTimeController.text =
                                  DateFormat.jm().format(value);
                            },
                            onDoneTap: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    }),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'TO',
                  style: TextStyle(
                    color: kTertiaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: MyTextField(
                  controller: layoverEndTimeController,
                  haveLabel: false,
                  prefixIcon: Assets.imagesClock,
                  hintText: '9 AM',
                  iconSize: 15.98,
                  fontSize: 11,
                  isReadOnly: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      builder: (_) {
                        return CustomTimePicker(
                          heading: 'Choose layover landing time',
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (value) {
                            layoverEndTimeController.text =
                                DateFormat.jm().format(value);
                          },
                          onDoneTap: () {
                            Navigator.pop(context);
                          },
                        );
                      },
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
