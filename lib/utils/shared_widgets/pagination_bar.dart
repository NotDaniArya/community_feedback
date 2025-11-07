import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  Widget _buildDots() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        '...',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<Widget> _buildPageNumbersList(BuildContext context) {
    final Set<int> pagesToShow = {
      currentPage - 1,
      currentPage,
      currentPage + 1,
      totalPages,
    };

    final validPages = pagesToShow
        .where((page) => page >= 1 && page <= totalPages)
        .toList();

    validPages.sort();

    final List<Widget> pageWidgets = [];
    int? lastPage;
    for (final page in validPages) {
      if (lastPage != null && page - lastPage > 1) {
        pageWidgets.add(_buildDots());
      }
      pageWidgets.add(_buildPageNumber(context, page));
      lastPage = page;
    }

    return pageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        margin: const EdgeInsets.symmetric(
          horizontal: TSizes.largeSpace * 2.4,
          vertical: 16.0,
        ),
        decoration: BoxDecoration(
          color: TColors.primaryColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: TColors.primaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavButton(
              context,
              icon: Icons.chevron_left,
              onPressed: currentPage > 1
                  ? () => onPageChanged(currentPage - 1)
                  : null,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,

              children: _buildPageNumbersList(context),
            ),
            _buildNavButton(
              context,
              icon: Icons.chevron_right,
              onPressed: currentPage < totalPages
                  ? () => onPageChanged(currentPage + 1)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white.withOpacity(onPressed == null ? 0.5 : 1.0),
      ),
    );
  }

  Widget _buildPageNumber(BuildContext context, int page) {
    final bool isSelected = currentPage == page;
    return GestureDetector(
      onTap: () => onPageChanged(page),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          page.toString(),
          style: TextStyle(
            color: isSelected ? TColors.primaryColor : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
