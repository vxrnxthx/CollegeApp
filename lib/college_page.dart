import 'package:flutter/material.dart';

class CollegePage extends StatefulWidget {
  @override
  _CollegePageState createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> collegeInfo = [
    {
      'title': 'BMSIT College',
      'icon': Icons.school,
      'description': 'BMS Institute of Technology and Management, established in 2002, is a premier engineering college located in Bangalore. Known for excellence in technical education, research and innovation.',
      'details': [
        'NAAC A+ Accredited Institution',
        'NBA Accredited Programs',
        'State-of-the-art Infrastructure',
        'Industry-aligned Curriculum',
        'Strong Alumni Network'
      ]
    },
    {
      'title': 'Founders',
      'icon': Icons.people,
      'description': 'The visionary founders of BMSIT established the institution with the goal of providing quality technical education.',
      'details': [
        'Late Sri. B.M. Sreenivasaiah',
        'Distinguished Educationalist',
        'Pioneering Vision in Technical Education',
        'Legacy of Excellence',
        'Community Service Focus'
      ]
    },
    {
      'title': 'Principal & Management',
      'icon': Icons.admin_panel_settings,
      'description': 'Under the leadership of our distinguished Principal and Management team, BMSIT continues to achieve new heights in academic excellence.',
      'details': [
        'Experienced Leadership Team',
        'Student-Centric Approach',
        'Research Focus',
        'Industry Connections',
        'Continuous Innovation'
      ]
    },
    {
      'title': 'Dexter - The College Doggo',
      'icon': Icons.pets,
      'description': 'Meet Dexter, our beloved campus mascot! This friendly furry friend brings joy to students and faculty alike.',
      'details': [
        'Campus Guardian',
        'Student\'s Best Friend',
        'Known for His Friendly Nature',
        'Always Present at College Events',
        'Instagram Celebrity'
      ]
    },
  ];

  int selectedIndex = -1;

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
            'About Our College',
            style: TextStyle(
              fontSize: 20,
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
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            // Vertical Tabs
            Container(
              width: 300,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: collegeInfo.length,
                itemBuilder: (context, index) {
                  return NeonTab(
                    title: collegeInfo[index]['title'],
                    icon: collegeInfo[index]['icon'],
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = selectedIndex == index ? -1 : index;
                      });
                    },
                  );
                },
              ),
            ),
            // Content Area
            if (selectedIndex != -1)
              Expanded(
                child: AnimatedContentPanel(
                  info: collegeInfo[selectedIndex],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NeonTab extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  NeonTab({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _NeonTabState createState() => _NeonTabState();
}

class _NeonTabState extends State<NeonTab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
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
            onTap: widget.onTap,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple[400]!.withOpacity(0.6),
                    blurRadius: _glowAnimation.value *
                        (widget.isSelected || _isHovering ? 8 : 5),
                    spreadRadius: _glowAnimation.value *
                        (widget.isSelected || _isHovering ? 2 : 1),
                  ),
                ],
                border: Border.all(
                  color: Colors.purple[400]!,
                  width: 2.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 24,
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
                          fontSize: 18,
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedContentPanel extends StatelessWidget {
  final Map<String, dynamic> info;

  AnimatedContentPanel({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 500),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(
              scale: 0.8 + (0.2 * value),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.purple[400]!,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple[400]!.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info['description'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 24),
                      ...List.generate(
                        info['details'].length,
                            (index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            '• ${info['details'][index]}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}