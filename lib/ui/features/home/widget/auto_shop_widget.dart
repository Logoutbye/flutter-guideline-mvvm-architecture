import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/ui/features/home/view_model/new_tab_bar_notifier.dart';

final List<Map<String, String>> newsItems = [
  {
    'image': 'assets/images/remove_me1.png',
    'title': 'Latest Truck News',
    'description': 'The trucking industry is evolving rapidly...',
  },
  {
    'image': 'assets/images/remove_me2.png',
    'title': 'Fuel Efficiency Tips',
    'description': 'Discover how to maximize your truck\'s fuel efficiency...',
  },
];

final List<Map<String, String>> reviewsItems = [
  {
    'image': 'assets/images/remove_me2.png',
    'title': 'Fuel Efficiency Tips',
    'description': 'Discover how to maximize your truck\'s fuel efficiency...',
  },
  {
    'image': 'assets/images/remove_me1.png',
    'title': 'Latest Truck News',
    'description': 'The trucking industry is evolving rapidly...',
  },
  {
    'image': 'assets/images/remove_me2.png',
    'title': 'Fuel Efficiency Tips',
    'description': 'Discover how to maximize your truck\'s fuel efficiency...',
  },
];

final List<Map<String, String>> discussionItems = [
  {
    'image': 'assets/images/remove_me1.png',
    'title': 'Latest Truck News',
    'description': 'The trucking industry is evolving rapidly...',
  },
  {
    'image': 'assets/images/remove_me2.png',
    'title': 'Fuel Efficiency Tips',
    'description': 'Discover how to maximize your truck\'s fuel efficiency...',
  },
];

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  const CustomTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    final tabNotifier = context.watch<CustomTabBarNotifier>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tabs.length, (index) {
        final isSelected = tabNotifier.currentIndex == index;

        return GestureDetector(
          onTap: () => context.read<CustomTabBarNotifier>().updateIndex(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected
                      ? AppColors
                            .primary // Change to your active color
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              tabs[index],
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class CustomTabView extends StatelessWidget {
  final List<Widget> children;
  const CustomTabView({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<CustomTabBarNotifier>().currentIndex;

    return Stack(
      children: List.generate(children.length, (index) {
        return Visibility(
          visible: index == currentIndex,
          maintainState: true, // Keep the state of the invisible widgets
          child: children[index],
        );
      }),
    );
  }
}

Widget buildNewsWidget(BuildContext context, List<Map<String, String>> items) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return GestureDetector(
        onTap: () {
          // Handle item tap, e.g., navigate to details page
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.mediaQueryWidth / 3,
                margin: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item['image']!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Text Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['description']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
