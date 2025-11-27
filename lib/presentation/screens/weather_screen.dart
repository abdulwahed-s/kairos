import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kairos/cubit/weather_cubit.dart';
import 'package:kairos/presentation/widgets/animated_background.dart';
import 'package:kairos/presentation/widgets/loading_state.dart';
import 'package:kairos/presentation/widgets/error_state.dart';
import 'package:kairos/presentation/widgets/weather_content.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late AnimationController _backgroundController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().fetchWeather();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_backgroundController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _backgroundController.dispose();
    _pulseController.dispose();
    if (mounted) _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            AnimatedBackground(backgroundAnimation: _backgroundAnimation),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return LoadingState(
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                    pulseAnimation: _pulseAnimation,
                  );
                } else if (state is WeatherLoaded) {
                  _tabController = TabController(
                    length: state.groupedWeather.keys.length,
                    vsync: this,
                  );
                  return WeatherContent(
                    state: state,
                    tabController: _tabController,
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                  );
                } else if (state is WeatherError) {
                  return ErrorState(
                    message: state.message,
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                  );
                } else if (state is WeatherOffline) {
                  return ErrorState(
                    message: 'No internet connection',
                    icon: Icons.wifi_off_rounded,
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                  );
                } else if (state is WeatherPermissionDenied) {
                  return ErrorState(
                    message: 'Location permission needed',
                    icon: Icons.location_disabled_rounded,
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                  );
                } else if (state is WeatherPermissionDeniedForever) {
                  return ErrorState(
                    message: 'Please enable location in settings',
                    icon: Icons.location_disabled_rounded,
                    isTwoButtons: true,
                    isDeniedForever: true,
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                  );
                } else if (state is WeatherLocationDisabled) {
                  return ErrorState(
                    message: 'Location services are disabled',
                    icon: Icons.location_disabled_rounded,
                    isTwoButtons: true,
                    isDeniedForever: false,
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
