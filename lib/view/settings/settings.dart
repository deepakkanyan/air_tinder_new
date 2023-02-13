import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/settings/edit_fligh_details/edit_flight_details.dart';
import 'package:air_tinder/view/settings/edit_profile.dart';
import 'package:air_tinder/view/splash_screen/splash_screen.dart';
import 'package:air_tinder/view/widget/icon_tiles.dart';
import 'package:air_tinder/view/widget/jet_latch_dialog.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/profile_image.dart';
import 'package:air_tinder/view/widget/settings_action_tiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    setState(() {
      profileImageUrl = '';
    //  departureCity = userDetailModel.departureDetails?['departureCity'];
   //   departureAirport = userDetailModel.departureDetails?['departureAirPort'];
      layoverCity = userDetailModel.layoverDetails?['layoverCity'] ?? "";
      layoverAirport = userDetailModel.layoverDetails?['layoverAirPort']?? "";
      landingCity = userDetailModel.landingDetails?['landingCity']?? "";
      landingAirport = userDetailModel.landingDetails?['landingAirport']?? "";
    });
  }

  String profileImageUrl = '';
  //String departureCity = '';
  //String departureAirport = '';
  String layoverCity = '';
  String layoverAirport = '';
  String landingCity = '';
  String landingAirport = '';
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // final int age = int.parse(userDetailModel.dateOfBirth!.substring(11, 15)) -
    //     int.parse(currentDate.toString().substring(0, 4));
    return Scaffold(
      body: Container(
        decoration: redBg,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3.0,
                    color: kPrimaryColor,
                  ),
                ),
                child: ProfileImage(
                  imgURL: userDetailModel.profileImgUrl!,
                  size: 170.0,
                  loadingColor: kPrimaryColor,
                ),
              ),
            ),
            MyText(
              paddingTop: 15,
              text: userDetailModel.fullName,
              size: 25,
              weight: FontWeight.w500,
              color: kPrimaryColor,
              paddingBottom: 8,
            ),
            Row(
              children: [
                MyText(
                  text: 'Free plan, ',
                  size: 14,
                  weight: FontWeight.w300,
                  color: kPrimaryColor,
                ),
                MyText(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return JetLatchPlusDialog();
                      },
                    );
                  },
                  text: ' Upgrade now!',
                  size: 14,
                  decoration: TextDecoration.underline,
                  weight: FontWeight.w700,
                  color: Color(0xffFFDD00),
                ),
              ],
            ),
            MyText(
              paddingTop: 10,
              paddingBottom: 8,
              text: age.isNegative ? age.toString().substring(1, 3) : age,
              size: 16,
              weight: FontWeight.w500,
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 15,
            ),
          /*  IconTiles(
              icon: Assets.imagesDeparture,
              title: 'Flying from: $departureAirport Airport, $departureCity',
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: IconTiles(
                icon: Assets.imagesPlaneSolid,
                title: ' Layover at: $layoverAirport Airport, $layoverCity',
              ),
            ),
            IconTiles(
              icon: Assets.imagesPlaneArrival,
              title: 'Landing at: $landingAirport Airport, $landingCity',
            ),
            MyText(
              paddingTop: 15,
              paddingBottom: 10,
              text: 'Settings',
              size: 16,
              weight: FontWeight.w500,
              color: kPrimaryColor,
            ),
            SettingsActionTiles(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfile(),
                ),
              ),
              icon: Assets.imagesEdit,
              title: 'Edit profile',
            ),
            SettingsActionTiles(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditFlightDetails(),
                ),
              ),
              icon: Assets.imagesAirplanetop,
              title: 'Edit flight details',
            ),
            SettingsActionTiles(
              onTap: () {
                auth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SplashScreen(),
                  ),
                  (route) => route.isFirst,
                );
              },
              icon: Assets.imagesLogout,
              title: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
