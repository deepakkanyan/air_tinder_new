import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/settings/edit_fligh_details/edit_landing_details.dart';
import 'package:air_tinder/view/settings/edit_fligh_details/edit_layover_details.dart';
import 'package:air_tinder/view/settings/edit_fligh_details/edit_traveling_details.dart';
import 'package:air_tinder/view/widget/edit_flight_tiles.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          child: StreamBuilder(
            stream: profiles.doc(auth.currentUser!.uid).snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data!.data() != null) {
                  userDetailModel = UserDetailModel.fromJson(
                    snapshot.data!.data() as Map<String, dynamic>,
                  );
                  final String departureCity =
                      userDetailModel.departureDetails!['departureCity'];
                  final String departureAirport =
                      userDetailModel.departureDetails!['departureAirPort'];

                  final String layoverCity =
                      userDetailModel.layoverDetails!['layoverCity'];
                  final String layoverAirport =
                      userDetailModel.layoverDetails!['layoverAirPort'];

                  final String landingCity =
                      userDetailModel.landingDetails!['landingCity'];
                  final String landingAirport =
                      userDetailModel.landingDetails!['landingAirport'];
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      EditFlightTiles(
                        icon: Assets.imagesDeparture,
                        title:
                            'Flying from: $departureAirport Airport, $departureCity',
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
                            ' Layover at: $layoverAirport Airport, $layoverCity',
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
                            'Landing at: $landingAirport Airport, $landingCity',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditLandingDetails(),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return loadingWidget(context, color: kPrimaryColor);
                }
              } else {
                return loadingWidget(context, color: kPrimaryColor);
              }
            },
          ),
        ),
      ),
    );
  }
}
