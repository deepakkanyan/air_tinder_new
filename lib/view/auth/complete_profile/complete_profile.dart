import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/view/auth/complete_profile/about.dart';
import 'package:air_tinder/view/auth/complete_profile/add_photos.dart';
import 'package:air_tinder/view/auth/complete_profile/departue_details.dart';
import 'package:air_tinder/view/auth/complete_profile/flight_number_details.dart';
import 'package:air_tinder/view/auth/complete_profile/interest.dart';
import 'package:air_tinder/view/auth/complete_profile/landing_details.dart';
import 'package:air_tinder/view/auth/complete_profile/layover_details.dart';
import 'package:air_tinder/view/widget/custom_container.dart';
import 'package:air_tinder/view/widget/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompleteProfile extends StatelessWidget {
  final List<Widget> children = [
    AddPhotos(),
    Interest(),
    About(),
    FlightNumberDetails(),
    // DepartureDetails(),
    // LayoverDetails(),
    // LandingDetails(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: transparentAppBar(context: context),
      body: Container(
        decoration: bgImage,
        child: CustomContainer(
          child: IndexedStack(
            index: provider.stackIndex,
            children: children,
          ),
        ),
      ),
    );
  }
}
