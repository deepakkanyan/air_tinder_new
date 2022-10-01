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

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            ProfileImage(
              imgURL: Assets.imagesDummyMan,
              size: 180.0,
            ),
            MyText(
              paddingTop: 15,
              text: 'Jeremy Nelson',
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
              text: '25',
              size: 16,
              weight: FontWeight.w500,
              color: kPrimaryColor,
            ),
            IconTiles(
              icon: Assets.imagesDeparture,
              title: 'Flying from: JFK Airport, New York',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: IconTiles(
                icon: Assets.imagesPlaneSolid,
                title: ' Layover at: London City Airport, London',
              ),
            ),
            IconTiles(
              icon: Assets.imagesPlaneArrival,
              title: 'Landing at: Dubai International Airport, Dubai',
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
