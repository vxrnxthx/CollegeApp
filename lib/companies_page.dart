import 'package:flutter/material.dart';

class CompaniesPage extends StatelessWidget {
  final List<Map<String, String>> companies = [
    {
      "name": "Apple",
      "description": "A leading technology company known for iPhone, Mac, and innovative products."
    },
    {
      "name": "Google",
      "description": "Global technology leader in search, cloud computing, and digital advertising."
    },
    {
      "name": "Amazon",
      "description": "World's largest e-commerce platform and cloud services provider."
    },
    {
      "name": "Microsoft",
      "description": "Pioneer in personal computing, software, and cloud solutions."
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
            "Fortune 500 Companies",
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
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          itemCount: companies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: NeonCompanyCard(
                company: companies[index]["name"]!,
                description: companies[index]["description"]!,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CompaniesPageDetail(
                            company: companies[index]["name"]!,
                            description: companies[index]["description"]!,
                          ),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween<double>(begin: 0.5, end: 1.0)
                                .animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            )),
                            child: child,
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 500),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class NeonCompanyCard extends StatefulWidget {
  final String company;
  final String description;
  final VoidCallback onTap;

  NeonCompanyCard({
    required this.company,
    required this.description,
    required this.onTap,
  });

  @override
  _NeonCompanyCardState createState() => _NeonCompanyCardState();
}

class _NeonCompanyCardState extends State<NeonCompanyCard>
    with SingleTickerProviderStateMixin {
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
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple[400]!.withOpacity(0.6),
                    blurRadius: _glowAnimation.value * (_isHovering ? 8 : 5),
                    spreadRadius: _glowAnimation.value * (_isHovering ? 2 : 1),
                  ),
                ],
                border: Border.all(
                  color: Colors.purple[400]!,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
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
                        widget.company,
                        style: TextStyle(
                          fontSize: 24,
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
                  if (_isHovering)
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
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

class CompaniesPageDetail extends StatelessWidget {
  final String company;
  final String description;

  CompaniesPageDetail({required this.company, required this.description});

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
            company,
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
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}