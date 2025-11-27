import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatelessWidget {
  final Animation<double> backgroundAnimation;

  const AnimatedBackground({super.key, required this.backgroundAnimation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          _buildDynamicGradient(),
          ..._buildFloatingParticles(),
          _buildAnimatedOrbs(),
          _buildBlurEffect(),
        ],
      ),
    );
  }

  Widget _buildDynamicGradient() {
    return AnimatedBuilder(
      animation: backgroundAnimation,
      builder: (context, child) {
        final time = DateTime.now().hour;
        final isDawn = time >= 5 && time < 8;
        final isDay = time >= 8 && time < 17;
        final isDusk = time >= 17 && time < 20;

        List<Color> colors;
        if (isDawn) {
          colors = [
            const Color(0xFFFF6B6B),
            const Color(0xFFFFE66D),
            const Color(0xFF4ECDC4),
          ];
        } else if (isDay) {
          colors = [
            const Color(0xFF74b9ff),
            const Color(0xFF0984e3),
            const Color(0xFF00cec9),
          ];
        } else if (isDusk) {
          colors = [
            const Color(0xFF6c5ce7),
            const Color(0xFFfd79a8),
            const Color(0xFFfdcb6e),
          ];
        } else {
          colors = [
            const Color(0xFF2d3436),
            const Color(0xFF636e72),
            const Color(0xFF2d3436),
          ];
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildFloatingParticles() {
    return List.generate(15, (index) {
      return AnimatedBuilder(
        animation: backgroundAnimation,
        builder: (context, child) {
          final offset =
              (backgroundAnimation.value * 2 * math.pi) + (index * 0.4);
          final x =
              math.cos(offset) * 30 +
              (MediaQuery.of(context).size.width * 0.1 * index);
          final y =
              math.sin(offset * 0.7) * 20 +
              (MediaQuery.of(context).size.height * 0.15 * index);

          return Positioned(
            left: x % MediaQuery.of(context).size.width,
            top: y % MediaQuery.of(context).size.height,
            child: Container(
              width: 4 + (index % 3) * 2,
              height: 4 + (index % 3) * 2,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildAnimatedOrbs() {
    return AnimatedBuilder(
      animation: backgroundAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              right:
                  -50 + (100 * math.sin(backgroundAnimation.value * math.pi)),
              top:
                  100 +
                  (50 * math.cos(backgroundAnimation.value * math.pi * 0.7)),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.deepPurple.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left:
                  -50 +
                  (80 * math.cos(backgroundAnimation.value * math.pi * 1.3)),
              top: 300 + (30 * math.sin(backgroundAnimation.value * math.pi)),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF673AB7).withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right:
                  20 +
                  (60 * math.sin(backgroundAnimation.value * math.pi * 0.5)),
              bottom:
                  100 +
                  (40 * math.cos(backgroundAnimation.value * math.pi * 1.1)),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFFAB40).withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBlurEffect() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
      ),
    );
  }
}
