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

class LayoverDetails extends StatefulWidget {
  @override
  State<LayoverDetails> createState() => _LayoverDetailsState();
}

class _LayoverDetailsState extends State<LayoverDetails> {
  TextEditingController cityCon = TextEditingController();
  TextEditingController airportCon = TextEditingController();
  TextEditingController landingDateCon = TextEditingController();
  TextEditingController landingTimeCon = TextEditingController();
  TextEditingController stayCon = TextEditingController();
  DateTime landingDate = DateTime.now();
  DateTime landingTime = DateTime.now();
  DateTime stayTime = DateTime.now();

  bool get isValid {
    if (cityCon.text.isEmpty && cityCon.text == '') {
      showMsg(context, 'Please provide layover city name');
      return false;
    } else if (airportCon.text.isEmpty && airportCon.text == '') {
      showMsg(context, 'Please provide layover airport name');
      return false;
    } else if (landingDateCon.text.isEmpty && landingDateCon.text == '') {
      showMsg(context, 'Please enter layover landing date');
      return false;
    } else if (landingTimeCon.text.isEmpty && landingTimeCon.text == '') {
      showMsg(context, 'Please enter layover landing time');
      return false;
    } else if (stayCon.text.isEmpty && stayCon.text == '') {
      showMsg(context, 'Please enter layover stay time');
      return false;
    }
    return true;
  }

  Future<void> _uploadData() async {
    if (isValid) {
      try {
        loadingDialog(context);
        await profiles.doc(auth.currentUser!.uid).update({
          'layoverDetails': {
            'layoverCity': cityCon.text,
            'layoverAirPort': airportCon.text,
            'layoverLandingDate': landingDateCon.text,
            'layoverLandingTime': landingTimeCon.text,
            'layoverStayTime': landingTimeCon.text,
          },
        });
        Navigator.pop(context);
        Provider.of<GlobalProvider>(context, listen: false)
            .updateStackIndex(context, 5);
        cityCon.clear();
        airportCon.clear();
        landingDateCon.clear();
        landingTimeCon.clear();
        stayCon.clear();
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
                heading: 'Please enter your layover details',
              ),
              AuthSubHeading(
                subHeading:
                    'Tell us about the layover. We can\'t wait to hear that. This is where the magic happens. Lets get you to the best layover of your life.',
              ),
              MyTextField(
                labelText: 'In which city is the layover?',
                prefixIcon: Assets.imagesCity,
                hintText: 'City',
                controller: cityCon,
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'At which Airport is the layover at?',
                prefixIcon: Assets.imagesAirPlane,
                hintText: 'Airport',
                controller: airportCon,
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'Please enter landing date at the layover',
                prefixIcon: Assets.imagesCalendarBlack,
                hintText: 'Layover landing date',
                iconSize: 15.98,
                isReadOnly: true,
                controller: landingDateCon,
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    builder: (_) {
                      return CustomDatePicker(
                        heading: 'Choose layover landing date',
                        initialDateTime: landingDate,
                        onDateTimeChanged: (value) {
                          setState(() {
                            landingDate = value;
                          });
                        },
                        onDoneTap: () {
                          setState(() {
                            landingDateCon.text = DateFormat.yMEd()
                                .format(landingDate)
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
                labelText: 'Please enter landing time at the layover',
                hintText: 'Layover landing time',
                prefixIcon: Assets.imagesClock,
                iconSize: 15.83,
                isReadOnly: true,
                controller: landingTimeCon,
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    builder: (_) {
                      return CustomTimePicker(
                        heading: 'Choose layover landing time',
                        initialDateTime: landingTime,
                        onDateTimeChanged: (value) {
                          setState(() {
                            landingTime = value;
                          });
                        },
                        onDoneTap: () {
                          setState(() {
                            landingTimeCon.text = DateFormat.yMEd()
                                .format(landingTime)
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
                labelText: 'What is the stay time at the layover',
                hintText: 'Layover stay time',
                prefixIcon: Assets.imagesClock,
                iconSize: 15.83,
                isReadOnly: true,
                controller: stayCon,
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    builder: (_) {
                      return CustomTimePicker(
                        heading: 'Choose layover stay time',
                        initialDateTime: stayTime,
                        onDateTimeChanged: (value) {
                          setState(() {
                            stayTime = value;
                          });
                        },
                        onDoneTap: () {
                          setState(() {
                            stayCon.text = DateFormat.yMEd()
                                .format(stayTime)
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
                buttonIcon: Assets.imagesPlaneSolid,
                iconSize: 14.56,
                onTap: _uploadData,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
