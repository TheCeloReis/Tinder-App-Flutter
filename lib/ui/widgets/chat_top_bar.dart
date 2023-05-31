import 'package:flutter/material.dart';
import 'package:tinder_app_flutter/data/db/entity/app_user.dart';

class ChatTopBar extends StatefulWidget {
  final AppUser user;
  final bool isTyping;

  ChatTopBar({@required this.user, @required this.isTyping});

  @override
  _ChatTopBarState createState() => _ChatTopBarState();
}

class _ChatTopBarState extends State<ChatTopBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<int> _dotsAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _dotsAnimation = IntTween(begin: 1, end: 3).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(widget.user.profilePhotoPath),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                if (widget.isTyping)
                  AnimatedBuilder(
                    animation: _dotsAnimation,
                    builder: (context, child) {
                      final dotsCount = _dotsAnimation.value;
                      return Text(
                        'Digitando${'.' * dotsCount}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
