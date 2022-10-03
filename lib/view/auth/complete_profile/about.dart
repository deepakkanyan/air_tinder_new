import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/widget/headings.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class About extends StatefulWidget {
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final TextEditingController aboutCon = TextEditingController();

  Future<void> _uploadData() async {
    if (aboutCon.text.isEmpty && aboutCon.text == '') {
      showMsg(context, 'Field cannot be empty!');
    } else {
      try {
        loadingDialog(context);
        await profiles.doc(auth.currentUser!.uid).update({
          'about': aboutCon.text,
        });
        Navigator.pop(context);
        Provider.of<GlobalProvider>(context, listen: false)
            .updateStackIndex(context, 3);
        aboutCon.clear();
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
                controller: aboutCon,
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
                onTap: _uploadData,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
