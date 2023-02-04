import 'dart:developer';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/flight_details/flight_number_details_provider.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/utils/amadeus_utility.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:air_tinder/view/widget/custom_date_picker.dart';
import 'package:air_tinder/view/widget/custom_time_picker.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  List<LayoverModel> layovers = [
    LayoverModel(),
  ];

  void updateLayovers({required int index,
    String? layoverLocation,
    DateTime? layover_date,
    DateTime? layoverStarttime,
    DateTime? layoverEndTime}) {
    layovers[index].layoverLocation = layoverLocation == null
        ? layovers[index].layoverLocation
        : layoverLocation;
    layovers[index].layover_date = layover_date == null ? layovers[index].layover_date : layover_date;
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
                        ...layovers
                            .asMap()
                            .entries
                            .map((layover) {
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
                        onTap: () => uploadDataNow(context, false)//uploadData(context,false),
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

  uploadSuccessfullyData() {
   /* Provider.of<GlobalProvider>(context, listen: false)
        .updateStackIndex(context, 4);*/

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => BottomNavBar(),
      ),
          (route) => false,
    );
  }

  Future<void> uploadDataNow(BuildContext context, bool isForEdit) async {
    loadingDialog(context);
    for (var i = 0; i < layovers.length; i++) {
      var element = layovers[i];
      if (element.layoverLocation == null) {
        Navigator.pop(context);
        showMsg(context, 'Please provide layover airport name');
      } else if (element.layover_date == null) {
        Navigator.pop(context);
        showMsg(context, 'Please enter layover landing date');
        break;
      } else if (element.layoverStarttime == null) {
        Navigator.pop(context);
        showMsg(context, 'Please enter layover start time');
        break;
      } else if (element.layoverEndTime == null) {
        Navigator.pop(context);
        showMsg(context, 'Please enter layover end time');
        break;
      } else {
        try {
          await profiles.doc(auth.currentUser!.uid).update({
            'layoverDetails': {
              'layoverCity': element.layoverLocation,
              'layoverAirPort': element.layoverLocation,
              'layoverLandingDate': element.layoverLocation,
              'layoverLandingTime': element.layoverStarttime,
              'layoverStayTime': element.layoverEndTime,
            },
          }).whenComplete(() {
            if(i==layovers.length-1){
              Navigator.pop(context);
              print("Profile Update Successfully !");
              isForEdit ? null : Provider.of<GlobalProvider>(context, listen: false).updateStackIndex(context, 6);
              isForEdit ? showMsg(context, 'Successfully Updated!', bgColor: kSuccessColor,) : null;
              uploadSuccessfullyData();
            }
          });

        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          showMsg(context, e.message.toString());
        }
      }
    }
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
  final TextEditingController layoverStartTimeController = TextEditingController();
  final TextEditingController layoverEndTimeController = TextEditingController();
  String selectedAirPort = "";

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
              selectedAirPort = selectedValue;
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
                        widget.updateThisLayover(
                            index: widget.index, layover_date: value);
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
                              widget.updateThisLayover(
                                  index: widget.index, layoverStarttime: value);
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
                            widget.updateThisLayover(
                                index: widget.index, layoverEndTime: value);
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
