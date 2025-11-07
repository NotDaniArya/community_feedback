import 'package:community_feedback/features/notes/presentation/screens/widgets/reaction_chip.dart';
import 'package:community_feedback/features/top%20likes%20and%20newest/presentations/screens/widgets/date_range_picker_button.dart';
import 'package:community_feedback/features/top%20likes%20and%20newest/presentations/screens/widgets/filter_toogle_button.dart';
import 'package:community_feedback/features/top%20likes%20and%20newest/presentations/screens/widgets/my_search_bar.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:community_feedback/utils/shared_widgets/pagination_bar.dart';
import 'package:flutter/material.dart';

class TopLikesNewestScreen extends StatefulWidget {
  const TopLikesNewestScreen({super.key});

  @override
  State<TopLikesNewestScreen> createState() => _TopLikesNewestScreenState();
}

class _TopLikesNewestScreenState extends State<TopLikesNewestScreen> {
  final _searchController = TextEditingController();
  int _selectedFilterIndex = 0;
  DateTimeRange? _selectedDateRange;
  int _currentPage = 1;
  final int _totalPages = 10;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {});
    });
  }

  void _onPageChanged(int newPage) {
    if (newPage < 1 || newPage > _totalPages) return;
    setState(() {
      _currentPage = newPage;
    });
  }

  Future<void> _selectDateRange() async {
    final initialRange =
        _selectedDateRange ??
        DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(const Duration(days: 7)),
        );

    final newRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDateRange: initialRange,
    );

    if (newRange != null) {
      setState(() {
        _selectedDateRange = newRange;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: TColors.backgroundColor,
        title: Text(
          'Notes',
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,

              delegate: MyDelegateClass(
                controller: _searchController,
                selectedFilterIndex: _selectedFilterIndex,
                selectedDateRange: _selectedDateRange,
                onFilterChanged: (index) {
                  setState(() {
                    _selectedFilterIndex = index;
                  });
                },
                onDateRangePressed: _selectDateRange,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsetsGeometry.all(TSizes.scaffoldPadding),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(TSizes.mediumSpace),
                    margin: const EdgeInsets.only(
                      bottom: TSizes.spaceBtwSections,
                    ),
                    decoration: BoxDecoration(
                      color: TColors.pastelColors[0],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: TSizes.mediumSpace),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Muhammad Dani Arya Putra',
                                style: textTheme.labelMedium!.copyWith(
                                  color: TColors.secondaryText,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            const SizedBox(width: TSizes.largeSpace),

                            Text(
                              '12/12/2012',
                              style: textTheme.labelMedium!.copyWith(
                                color: TColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.mediumSpace),
                        Text(
                          'Ini Testing Aja',
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: TSizes.mediumSpace),
                        Image.asset(
                          'assets/images/auth_image.png',
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: TSizes.mediumSpace),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. Dignissim dictum ipsum morbi eget. Praesent',
                          style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: TSizes.mediumSpace),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReactionChip(emoji: '❤️'),
                            ReactionChip(emoji: '👍'),
                            ReactionChip(emoji: '😂'),
                            ReactionChip(emoji: '😮'),
                            ReactionChip(emoji: '🔥'),
                          ],
                        ),
                      ],
                    ),
                  );
                }, childCount: 7),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PaginationBar(
        currentPage: _currentPage,
        totalPages: _totalPages,
        onPageChanged: _onPageChanged,
      ),
    );
  }
}

class MyDelegateClass extends SliverPersistentHeaderDelegate {
  final TextEditingController controller;
  final int selectedFilterIndex;
  final DateTimeRange? selectedDateRange;
  final ValueChanged<int> onFilterChanged;
  final VoidCallback onDateRangePressed;

  MyDelegateClass({
    required this.selectedFilterIndex,
    required this.selectedDateRange,
    required this.onFilterChanged,
    required this.onDateRangePressed,
    required this.controller,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.scaffoldPadding,
        vertical: TSizes.mediumSpace,
      ),

      color: TColors.backgroundColor,
      child: Column(
        children: [
          MySearchBar(controller: controller),
          const SizedBox(height: TSizes.mediumSpace),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilterToogleButton(
                selectedIndex: selectedFilterIndex,
                onChanged: onFilterChanged,
              ),
              const SizedBox(width: TSizes.mediumSpace),
              DateRangePickerButton(
                dateRange: selectedDateRange,
                onPressed: onDateRangePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 130.0;

  @override
  double get minExtent => 130.0;

  @override
  bool shouldRebuild(covariant MyDelegateClass oldDelegate) {
    return controller != oldDelegate.controller ||
        selectedDateRange != oldDelegate.selectedDateRange ||
        selectedFilterIndex != oldDelegate.selectedFilterIndex;
  }
}
