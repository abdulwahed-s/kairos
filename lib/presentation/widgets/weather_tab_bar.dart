import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> dayKeys;

  const WeatherTabBar({
    super.key,
    required this.tabController,
    required this.dayKeys,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.2),
                  Colors.white.withValues(alpha: 0.05),
                ],
              ),
            ),
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.4),
                    Colors.white.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: 0.3,
              ),
              tabs: dayKeys.map((dayKey) {
                final date = DateTime.parse(dayKey);
                final isToday = date.day == DateTime.now().day;

                return Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Text(
                      isToday ? 'Today' : DateFormat('EEE, MMM d').format(date),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
