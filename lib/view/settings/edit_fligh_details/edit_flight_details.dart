import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/settings/edit_fligh_details/edit_landing_details.dart';
import 'package:air_tinder/view/settings/edit_fligh_details/edit_layover_details.dart';
import 'package:air_tinder/view/settings/edit_fligh_details/edit_traveling_details.dart';
import 'package:air_tinder/view/widget/edit_flight_tiles.dart';
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
                    title:
                        'Flying from: ${fDetails.departureAirport} Airport, ${fDetails.departureCity}',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditTravellingDetails(),
                      ),
                    ),
                  ),
                  EditFlightTiles(
                    icon: Assets.imagesPlaneSolid,
                    title:
                        ' Layover at: ${fDetails.layoverAirport} Airport, ${fDetails.layoverCity}',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditLayoverDetails(),
                      ),
                    ),
                  ),
                  EditFlightTiles(
                    icon: Assets.imagesPlaneArrival,
                    title:
                        'Landing at: ${fDetails.landingAirport} Airport, ${fDetails.landingCity}',
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
