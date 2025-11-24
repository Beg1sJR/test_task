import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test_task/core/cubit/cubit/settings_cubit.dart';
import 'package:test_task/core/responsive/responsive.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = context.watch<SettingsCubit>().state.brightness;
    final isDark = brightness == Brightness.dark;

    if (Responsive.isMobile(context)) {
      return Scaffold(
        extendBody: true,
        body: navigationShell,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: isDark
                      ? Colors.grey.shade900.withValues(alpha: 0.7)
                      : Colors.white.withValues(alpha: 0.8),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: isDark ? 0.05 : 0.2),
                    width: 1.2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 3,
                  ),
                  child: GNav(
                    selectedIndex: navigationShell.currentIndex,
                    gap: 8,
                    padding: const EdgeInsets.all(15),
                    color: isDark ? Colors.white70 : Colors.black54,
                    activeColor: Colors.deepPurpleAccent,
                    tabBackgroundColor: theme.colorScheme.primary.withValues(
                      alpha: 0.08,
                    ),
                    backgroundColor: Colors.transparent,
                    onTabChange: (index) => _onTap(context, index),
                    tabs: [
                      GButton(icon: Icons.home, text: 'Home'),
                      GButton(icon: Icons.search, text: 'Products'),
                      GButton(icon: Icons.person_outline, text: 'Profile'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) => _onTap(context, index),
            extended: Responsive.isDesktop(context),
            backgroundColor: isDark ? Colors.grey[900] : Colors.white,
            indicatorColor: Colors.deepPurple.withValues(alpha: 0.12),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search),
                selectedIcon: Icon(Icons.search),
                label: Text('Products'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Profile'),
              ),
            ],
          ),

          const VerticalDivider(width: 1),

          Expanded(child: navigationShell),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index != navigationShell.currentIndex,
    );
  }
}
