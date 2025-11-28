import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CheckMailBoxScreen extends StatefulWidget {
  const CheckMailBoxScreen({Key? key}) : super(key: key);
  static const String routeName = '/check_mail';

  @override
  _CheckMailBoxScreenState createState() => _CheckMailBoxScreenState();
}

class _CheckMailBoxScreenState extends State<CheckMailBoxScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final Random _rand = Random();
  List<_BubbleSpec> _generateBubbles(double width) {
    int count =
        width > 1400
            ? 18
            : width > 1000
            ? 14
            : width > 600
            ? 10
            : 8;

    return List.generate(
      count,
      (i) => _BubbleSpec(
        size: 40 + i * 14.0,
        speed: 4 + (i % 5),
        xFactor: 0.12 + (i % 5) * 0.12,
        yShift: 0.0,
        opacity: 0.05 + (i % 4) * 0.1,
      ),
    );
  }

  late List<_BubbleSpec> _bubbles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        _bubbles = _generateBubbles(width);
        for (var b in _bubbles) {
          b.phase = _rand.nextDouble() * pi * 2;
          b.xOffset = _rand.nextDouble();
          b.yOffset = _rand.nextDouble();
        }

        double titleSize =
            width > 1400
                ? 42
                : width > 1000
                ? 34
                : width > 600
                ? 26
                : 20;

        double subtitleSize =
            width > 1400
                ? 22
                : width > 1000
                ? 18
                : width > 600
                ? 15
                : 13;

        double maxWidth =
            width > 1000
                ? 700
                : width > 600
                ? 500
                : width;

        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final t = _controller.value * 2 * pi;
                  return CustomPaint(
                    painter: _BubblePainter(bubbles: _bubbles, tick: t),
                  );
                },
              ),
              Center(
                child: SizedBox(
                  width: maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Please check your email inbox for the password reset link.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.98),
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          "If you don't see the email, check your Spam or Junk folder.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: subtitleSize,
                          ),
                        ),
                        SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed('/login');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(45, 45),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.orange,
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Return to login',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BubbleSpec {
  double size;
  double speed;
  double xFactor;
  double yShift;
  double opacity;

  double phase = 0;
  double xOffset = 0;
  double yOffset = 0;

  _BubbleSpec({
    required this.size,
    required this.speed,
    required this.xFactor,
    required this.yShift,
    required this.opacity,
  });
}

class _BubblePainter extends CustomPainter {
  final List<_BubbleSpec> bubbles;
  final double tick;

  _BubblePainter({required this.bubbles, required this.tick});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var b in bubbles) {
      final progress = (sin(tick / b.speed + b.phase) + 1) / 2;

      final dy =
          size.height * (0.1 + 0.7 * progress) +
          size.height * (b.yOffset - 0.5) * 0.3;
      final dx =
          size.width * (b.xOffset * 0.8 + 0.1) +
          sin(tick * b.xFactor + b.phase) * size.width * 0.1;

      final center = Offset(dx.clamp(0, size.width), dy.clamp(0, size.height));
      final s = b.size * (0.85 + 0.3 * progress);

      for (int i = 0; i < 5; i++) {
        final layerProgress = 1 - i / 5;
        final radius = s * (0.6 + 0.35 * layerProgress) + i * 6;
        paint.color = Colors.white.withOpacity(
          b.opacity * (0.18 * (1 - i / 6)),
        );
        canvas.drawCircle(center, radius, paint);
      }
    }

    final centerGlow = RadialGradient(
      colors: [Colors.white.withOpacity(0.05), Colors.transparent],
    ).createShader(
      Rect.fromCircle(
        center: Offset(size.width * 0.3, size.height * 0.4),
        radius: size.width * 0.6,
      ),
    );

    final glowPaint = Paint()..shader = centerGlow;
    canvas.drawRect(Offset.zero & size, glowPaint);
  }

  @override
  bool shouldRepaint(_) => true;
}
