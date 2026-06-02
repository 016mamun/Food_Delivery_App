import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'features/auth/domain/entities/user_entity.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/restaurant/presentation/screens/user_home_screen.dart';
import 'features/restaurant/presentation/screens/restaurant_detail_screen.dart';
import 'features/food/presentation/screens/food_detail_screen.dart';
import 'features/cart/presentation/screens/cart_screen.dart';
import 'features/order/presentation/screens/order_tracking_screen.dart';
import 'features/order/presentation/screens/order_history_screen.dart';
import 'features/order/presentation/screens/checkout_screen.dart';
import 'features/payment/presentation/screens/payment_screen.dart';
import 'features/map/presentation/screens/map_screen.dart';
import 'features/restaurant/presentation/screens/restaurant_app_home.dart';
import 'features/order/presentation/screens/restaurant_orders_screen.dart';
import 'features/analytics/presentation/screens/sales_analytics_screen.dart';
import 'features/food/presentation/screens/menu_management_screen.dart';
import 'features/order/presentation/screens/rider_orders_screen.dart';
import 'features/chat/presentation/screens/chat_screen.dart';
import 'features/analytics/presentation/screens/rider_earnings_screen.dart';
import 'features/address/presentation/screens/address_list_screen.dart';
import 'features/address/presentation/screens/add_edit_address_screen.dart';
import 'features/address/presentation/screens/location_picker_screen.dart';
import 'core/widgets/main_shell.dart';
import 'core/theme/app_theme.dart';
import 'features/address/domain/entities/address_entity.dart';

// A ChangeNotifier that bridges Riverpod auth state to go_router's refreshListenable
class AuthNotifierListenable extends ChangeNotifier {
  AuthNotifierListenable(Ref ref) {
    ref.listen(authProvider, (_, _) {
      notifyListeners();
    });
  }
}

final _authListenableProvider = Provider<AuthNotifierListenable>((ref) {
  return AuthNotifierListenable(ref);
});

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = ref.watch(_authListenableProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: listenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      final isSplash = state.matchedLocation == '/splash';
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isUnauthenticated = authState.status == AuthStatus.unauthenticated;

      if (isSplash) return null;
      if (isUnauthenticated && !isAuthRoute) return '/auth/login';

      // Redirect based on user role
      if (isAuthenticated && isAuthRoute) {
        final userRole = authState.user?.role;
        switch (userRole) {
          case UserRole.restaurant:
            return '/restaurant/home';
          case UserRole.rider:
            return '/rider/home';
          case UserRole.customer:
          default:
            return '/user/home';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/auth', redirect: (_, _) => '/auth/login'),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/register-restaurant',
        builder: (context, state) => const RegisterScreen(isRestaurant: true),
      ),
      GoRoute(
        path: '/auth/register-rider',
        builder: (context, state) => const RegisterScreen(isRider: true),
      ),

      // User App Routes - all inside one ShellRoute
      ShellRoute(
        builder: (context, state, child) =>
            MainShell(child: child, userType: UserType.customer),
        routes: [
          GoRoute(
            path: '/user/home',
            builder: (context, state) => const UserHomeScreen(),
          ),
          GoRoute(
            path: '/user/search',
            builder: (context, state) => const UserHomeScreen(initialTab: 1),
          ),
          GoRoute(
            path: '/user/cart',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: '/user/checkout',
            builder: (context, state) => const CheckoutScreen(),
          ),
          GoRoute(
            path: '/user/orders',
            builder: (context, state) => const OrderHistoryScreen(),
          ),
          GoRoute(
            path: '/user/profile',
            builder: (context, state) => const _ProfilePlaceholder(),
          ),
          GoRoute(
            path: '/user/restaurant/:id',
            builder: (context, state) => RestaurantDetailScreen(
              restaurantId: state.pathParameters['id']!,
            ),
          ),
          GoRoute(
            path: '/user/food/:id',
            builder: (context, state) =>
                FoodDetailScreen(foodId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/user/payment',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return PaymentScreen(
                address: extra?['address'] as AddressEntity,
                instructions: extra?['instructions'] as String? ?? '',
                paymentMethod: extra?['paymentMethod'] as String? ?? 'card',
              );
            },
          ),
          GoRoute(
            path: '/user/order-tracking/:id',
            builder: (context, state) =>
                OrderTrackingScreen(orderId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/user/map/:orderId',
            builder: (context, state) =>
                MapScreen(orderId: state.pathParameters['orderId']!),
          ),
          GoRoute(
            path: '/user/addresses',
            builder: (context, state) => const AddressListScreen(),
          ),
          GoRoute(
            path: '/user/addresses/add',
            builder: (context, state) => const AddEditAddressScreen(),
          ),
          GoRoute(
            path: '/user/addresses/edit',
            builder: (context, state) {
              final address = state.extra as AddressEntity?;
              return AddEditAddressScreen(address: address);
            },
          ),
          GoRoute(
            path: '/user/addresses/pick-location',
            builder: (context, state) => const LocationPickerScreen(),
          ),
        ],
      ),

      // Restaurant App Routes
      ShellRoute(
        builder: (context, state, child) =>
            MainShell(child: child, userType: UserType.restaurant),
        routes: [
          GoRoute(
            path: '/restaurant/home',
            builder: (context, state) => const RestaurantAppHome(),
          ),
          GoRoute(
            path: '/restaurant/orders',
            builder: (context, state) => const RestaurantOrdersScreen(),
          ),
          GoRoute(
            path: '/restaurant/menu',
            builder: (context, state) => const MenuManagementScreen(),
          ),
          GoRoute(
            path: '/restaurant/analytics',
            builder: (context, state) => const SalesAnalyticsScreen(),
          ),
        ],
      ),

      // Rider App Routes
      ShellRoute(
        builder: (context, state, child) =>
            MainShell(child: child, userType: UserType.rider),
        routes: [
          GoRoute(
            path: '/rider/home',
            builder: (context, state) => const RiderOrdersScreen(),
          ),
          GoRoute(
            path: '/rider/earnings',
            builder: (context, state) => const RiderEarningsScreen(),
          ),
          GoRoute(
            path: '/rider/chat',
            builder: (context, state) => const ChatScreen(orderId: ''),
          ),
          GoRoute(
            path: '/rider/map/:orderId',
            builder: (context, state) =>
                MapScreen(orderId: state.pathParameters['orderId']!),
          ),
        ],
      ),
    ],
  );
});

class _ProfilePlaceholder extends ConsumerWidget {
  const _ProfilePlaceholder();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.person, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            user?.displayName ?? 'Guest User',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            user?.email ?? '',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text('My Addresses'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/user/addresses'),
                ),
                ListTile(
                  leading: const Icon(Icons.payment_outlined),
                  title: const Text('Payment Methods'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  title: const Text('Notifications'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help & Support'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                ref.read(authProvider.notifier).signOut();
                context.go('/auth/login');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
