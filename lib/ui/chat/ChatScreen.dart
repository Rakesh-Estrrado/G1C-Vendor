import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/chat/bloc/chat_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatBloc(context), child: ChatScreen());
  }

  final sendChatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar2(title: "Message"),
            SizedBox(height: 20),
            Container(
              width: 100.w,
              decoration: semiCircleBox(color: darkBlue, radius: 15),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reex',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      '+61 256 236 5621',
                      style: TextStyle(color: Colors.grey[500], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  _buildSentMessage("Hi!", "10:10"),
                  _buildSentMessage(
                      "Awesome, thanks for letting me know!\nCan't wait for my delivery. 🎉",
                      "10:11"),
                  _buildReceivedMessage(
                      "No problem at all!\nI'll be there in about 15 minutes.",
                      "10:11"),
                  _buildReceivedMessage(
                      "I'll text you when I arrive.", "10:11"),
                  _buildSentMessage("Great! 😊", "10:12"),
                ],
              ),
            ),
            _buildMessageInput(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSentMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE91775), Color(0xFFFD663B)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceivedMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: darkBlue200,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(width: 1, color: white.withOpacity(0.4)),
                color: darkBlue200),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: sendChatController,
                    textAlign: TextAlign.start,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Type a message ...",
                      counterText: "",
                      contentPadding: EdgeInsets.all(14.sp),
                      border: InputBorder.none,
                    ),
                    style: textStyleRegular,
                    onChanged: (value) {},
                  ),
                ),
                InkWell(
                  onTap: () =>
                      showSnackBar(context: context, msg: "Under Construction"),
                  child: CustomImageView(
                    imagePath: icCamera,
                    height: 24,
                    width: 24,
                  ),
                ),
                SizedBox(width: 16),
                InkWell(
                  onTap: () =>
                      showSnackBar(context: context, msg: "Under Construction"),
                  child: CustomImageView(
                    imagePath: icAttachment,
                    height: 24,
                    width: 24,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: CustomImageView(imagePath: icSendChat, height: 65, width: 65),
          ),
        ],
      ),
    );
  }
}
