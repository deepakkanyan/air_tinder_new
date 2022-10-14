import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/model/chat_model/chat_room_model.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/widget/custom_dialog.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class BlockUserButton extends StatelessWidget {
  const BlockUserButton({
    Key? key,
    required this.targetUser,
    required this.cRM,
  }) : super(key: key);

  final ChatRoomModel cRM;
  final UserDetailModel targetUser;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: PopupMenuButton(
        icon: Image.asset(
          Assets.imagesMoreVert,
          height: 25.66,
        ),
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          maxWidth: 140,
        ),
        offset: Offset(-20, 35),
        itemBuilder: (context) {
          return <PopupMenuItem>[
            PopupMenuItem(
              child: Container(
                width: 140,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kSecondaryColor,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (_) {
                          return CustomDialog(
                            heading: 'Do you want to block this user?',
                            content:
                                'If you block them they will not be able to message you again.',
                            onNoTap: () => Navigator.pop(context),
                            onYesTap: () => chatProvider.blockUser(
                              context,
                              cRM,
                              targetUser,
                            ),
                          );
                        },
                      );
                    },
                    splashColor: kPrimaryColor.withOpacity(0.1),
                    highlightColor: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    child: Center(
                      child: MyText(
                        text: 'Block user',
                        size: 16,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              padding: EdgeInsets.zero,
            ),
          ];
        },
      ),
    );
  }
}
