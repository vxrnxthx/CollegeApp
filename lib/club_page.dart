import 'package:flutter/material.dart';

class ClubPage extends StatelessWidget {
  final List<Map<String, String>> sections = [
    {
      'title': "Who are we?",
      'content': "We are a group of enthusiastic students from various disciplines, united by a shared passion for learning and creativity. Our club fosters an inclusive and supportive environment for all students to grow and express themselves.",
      'icon': '👥'
    },
    {
      'title': "What we do?",
      'content': "Our club hosts various events, workshops, and seminars to promote creativity, technical skills, and personal development. From tech talks to cultural programs, we provide a platform for students to explore their interests.",
      'icon': '🎯'
    },
    {
      'title': "Our Vision",
      'content': "To create a dynamic community of innovators and leaders who will shape the future of technology and society through creativity, collaboration, and continuous learning.",
      'icon': '🔮'
    },
    {
      'title': "Club Activities",
      'content': "Regular hackathons, coding competitions, technical workshops, leadership development programs, industry expert sessions, cultural events, and community service initiatives.",
      'icon': '🎪'
    },
    {
      'title': "Achievement Gallery",
      'content': "Our members have won numerous competitions, received recognition in national events, and successfully organized major technical symposiums that attracted participants from across the country.",
      'icon': '🏆'
    },
    {
      'title': "Join us",
      'content': "Want to be a part of something exciting? Join our club today and engage in a variety of activities that will enhance your skills, broaden your network, and give you an opportunity to make lasting memories with like-minded peers.",
      'icon': '🤝'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.purple[300]!, Colors.deepPurple[400]!],
          ).createShader(bounds),
          child: Text(
            "About Our Club",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.deepPurple.withOpacity(0.3), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: NeonSectionCard(
                title: sections[index]['title']!,
                content: sections[index]['content']!,
                icon: sections[index]['icon']!,
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }
}

class NeonSectionCard extends StatefulWidget {
  final String title;
  final String content;
  final String icon;
  final int index;

  NeonSectionCard({
    required this.title,
    required this.content,
    required this.icon,
    required this.index,
  });

  @override
  _NeonSectionCardState createState() => _NeonSectionCardState();
}

class _NeonSectionCardState extends State<NeonSectionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  bool _isExpanded = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 2.0, end: 4.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple[400]!.withOpacity(0.6),
                    blurRadius: _glowAnimation.value *
                        (_isHovering || _isExpanded ? 8 : 5),
                    spreadRadius: _glowAnimation.value *
                        (_isHovering || _isExpanded ? 2 : 1),
                  ),
                ],
                border: Border.all(
                  color: Colors.purple[400]!,
                  width: 2.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            widget.icon,
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.purple[300]!,
                                  Colors.white,
                                  Colors.purple[300]!,
                                ],
                                stops: [0.0, 0.5, 1.0],
                              ).createShader(bounds),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.purple[400]!,
                                      blurRadius: _glowAnimation.value * 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      child: AnimatedSize(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: Container(
                          height: _isExpanded ? null : 0,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: _isExpanded ? 20 : 0,
                            ),
                            child: Text(
                              widget.content,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
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