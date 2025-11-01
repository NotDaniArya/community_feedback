import 'package:community_feedback/features/auth/presentation/screens/login/login_screen.dart';
import 'package:community_feedback/features/notes/presentation/screens/notes_screen.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'features/notes/presentation/screens/widgets/add_note.dart';

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
    const LoginScreen(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
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
    final textTheme = Theme.of(context).textTheme;

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
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(28),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
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
                    _buildNavItem(
                      icon: 'assets/icons/canvas.png',
                      index: 0,
                    ),
                    _buildNavItem(
                      icon: 'assets/icons/toplikes_icon.png',
                      index: 1,
                    ),
                    _buildNavItem(
                      icon: 'assets/icons/settings_icon.png',
                      index: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: _selectedIndex == 0
          ? TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: TColors.backgroundColor,
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(28),
                          ),
                        ),
                        builder: (context) => const AddNote(),
                      );
                    },
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: TColors.primaryColor,
                    label: Text(
                      'New Note',
                      style: textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    icon: const FaIcon(
                      FontAwesomeIcons.pen,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                );
              },
            )
          : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem({
    required String icon,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? Colors.white : TColors.primaryColor;

    return Expanded(
      child: GestureDetector(
        onTap: () => _selectedScreen(index),
        behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(
            horizontal: isSelected ? 4 : 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? TColors.primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(
            icon,
            color: color,
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}
