import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

enum UserType { customer, restaurant, rider }

// Routes where the bottom nav bar should be shown
const _customerTabRoutes = [
  '/user/home',
  '/user/search',
  '/user/cart',
  '/user/orders',
  '/user/profile',
];
const _restaurantTabRoutes = [
  '/restaurant/home',
  '/restaurant/orders',
  '/restaurant/menu',
  '/restaurant/analytics',
];
const _riderTabRoutes = ['/rider/home', '/rider/earnings', '/rider/chat'];

class MainShell extends StatelessWidget {
  final Widget child;
  final UserType userType;
  const MainShell({super.key, required this.child, required this.userType});

  bool _showNavBar(String currentPath) {
    final tabRoutes = switch (userType) {
      UserType.customer => _customerTabRoutes,
      UserType.restaurant => _restaurantTabRoutes,
      UserType.rider => _riderTabRoutes,
    };
    return tabRoutes.contains(currentPath);
  }

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).matchedLocation;
    final showNav = _showNavBar(currentPath);
    return Scaffold(
      body: child,
      bottomNavigationBar: showNav
          ? Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _buildNavItems(context, currentPath),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  List<Widget> _buildNavItems(BuildContext context, String currentPath) {
    switch (userType) {
      case UserType.customer:
        return [
          _navItem(
            context,
            Icons.home_outlined,
            Icons.home,
            'Home',
            '/user/home',
            currentPath,
          ),
          _navItem(
            context,
            Icons.search_outlined,
            Icons.search,
            'Search',
            '/user/search',
            currentPath,
          ),
          _navItem(
            context,
            Icons.shopping_cart_outlined,
            Icons.shopping_cart,
            'Cart',
            '/user/cart',
            currentPath,
          ),
          _navItem(
            context,
            Icons.receipt_long_outlined,
            Icons.receipt_long,
            'Orders',
            '/user/orders',
            currentPath,
          ),
          _navItem(
            context,
            Icons.person_outline,
            Icons.person,
            'Profile',
            '/user/profile',
            currentPath,
          ),
        ];
      case UserType.restaurant:
        return [
          _navItem(
            context,
            Icons.home_outlined,
            Icons.home,
            'Home',
            '/restaurant/home',
            currentPath,
          ),
          _navItem(
            context,
            Icons.receipt_long_outlined,
            Icons.receipt_long,
            'Orders',
            '/restaurant/orders',
            currentPath,
          ),
          _navItem(
            context,
            Icons.restaurant_menu_outlined,
            Icons.restaurant_menu,
            'Menu',
            '/restaurant/menu',
            currentPath,
          ),
          _navItem(
            context,
            Icons.analytics_outlined,
            Icons.analytics,
            'Analytics',
            '/restaurant/analytics',
            currentPath,
          ),
        ];
      case UserType.rider:
        return [
          _navItem(
            context,
            Icons.home_outlined,
            Icons.home,
            'Home',
            '/rider/home',
            currentPath,
          ),
          _navItem(
            context,
            Icons.payments_outlined,
            Icons.payments,
            'Earnings',
            '/rider/earnings',
            currentPath,
          ),
          _navItem(
            context,
            Icons.chat_outlined,
            Icons.chat,
            'Chat',
            '/rider/chat',
            currentPath,
          ),
        ];
    }
  }

  Widget _navItem(
    BuildContext ctx,
    IconData icon,
    IconData activeIcon,
    String label,
    String path,
    String currentPath,
  ) {
    final isSelected = currentPath == path;
    return GestureDetector(
      onTap: () => ctx.go(path),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
