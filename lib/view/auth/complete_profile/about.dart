import 'package:air_tinder/provider/auth_provider/auth_provider.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
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
                heading: 'Tell us about yourself',
              ),
              AuthSubHeading(
                subHeading:
                    'Add some bio about yourself, you can write about your work, education or which movies you like. The people you meet on the app can read this.',
              ),
              MyTextField(
                havePrefix: false,
                haveLabel: false,
                maxLines: 18,
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
                onTap: () => provider.updateStackIndex(context, 3),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


