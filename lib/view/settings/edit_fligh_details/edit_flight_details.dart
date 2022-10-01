import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/settings/edit_fligh_details/edit_landing_details.dart';
import 'package:air_tinder/view/settings/edit_fligh_details/edit_layover_details.dart';
import 'package:air_tinder/view/settings/edit_fligh_details/edit_traveling_details.dart';
import 'package:air_tinder/view/widget/edit_flight_tiles.dart';
import 'package:air_tinder/view/widget/icon_tiles.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:flutter/material.dart';

class EditFlightDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        context: context,
        title: 'Edit flight details',
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
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  EditFlightTiles(
                    icon: Assets.imagesDeparture,
                    title: 'Flying from: JFK Airport, New York',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditTravellingDetails(),
                      ),
                    ),
                  ),
                  EditFlightTiles(
                    icon: Assets.imagesPlaneSolid,
                    title: ' Layover at: London City Airport, London',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditLayoverDetails(),
                      ),
                    ),
                  ),
                  EditFlightTiles(
                    icon: Assets.imagesPlaneArrival,
                    title: 'Landing at: Dubai International Airport, Dubai',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditLandingDetails(),
                      ),
                    ),
                  ),
                ],
              ),
              SimpleButton(
                onTap: () {},
                height: 40,
                buttonText: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
