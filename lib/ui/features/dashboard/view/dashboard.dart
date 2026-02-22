import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/dashboard/view/home_screen.dart';
import 'package:truck_mandi/ui/features/home/view_model/category_tab_index_notifier.dart';
import 'package:truck_mandi/ui/features/my_profile/view/profile_view.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view/choose_what_you_want_to_sell__sheet.dart';
import '../view_model/navigation_provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NavigationProvider>(
        builder: (context, provider, child) {
          return _getPage(provider.selectedIndex);
        },
      ),
      bottomNavigationBar: Consumer<NavigationProvider>(
        builder: (context, provider, child) {
          return BottomNavigationBar(
            backgroundColor: AppColors.whiteColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: provider.selectedIndex,
            showUnselectedLabels: true,
            onTap: (index) {
              // Always reset category tab index
              context.read<CategoryTabIndexNotifier>().updateIndex(0);

              if (index == 1) {
                // Sell sheet
                ChooseWhatYouWantToSellSheet.show(context);
              } else {
                provider.updateIndex(index);
              }
            },
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  provider.selectedIndex == 0
                      ? Icons.home_rounded
                      : Icons.home_outlined,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box_rounded, color: AppColors.red),
                label: 'Sell',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  provider.selectedIndex == 2
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  provider.selectedIndex == 3
                      ? Icons.account_circle
                      : Icons.account_circle_outlined,
                ),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        // Sell is just an action, not a page – keep Home or last page
        return const HomeScreen();
      case 2:
        return const FavouriteAdsScreen();
      case 3:
        return const ProfileViewRedesigned();
      default:
        return const HomeScreen();
    }
  }
}

class FavouriteAdsScreen extends StatelessWidget {
  const FavouriteAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('My Favourite Ads')));
  }
}
