import 'package:community_feedback/features/notes/presentation/screens/notes_screen.dart';
import 'package:community_feedback/features/profile/presentation/screens/profile_screen.dart';
import 'package:community_feedback/features/top%20likes%20and%20newest/presentation/screens/top_likes_newest_screen.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:flutter/material.dart';


class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  static final List<Widget> _listMenu = [
    const NotesScreen(),
    const TopLikesNewestScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectedScreen(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        _animationController.reset();
        _animationController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      extendBody: true,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _listMenu[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.mediumSpace,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildNavItem(icon: 'assets/icons/canvas.png', index: 0),
                    _buildNavItem(
                      icon: 'assets/icons/toplikes_icon.png',
                      index: 1,
                    ),
                    _buildNavItem(icon: 'assets/icons/profile.png', index: 2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required String icon, required int index}) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? Colors.white : TColors.primaryColor;

    return Expanded(
      child: GestureDetector(
        onTap: () => _selectedScreen(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: isSelected ? 4 : 2),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? TColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(icon, color: color, width: 30, height: 30),
        ),
      ),
    );
  }
}
