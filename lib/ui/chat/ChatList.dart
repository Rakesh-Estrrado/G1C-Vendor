import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/chat/ChatScreen.dart';
import 'package:g1c_vendor/ui/chat/bloc/chat_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/appBar.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatBloc(context), child: ChatList());
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      isAuth: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppBar(
              title: "Chat",
              showGlobe: false,
              makeTitleCenter: true),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () => navigateTo(
                      context: context,
                      destination: ChatScreen.builder(context),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: darkBlue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: dummyImage,
                            height: 50,
                            width: 50,
                            radius: BorderRadius.all(Radius.circular(100))),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Reex", style: textStyleSemiBold),
                                SizedBox(height: 5),
                                Text(
                                  "Thanks a bunch! Have a great day! 😊",
                                  style: textStyleRegular.copyWith(
                                    color: white.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "10:25",
                                style: textStyleRegular.copyWith(
                                  color: white.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(height: 5),
                              gradientContainer(
                                height: 20,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                  child: Center(
                                    child: Text("5", style: textStyleSemiBold),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}