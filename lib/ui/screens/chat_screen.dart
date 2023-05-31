import 'package:flutter/material.dart';
import 'package:tinder_app_flutter/data/db/entity/app_user.dart';
import 'package:tinder_app_flutter/data/db/entity/chat.dart';
import 'package:tinder_app_flutter/data/db/entity/message.dart';
import 'package:tinder_app_flutter/data/db/remote/firebase_database_source.dart';
import 'package:tinder_app_flutter/ui/widgets/chat_top_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder_app_flutter/ui/widgets/message_bubble.dart';
import 'package:tinder_app_flutter/util/constants.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String myUserId;
  final String otherUserId;

  static const String id = 'chat_screen';

  ChatScreen({
    @required this.chatId,
    @required this.myUserId,
    @required this.otherUserId,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final FirebaseDatabaseSource _databaseSource = FirebaseDatabaseSource();
  final messageTextController = TextEditingController();
  StreamSubscription<DocumentSnapshot> typingSubscription;
  bool isTyping = false;
  Timer typingTimer;

  @override
  void initState() {
    super.initState();
    typingSubscription =
        _databaseSource.observeUser(widget.otherUserId).listen((snapshot) {
      if (snapshot != null && snapshot.exists) {
        setState(() {
          isTyping = snapshot['typing_to'] == widget.myUserId;
          _startTypingTimer();
        });
      }
    });
  }

  @override
  void dispose() {
    typingSubscription?.cancel();
    typingTimer?.cancel();
    super.dispose();
  }

  void _startTypingTimer() {
    typingTimer?.cancel();
    typingTimer = Timer(Duration(seconds: 5), () {
      setState(() {
        isTyping = false;
      });
    });
  }

  void checkAndUpdateLastMessageSeen(
      Message lastMessage, String messageId, String myUserId) {
    if (lastMessage.seen == false && lastMessage.senderId != myUserId) {
      lastMessage.seen = true;
      Chat updatedChat = Chat(widget.chatId, lastMessage);

      _databaseSource.updateChat(updatedChat);
      _databaseSource.updateMessage(widget.chatId, messageId, lastMessage);
    }
  }

  bool shouldShowTime(Message currMessage, Message messageBefore) {
    int halfHourInMilli = 1800000;

    if (messageBefore != null) {
      if ((messageBefore.epochTimeMs - currMessage.epochTimeMs).abs() >
          halfHourInMilli) {
        return true;
      }
    }
    return messageBefore == null;
  }

  void sendMessage(String myUserId) {
    if (messageTextController.text.isEmpty) return;

    Message message = Message(
      DateTime.now().millisecondsSinceEpoch,
      false,
      myUserId,
      messageTextController.text,
    );
    Chat updatedChat = Chat(widget.chatId, message);
    _databaseSource.addMessage(widget.chatId, message);
    _databaseSource.updateChat(updatedChat);
    _databaseSource.updateUserTyping(widget.myUserId, null);
    messageTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: _databaseSource.observeUser(widget.otherUserId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            final otherUser = AppUser.fromSnapshot(snapshot.data);
            return ChatTopBar(user: otherUser, isTyping: isTyping);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _databaseSource.observeMessages(widget.chatId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                List<Message> messages = [];
                snapshot.data.docs.forEach((element) {
                  messages.add(Message.fromSnapshot(element));
                });
                if (snapshot.data.docs.length > 0) {
                  checkAndUpdateLastMessageSeen(
                    messages.first,
                    snapshot.data.docs[0].id,
                    widget.myUserId,
                  );
                }
                if (_scrollController.hasClients) _scrollController.jumpTo(0.0);

                List<bool> showTimeList =
                    List<bool>.filled(messages.length, false);

                for (int i = messages.length - 1; i >= 0; i--) {
                  bool shouldShow = i == (messages.length - 1)
                      ? true
                      : shouldShowTime(messages[i], messages[i + 1]);
                  showTimeList[i] = shouldShow;
                }
                return ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final item = messages[index];
                    return ListTile(
                      title: MessageBubble(
                        epochTimeMs: item.epochTimeMs,
                        text: item.text,
                        isSenderMyUser:
                            messages[index].senderId == widget.myUserId,
                        includeTime: showTimeList[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          getBottomContainer(context, widget.myUserId),
        ],
      ),
    );
  }

  Widget getBottomContainer(BuildContext context, String myUserId) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
            color: kSecondaryColor.withOpacity(0.5),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextField(
                  controller: messageTextController,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(color: kSecondaryColor),
                  decoration: InputDecoration(
                    labelText: 'Mensagem',
                    labelStyle:
                        TextStyle(color: kSecondaryColor.withOpacity(0.5)),
                    contentPadding: EdgeInsets.all(0),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _databaseSource.updateUserTyping(
                          widget.myUserId, widget.otherUserId);
                    }
                  }),
            ),
            RaisedButton(
              padding: EdgeInsets.all(10),
              highlightElevation: 0,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Text(
                "ENVIAR",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () {
                sendMessage(widget.myUserId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
