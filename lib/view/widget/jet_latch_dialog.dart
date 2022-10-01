import 'dart:developer';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:flutter/material.dart';

class JetLatchPlusDialog extends StatefulWidget {
  const JetLatchPlusDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<JetLatchPlusDialog> createState() => _JetLatchPlusDialogState();
}

class _JetLatchPlusDialogState extends State<JetLatchPlusDialog> {
  final List<Map<String, dynamic>> plans = [
    {
      'duration': '12',
      'pricePerMonth': '4.99',
      'isDiscount': true,
      'discount': '67',
    },
    {
      'duration': '6',
      'pricePerMonth': '7.49',
      'isDiscount': false,
      'discount': '',
    },
    {
      'duration': '1',
      'pricePerMonth': '14.99',
      'isDiscount': false,
      'discount': '',
    },
  ];
  int planIndex = 0;

  void choosePlan(
      Map<String, dynamic> planData,
      int index,
      ) {
    setState(() {
      planIndex = index;
      log(planData.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Material(
            color: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        Assets.imagesRedBg,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MyText(
                        text: 'Get JetLatch Plus',
                        size: 18,
                        weight: FontWeight.w500,
                        color: kPrimaryColor,
                        align: TextAlign.center,
                        paddingBottom: 15,
                      ),
                      Image.asset(
                        Assets.imagesUpgrade,
                        height: 92,
                      ),
                      MyText(
                        paddingTop: 15,
                        text:
                        'Want to see more than 20 people per day? Upgrade to JetLatch Plus and see unlimited potential dating partners today.',
                        size: 12,
                        weight: FontWeight.w300,
                        align: TextAlign.center,
                        color: kPrimaryColor,
                        paddingBottom: 15,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    plans.length,
                        (index) {
                      var planData = plans[index];
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => choosePlan(
                            planData,
                            index,
                          ),
                          child: AnimatedContainer(
                            duration: Duration(
                              microseconds: 200000,
                            ),
                            height: 110,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: planIndex == index
                                    ? kSecondaryColor
                                    : Colors.transparent,
                                width: 2.0,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    MyText(
                                      text: planData['duration'],
                                      size: 22,
                                      weight: FontWeight.w500,
                                      color: planIndex == index
                                          ? kSecondaryColor
                                          : kTertiaryColor,
                                    ),
                                    MyText(
                                      text: 'months',
                                      size: 14,
                                      color: planIndex == index
                                          ? kSecondaryColor
                                          : kTertiaryColor,
                                    ),
                                  ],
                                ),
                                MyText(
                                  text: '\$${planData['pricePerMonth']}/mo',
                                  size: 12,
                                  weight: FontWeight.w700,
                                  color: planIndex == index
                                      ? kSecondaryColor
                                      : kTertiaryColor,
                                ),
                                planData['isDiscount'] == true
                                    ? MyText(
                                  text: 'Save${planData['discount']}\%',
                                  size: 12,
                                  weight: FontWeight.w300,
                                  color: planIndex == index
                                      ? kSecondaryColor
                                      : kTertiaryColor,
                                )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width(0.2, context),
                    vertical: 20,
                  ),
                  child: SimpleButton(
                    height: 40,
                    buttonText: 'Subscribe Now',
                    textColor: kSecondaryColor,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}