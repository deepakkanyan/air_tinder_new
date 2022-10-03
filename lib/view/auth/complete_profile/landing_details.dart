import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/auth_provider/auth_provider.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LandingDetails extends StatefulWidget {
  @override
  State<LandingDetails> createState() => _LandingDetailsState();
}

class _LandingDetailsState extends State<LandingDetails> {
  TextEditingController cityCon = TextEditingController();

  TextEditingController airportCon = TextEditingController();

  TextEditingController landingDateCon = TextEditingController();

  TextEditingController landingTimeCon = TextEditingController();

  DateTime landingDate = DateTime.now();

  DateTime landingTime = DateTime.now();

  bool get isValid {
    if (cityCon.text.isEmpty && cityCon.text == '') {
      showMsg(context, 'Please provide city name');
      return false;
    } else if (airportCon.text.isEmpty && airportCon.text == '') {
      showMsg(context, 'Please provide Airport name');
      return false;
    } else if (landingDateCon.text.isEmpty && landingDateCon.text == '') {
      showMsg(context, 'Please enter landing date');
      return false;
    } else if (landingTimeCon.text.isEmpty && landingTimeCon.text == '') {
      showMsg(context, 'Please enter landing time');
      return false;
    }
    return true;
  }

  Future<void> _uploadData() async {
    if (isValid) {
      try {
        loadingDialog(context);
        await profiles.doc(auth.currentUser!.uid).update({
          'landingDetails': {
            'landingCity': cityCon.text,
            'landingAirport': airportCon.text,
            'landingDate': landingDateCon.text,
            'landingTime': landingTimeCon.text,
          },
        });
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => BottomNavBar(),
          ),
          (route) => false,
        );
        Provider.of<GlobalProvider>(context, listen: false)
            .updateStackIndex(context, 0);
        cityCon.clear();
        airportCon.clear();
        landingDateCon.clear();
        landingTimeCon.clear();
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
                heading: 'Please enter your landing details',
              ),
              AuthSubHeading(
                subHeading:
                    'Tell us about where you are going, It will help us and other know more about your travel',
              ),
              MyTextField(
                labelText: 'Which city is your destination?',
                prefixIcon: Assets.imagesCity,
                hintText: 'City',
                controller: cityCon,
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'At which Airport are you gonna land?',
                prefixIcon: Assets.imagesAirPlane,
                hintText: 'Airport',
                controller: airportCon,
                iconSize: 15.11,
              ),
              MyTextField(
                labelText: 'Please enter landing date',
                prefixIcon: Assets.imagesCalendarBlack,
                hintText: 'Landing date',
                iconSize: 15.98,
                isReadOnly: true,
                controller: landingDateCon,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    builder: (_) {
                      return CustomDatePicker(
                        heading: 'Choose departure date',
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
                labelText: 'Please enter landing time',
                hintText: 'Landing time',
                prefixIcon: Assets.imagesClock,
                iconSize: 15.83,
                isReadOnly: true,
                controller: landingTimeCon,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    builder: (_) {
                      return CustomTimePicker(
                        heading: 'Choose departure date',
                        initialDateTime: landingTime,
                        onDateTimeChanged: (value) {
                          setState(() {
                            landingTime = value;
                          });
                        },
                        onDoneTap: () {
                          setState(() {
                            landingTimeCon.text =
                                DateFormat.jms().format(landingTime).toString();
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
                buttonIcon: Assets.imagesPlaneArrival,
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
