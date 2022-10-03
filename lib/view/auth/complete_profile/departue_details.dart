import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/widget/custom_date_picker.dart';
import 'package:air_tinder/view/widget/custom_time_picker.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DepartureDetails extends StatefulWidget {
  @override
  State<DepartureDetails> createState() => _DepartureDetailsState();
}

class _DepartureDetailsState extends State<DepartureDetails> {
  TextEditingController cityCon = TextEditingController();
  TextEditingController airportCon = TextEditingController();
  TextEditingController departureDateCon = TextEditingController();
  TextEditingController departureTimeCon = TextEditingController();
  DateTime departureDate = DateTime.now();
  DateTime departureTime = DateTime.now();

  bool get isValid {
    if (cityCon.text.isEmpty && cityCon.text == '') {
      showMsg(context, 'Please provide city name');
      return false;
    } else if (airportCon.text.isEmpty && airportCon.text == '') {
      showMsg(context, 'Please provide Airport name');
      return false;
    } else if (departureDateCon.text.isEmpty && departureDateCon.text == '') {
      showMsg(context, 'Please enter departure date');
      return false;
    } else if (departureTimeCon.text.isEmpty && departureTimeCon.text == '') {
      showMsg(context, 'Please enter departure time');
      return false;
    }
    return true;
  }

  Future<void> _uploadData() async {
    if (isValid) {
      try {
        loadingDialog(context);
        await profiles.doc(auth.currentUser!.uid).update({
          'departureDetails': {
            'departureCity': cityCon.text,
            'departureAirPort': airportCon.text,
            'departureDate': departureDateCon.text,
            'departureTime': departureTimeCon.text,
          },
        });
        Navigator.pop(context);
        Provider.of<GlobalProvider>(context, listen: false)
            .updateStackIndex(context, 4);
        cityCon.clear();
        airportCon.clear();
        departureDateCon.clear();
        departureTimeCon.clear();
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showMsg(context, e.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                controller: cityCon,
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'FromWhich Airport are you gonna fly from?',
                prefixIcon: Assets.imagesAirPlane,
                hintText: 'Airport',
                controller: airportCon,
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'Please enter departure date',
                prefixIcon: Assets.imagesCalendarBlack,
                hintText: 'Departure date',
                iconSize: 15.98,
                isReadOnly: true,
                controller: departureDateCon,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    builder: (_) {
                      return CustomDatePicker(
                        heading: 'Choose departure date',
                        initialDateTime: departureDate,
                        onDateTimeChanged: (value) {
                          setState(() {
                            departureDate = value;
                          });
                        },
                        onDoneTap: () {
                          setState(() {
                            departureDateCon.text = DateFormat.yMEd()
                                .format(departureDate)
                                .toString();
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
              MyTextField(
                labelText: 'Please enter departure time',
                hintText: 'Departure time',
                prefixIcon: Assets.imagesClock,
                iconSize: 15.83,
                isReadOnly: true,
                controller: departureTimeCon,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    builder: (_) {
                      return CustomTimePicker(
                        heading: 'Choose departure date',
                        initialDateTime: departureTime,
                        onDateTimeChanged: (value) {
                          setState(() {
                            departureTime = value;
                          });
                        },
                        onDoneTap: () {
                          setState(() {
                            departureTimeCon.text = DateFormat.jms()
                                .format(departureTime)
                                .toString();
                          });
                          Navigator.pop(context);
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
              child: MyButton(
                buttonIcon: Assets.imagesDeparture,
                iconSize: 11.59,
                onTap: _uploadData,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
