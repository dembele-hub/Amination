
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complex Animation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ComplexAnimation(),
    );
  }
}

class ComplexAnimation extends StatefulWidget {
  @override
  _ComplexAnimationState createState() => _ComplexAnimationState();
}

class _ComplexAnimationState extends State<ComplexAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnimation;
  late Animation<double> _fadeAnimation;
  late double _circlePosition = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _circleAnimation = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _moveCircle(bool moveRight) {
    setState(() {
      _circlePosition += moveRight ? 50 : -50;
    });
  }

  void _toggleAnimation() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complex Animation Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Container(
                    margin: EdgeInsets.only(left: _circlePosition),
                    width: _circleAnimation.value,
                    height: _circleAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => _moveCircle(false),
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: _toggleAnimation,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () => _moveCircle(true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}