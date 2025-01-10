import 'package:flutter/material.dart';

class ScrollingAnnouncement extends StatefulWidget {
  final String text;
  final Color glowColor;

  ScrollingAnnouncement({
    required this.text,
    required this.glowColor,
  });

  @override
  _ScrollingAnnouncementState createState() => _ScrollingAnnouncementState();
}

class _ScrollingAnnouncementState extends State<ScrollingAnnouncement>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _glowController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() async {
    while (_scrollController.hasClients) {
      await Future.delayed(Duration(milliseconds: 20));
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;
        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            currentScroll + 6,
            duration: Duration(milliseconds: 20),
            curve: Curves.linear,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: widget.glowColor, width: 1),
          bottom: BorderSide(color: widget.glowColor, width: 1),
        ),
      ),
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                widget.glowColor.withOpacity(0.6),
                widget.glowColor,
                widget.glowColor.withOpacity(0.6),
              ],
              stops: [0.0, 0.5, 1.0],
            ).createShader(bounds),
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      widget.text + "     |     " + widget.text,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            color: widget.glowColor,
                            blurRadius: _glowAnimation.value * 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}