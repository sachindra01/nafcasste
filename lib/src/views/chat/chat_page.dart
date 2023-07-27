import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafcassete/src/helpers/styles.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.user});
  // ignore: prefer_typing_uninitialized_variables
  final user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController msgCon = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List messages = [
    {
      'from': 'me',
      'message' : 'HI', 
      'time' : '12:34'
    },
    {
      'from': 'other',
      'message' : 'Hello', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'how you doing', 
      'time' : '12:34'
    },
    {
      'from': 'other',
      'message' : 'Fine, hey I heard about that, is it true? did it really happen', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'which one? ', 
      'time' : '12:34'
    },
    {
      'from': 'other',
      'message' : 'i think you know', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'ohhh, i know what you are talking about', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'HI', 
      'time' : '12:34'
    },
    {
      'from': 'other',
      'message' : 'Hello', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'HI', 
      'time' : '12:34'
    },
    {
      'from': 'other',
      'message' : 'Fine, hey I heard about that, is it true? did it really happen', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'which one? ', 
      'time' : '12:34'
    },
    {
      'from': 'other',
      'message' : 'i think you know', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'ohhh, i know what you are talking about', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'HI', 
      'time' : '12:34'
    },
    {
      'from': 'other',
      'message' : 'Hello', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'HI', 
      'time' : '12:34'
    },
    {
      'from': 'other',
      'message' : 'Fine, hey I heard about that, is it true? did it really happen', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'which one? ', 
      'time' : '12:34'
    },
    {
      'from': 'other',
      'message' : 'i think you know', 
      'time' : '12:34'
    },
    {
      'from': 'me',
      'message' : 'ohhh, i know what you are talking about', 
      'time' : '12:34'
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appbar(),
        bottomSheet: Material(
          elevation: 4.0,
          child: bottomMsgBox(),
        ),
        body: chatBody(),
      ),
    );
  }

  appbar() {
    return AppBar(
      backgroundColor: white,
      elevation: 1.0,
      leading:  InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: black,
        ),
      ),
      title: Row(
        children: [
          circleAvatar(widget.user['img']),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user['name'],
                style: const TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
                ),
              ),
              Text(
              widget.user['subtitle'],
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14.0
              ),
            ),
            ],
          )
        ],
      )
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
        radius: 16.0,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(imgPath), // Replace with your image path
      ),
    );
  }

  bottomMsgBox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0, top: 8.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(
              Icons.add,
              color: Colors.grey,
            )
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: TextFormField(
                controller: msgCon,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: black,
                cursorHeight: 24.0,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  suffix: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.emoji_emotions_outlined, color: black,),
                  ),
                  // hintText: hintText ?? '商品をさがす',
                  // hintStyle: w5f12(textGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                    borderSide: const BorderSide(color: grey)
                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                    borderSide: const BorderSide(color: grey)
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                    borderSide: const BorderSide(color: grey)
                  ),
                  fillColor: grey,
                  filled: true,
                ),
              ),
            )
          ),
          const SizedBox(width: 8.0),
          InkWell(
            onTap: () {
              messages.add({
                "from": "me",
                "message": msgCon.text.trim(),
                "time": "12:34"
              });
              msgCon.clear();
              _scrollToBottom();
              setState(() { });
            },
            child: Container(
              width: 35.0,
              height: 35.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: redCol, // Replace with your desired background color
              ),
              child: const Icon(
                Icons.send, // Replace with your desired icon
                color: Colors.white, // Replace with your desired icon color
              ),
            ),
          )
        ],
      ),
    );
  }

  chatBody() {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0.w, 0.0.h, 18.0.w, 18.0.h),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: messages.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              messages[index]['from'] == "me"
                ? msgFromMe(messages[index])
                : msgFromOther(messages[index]),
              Visibility(
                visible: index == messages.length - 1,
                child: const SizedBox(
                  height: 80.0
                ),
              )
            ],
          );
        }
      )
    );
  }

  msgFromMe(msg) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              msg['time'],
              style: const TextStyle(
                color: Colors.grey,
                fontSize:10.0
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
                decoration: const BoxDecoration(
                  color: redCol,
                  borderRadius: BorderRadius.only(
                    topLeft:  Radius.circular(20.0),
                    topRight:  Radius.circular(20.0),
                    bottomLeft:  Radius.circular(20.0),
                  ),
                ),
                child: Text(
                  msg['message'],
                  style: const TextStyle(
                    color: white
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0)
      ],
    );
  }

  msgFromOther(msg) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
                decoration: const BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.only(
                    topLeft:  Radius.circular(20.0),
                    topRight:  Radius.circular(20.0),
                    bottomRight:  Radius.circular(20.0),
                  ),
                ),
                child: Text(
                  msg['message'],
                  style: const TextStyle(
                    color: black
                  ),
                ),
              ),
            ),
            Text(
              msg['time'],
              style: const TextStyle(
                color: Colors.grey,
                fontSize:10.0
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0)
      ],
    );
  }

}