import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> slideAnimation;
  final Animation<double> pulseAnimation;

  const LoadingState({
    super.key,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([fadeAnimation, pulseAnimation]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, slideAnimation.value),
          child: Opacity(
            opacity: fadeAnimation.value,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: pulseAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.2),
                            Colors.white.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Fetching weather data...',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 2,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.3),
                          Colors.white.withValues(alpha: 0.8),
                          Colors.white.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
