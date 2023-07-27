import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/chat/chat_page.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';
import 'package:nafcassete/src/widgets/custom_button.dart';
import 'package:nafcassete/src/widgets/custom_searchbar.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: customAppbar('Chat List', 0.0, const [SizedBox(),],const SizedBox()),
      body: RefreshIndicator(
        color: redCol,
        onRefresh: (){
          return Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              searchBarRow(),
              chatListWidget()
            ],
          ),
        ),
      ),
    );
  }

  searchBarRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomButton(
            ontap: () {},
            text: 'filter',
            prefixIcon: const SizedBox(),
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            buttonRadius: 25,
            bgColor: white,
            style: const TextStyle(
              color: Colors.grey
            ),
            borderColor: Colors.grey,
            elevation: 0.0,
            height: 40.0,
            width: 100.0,
          ),
          const SizedBox(width: 8.0),
          const Expanded(
            child: CustomSearchBar(
              backgroundColor: Color(0XFFE0E0E0),
            )
          ),
          const SizedBox(width: 8.0),
          const Text(
            'Search',
            style: TextStyle(
              color: Colors.blue
            ),
          )
        ],
      ),
    );
  }

  chatListWidget() {
     return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Get.to(() => const ChatPage(user: {
            "img": 'assets/images/logo.png',
             "name": "コーヒープレ ST WH : 17916",
             "subtitle" : "chat list sub-title"
          })),
          child: ListTile(
            leading: circleAvatar('assets/images/logo.png'),
            title: const Text(
              'コーヒープレ ST WH : 17916',
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0
              ),
            ),
            subtitle: const Text(
              'chat list sub-title',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0
              ),
            ),
            trailing: const Text(
              '5/15 12:24',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10.0
              ),
            ),
          ),
        );
      }
    );
  }

  circleAvatar(imgPath) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey, // Replace with your desired border color
          width: 2.0, // Replace with your desired border width
        ),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(imgPath), // Replace with your image path
      ),
    );
  }

}