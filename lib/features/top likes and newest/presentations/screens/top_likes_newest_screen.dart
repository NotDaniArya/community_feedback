import 'package:community_feedback/features/notes/presentation/screens/widgets/reaction_chip.dart';
import 'package:community_feedback/features/notes/presentation/screens/widgets/sticky_note.dart';
import 'package:community_feedback/features/top%20likes%20and%20newest/presentations/screens/widgets/my_search_bar.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopLikesNewestScreen extends StatefulWidget {
  const TopLikesNewestScreen({super.key});

  @override
  State<TopLikesNewestScreen> createState() => _TopLikesNewestScreenState();
}

class _TopLikesNewestScreenState extends State<TopLikesNewestScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {});
    });
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

              delegate: MyDelegateClass(controller: _searchController),
            ),
            SliverPadding(
              padding: const EdgeInsetsGeometry.all(TSizes.scaffoldPadding),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(TSizes.mediumSpace),
                    margin: const EdgeInsets.only(bottom: TSizes.spaceBtwSections),
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
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. Dignissim dictum ipsum morbi eget. Praesent',
                          style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: TSizes.mediumSpace,),
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
    );
  }
}

class MyDelegateClass extends SliverPersistentHeaderDelegate {
  final TextEditingController controller;

  MyDelegateClass({required this.controller});

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
      child: MySearchBar(controller: controller),
    );
  }

  @override
  double get maxExtent => 80.0;

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(covariant MyDelegateClass oldDelegate) {
    return controller != oldDelegate.controller;
  }
}
