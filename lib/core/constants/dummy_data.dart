import '../../features/restaurant/domain/entities/restaurant_entity.dart';
import '../../features/food/domain/entities/food_entity.dart';
import '../../features/order/domain/entities/order_entity.dart';
import '../../features/address/domain/entities/address_entity.dart';
import '../../features/map/domain/entities/map_entity.dart';
import '../../features/chat/domain/entities/chat_entity.dart';
import '../../features/analytics/domain/entities/analytics_entity.dart';

class DummyData {
  // ===================== CATEGORIES =====================
  static final List<CategoryEntity> categories = [
    CategoryEntity(
      id: 'cat_1',
      name: 'Burger',
      icon: '🍔',
      color: '0xFFFF8A65',
      itemCount: 24,
    ),
    CategoryEntity(
      id: 'cat_2',
      name: 'Pizza',
      icon: '🍕',
      color: '0xFFEF5350',
      itemCount: 18,
    ),
    CategoryEntity(
      id: 'cat_3',
      name: 'Sushi',
      icon: '🍣',
      color: '0xFFEC407A',
      itemCount: 12,
    ),
    CategoryEntity(
      id: 'cat_4',
      name: 'Pasta',
      icon: '🍝',
      color: '0xFFFFB74D',
      itemCount: 15,
    ),
    CategoryEntity(
      id: 'cat_5',
      name: 'Salad',
      icon: '🥗',
      color: '0xFF66BB6A',
      itemCount: 20,
    ),
    CategoryEntity(
      id: 'cat_6',
      name: 'Dessert',
      icon: '🍰',
      color: '0xFFAB47BC',
      itemCount: 16,
    ),
    CategoryEntity(
      id: 'cat_7',
      name: 'Drinks',
      icon: '🥤',
      color: '0xFF42A5F5',
      itemCount: 22,
    ),
    CategoryEntity(
      id: 'cat_8',
      name: 'Chicken',
      icon: '🍗',
      color: '0xFFFFCA28',
      itemCount: 14,
    ),
  ];

  // ===================== RESTAURANTS =====================
  static final List<RestaurantEntity> restaurants = [
    RestaurantEntity(
      id: 'res_1',
      name: 'Burger Palace',
      description: 'Best burgers in town with premium ingredients',
      image: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800',
      logo: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=100',
      rating: 4.8,
      reviewCount: 324,
      categories: ['Burger', 'Fast Food'],
      deliveryTime: '20-30 min',
      deliveryFee: 2.99,
      minOrder: 10.00,
      address: '123 Main Street, Downtown',
      lat: 23.8103,
      lng: 90.4125,
      isOpen: true,
      isFeatured: true,
      distance: 1.2,
      tags: ['Popular', 'Fast Delivery'],
      ownerId: 'owner_1',
    ),
    RestaurantEntity(
      id: 'res_2',
      name: 'Pizza Heaven',
      description: 'Authentic Italian pizzas baked in wood-fired ovens',
      image:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800',
      logo:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=100',
      rating: 4.6,
      reviewCount: 256,
      categories: ['Pizza', 'Italian'],
      deliveryTime: '25-40 min',
      deliveryFee: 1.99,
      minOrder: 15.00,
      address: '456 Oak Avenue, Midtown',
      lat: 23.7935,
      lng: 90.4066,
      isOpen: true,
      isFeatured: true,
      distance: 2.0,
      tags: ['Italian', 'Wood Fired'],
      ownerId: 'owner_2',
    ),
    RestaurantEntity(
      id: 'res_3',
      name: 'Sushi Master',
      description: 'Fresh authentic Japanese sushi by master chefs',
      image:
          'https://images.unsplash.com/photo-1579584425555-c3ce17fd4651?w=800',
      logo:
          'https://images.unsplash.com/photo-1579584425555-c3ce17fd4651?w=100',
      rating: 4.9,
      reviewCount: 189,
      categories: ['Sushi', 'Japanese'],
      deliveryTime: '30-45 min',
      deliveryFee: 3.99,
      minOrder: 20.00,
      address: '789 Elm Street, Uptown',
      lat: 23.8023,
      lng: 90.3700,
      isOpen: true,
      isFeatured: false,
      distance: 3.5,
      tags: ['Premium', 'Fresh'],
      ownerId: 'owner_3',
    ),
    RestaurantEntity(
      id: 'res_4',
      name: 'Pasta Paradise',
      description: 'Homemade pasta with rich authentic Italian sauces',
      image: 'https://images.unsplash.com/photo-1551183053-bf91a6e8b2d2?w=800',
      logo: 'https://images.unsplash.com/photo-1551183053-bf91a6e8b2d2?w=100',
      rating: 4.5,
      reviewCount: 142,
      categories: ['Pasta', 'Italian'],
      deliveryTime: '25-35 min',
      deliveryFee: 2.49,
      minOrder: 12.00,
      address: '321 Pine Road, Westside',
      lat: 23.7888,
      lng: 90.4154,
      isOpen: true,
      isFeatured: false,
      distance: 1.8,
      tags: ['Homemade', 'Comfort Food'],
      ownerId: 'owner_4',
    ),
    RestaurantEntity(
      id: 'res_5',
      name: 'Green Bowl',
      description: 'Healthy delicious salads & bowls for a balanced lifestyle',
      image:
          'https://images.unsplash.com/photo-1512621776951-a571b50a39b6?w=800',
      logo:
          'https://images.unsplash.com/photo-1512621776951-a571b50a39b6?w=100',
      rating: 4.7,
      reviewCount: 98,
      categories: ['Salad', 'Healthy'],
      deliveryTime: '15-25 min',
      deliveryFee: 0,
      minOrder: 8.00,
      address: '654 Maple Lane, Eastside',
      lat: 23.7957,
      lng: 90.3890,
      isOpen: true,
      isFeatured: true,
      distance: 0.8,
      tags: ['Healthy', 'Free Delivery'],
      ownerId: 'owner_5',
    ),
    RestaurantEntity(
      id: 'res_6',
      name: 'Sweet Dreams Bakery',
      description: 'Artisan desserts made with love and premium ingredients',
      image: 'https://images.unsplash.com/photo-1551024601-becfa7cb68e7?w=800',
      logo: 'https://images.unsplash.com/photo-1551024601-becfa7cb68e7?w=100',
      rating: 4.4,
      reviewCount: 76,
      categories: ['Dessert', 'Bakery'],
      deliveryTime: '20-30 min',
      deliveryFee: 1.49,
      minOrder: 10.00,
      address: '987 Cherry Blvd, Northside',
      lat: 23.8156,
      lng: 90.4253,
      isOpen: true,
      isFeatured: false,
      distance: 2.5,
      tags: ['Bakery', 'Artisan'],
      ownerId: 'owner_6',
    ),
    RestaurantEntity(
      id: 'res_7',
      name: 'Spice Garden',
      description: 'Authentic South Asian cuisine with aromatic spices',
      image:
          'https://images.unsplash.com/photo-1585937421612-70c8a322e0a7?w=800',
      logo:
          'https://images.unsplash.com/photo-1585937421612-70c8a322e0a7?w=100',
      rating: 4.6,
      reviewCount: 215,
      categories: ['Chicken', 'Fast Food'],
      deliveryTime: '25-35 min',
      deliveryFee: 1.99,
      minOrder: 12.00,
      address: '221 Spice Lane, Old Town',
      lat: 23.8065,
      lng: 90.3980,
      isOpen: true,
      isFeatured: true,
      distance: 1.5,
      tags: ['Spicy', 'Authentic'],
      ownerId: 'owner_7',
    ),
    RestaurantEntity(
      id: 'res_8',
      name: 'Café Mocha',
      description: 'Premium coffee and refreshing beverages with light bites',
      image:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800',
      logo:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=100',
      rating: 4.3,
      reviewCount: 112,
      categories: ['Drinks', 'Dessert'],
      deliveryTime: '10-20 min',
      deliveryFee: 0.99,
      minOrder: 5.00,
      address: '445 Brew Street, Central',
      lat: 23.8000,
      lng: 90.4100,
      isOpen: true,
      isFeatured: false,
      distance: 0.6,
      tags: ['Coffee', 'Quick'],
      ownerId: 'owner_8',
    ),
  ];

  // ===================== FOODS =====================
  static final List<FoodEntity> foods = [
    FoodEntity(
      id: 'food_1',
      name: 'Classic Smash Burger',
      description:
          'Double smashed patties with melted cheddar, pickles, onions, and our secret sauce on a brioche bun',
      price: 12.99,
      discountPrice: 9.99,
      image:
          'https://images.unsplash.com/photo-1568901346375-23c9450c5e24?w=800',
      rating: 4.8,
      reviewCount: 234,
      restaurantId: 'res_1',
      restaurantName: 'Burger Palace',
      categoryId: 'cat_1',
      tags: ['Popular', 'Best Seller'],
      preparationTime: 15,
      isPopular: true,
    ),
    FoodEntity(
      id: 'food_2',
      name: 'BBQ Bacon Burger',
      description:
          'Juicy beef patty with crispy bacon, cheddar cheese, and smoky BBQ sauce',
      price: 14.99,
      image: 'https://images.unsplash.com/photo-1553979459-d1229babdad9?w=800',
      rating: 4.6,
      reviewCount: 156,
      restaurantId: 'res_1',
      restaurantName: 'Burger Palace',
      categoryId: 'cat_1',
      tags: ['Smoky', 'Premium'],
      preparationTime: 18,
      isPopular: true,
    ),
    FoodEntity(
      id: 'food_3',
      name: 'Mushroom Swiss Burger',
      description:
          'Savory sautéed mushrooms with melted Swiss cheese on a toasted pretzel bun',
      price: 13.49,
      discountPrice: 11.49,
      image:
          'https://images.unsplash.com/photo-1572801492846-2c2e4f9d8477?w=800',
      rating: 4.5,
      reviewCount: 89,
      restaurantId: 'res_1',
      restaurantName: 'Burger Palace',
      categoryId: 'cat_1',
      tags: ['Gourmet'],
      preparationTime: 20,
    ),
    FoodEntity(
      id: 'food_4',
      name: 'Margherita Pizza',
      description:
          'Classic Italian pizza with San Marzano tomatoes, fresh mozzarella, and basil',
      price: 16.99,
      image:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800',
      rating: 4.7,
      reviewCount: 312,
      restaurantId: 'res_2',
      restaurantName: 'Pizza Heaven',
      categoryId: 'cat_2',
      tags: ['Classic', 'Italian'],
      preparationTime: 25,
      isPopular: true,
    ),
    FoodEntity(
      id: 'food_5',
      name: 'Pepperoni Supreme',
      description:
          'Loaded with double pepperoni, mozzarella, and our signature tomato sauce',
      price: 18.99,
      discountPrice: 15.99,
      image:
          'https://images.unsplash.com/photo-1628840042765-356cda071f44?w=800',
      rating: 4.9,
      reviewCount: 278,
      restaurantId: 'res_2',
      restaurantName: 'Pizza Heaven',
      categoryId: 'cat_2',
      tags: ['Popular', 'Loaded'],
      preparationTime: 25,
      isPopular: true,
    ),
    FoodEntity(
      id: 'food_6',
      name: 'Veggie Garden Pizza',
      description:
          'Fresh bell peppers, mushrooms, olives, and onions on a thin crust',
      price: 15.99,
      image:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
      rating: 4.4,
      reviewCount: 98,
      restaurantId: 'res_2',
      restaurantName: 'Pizza Heaven',
      categoryId: 'cat_2',
      tags: ['Vegetarian', 'Healthy'],
      preparationTime: 25,
    ),
    FoodEntity(
      id: 'food_7',
      name: 'Dragon Roll',
      description: 'Shrimp tempura inside, topped with avocado and eel sauce',
      price: 22.99,
      image:
          'https://images.unsplash.com/photo-1579871494447-9816cf5d1c30?w=800',
      rating: 4.9,
      reviewCount: 167,
      restaurantId: 'res_3',
      restaurantName: 'Sushi Master',
      categoryId: 'cat_3',
      tags: ['Premium', 'Chef Special'],
      preparationTime: 30,
      isPopular: true,
    ),
    FoodEntity(
      id: 'food_8',
      name: 'Salmon Nigiri Set',
      description:
          '8 pieces of fresh Atlantic salmon nigiri with wasabi and ginger',
      price: 19.99,
      discountPrice: 16.99,
      image:
          'https://images.unsplash.com/photo-1583623025817-d180a2221d0a?w=800',
      rating: 4.8,
      reviewCount: 145,
      restaurantId: 'res_3',
      restaurantName: 'Sushi Master',
      categoryId: 'cat_3',
      tags: ['Fresh', 'Classic'],
      preparationTime: 20,
      isPopular: true,
    ),
    FoodEntity(
      id: 'food_9',
      name: 'Fettuccine Alfredo',
      description: 'Creamy parmesan alfredo sauce over fresh fettuccine pasta',
      price: 14.99,
      image:
          'https://images.unsplash.com/photo-1645112411341-6c4fd023714a?w=800',
      rating: 4.5,
      reviewCount: 112,
      restaurantId: 'res_4',
      restaurantName: 'Pasta Paradise',
      categoryId: 'cat_4',
      tags: ['Creamy', 'Comfort'],
      preparationTime: 22,
    ),
    FoodEntity(
      id: 'food_10',
      name: 'Spaghetti Bolognese',
      description:
          'Traditional meat sauce slow-cooked for hours with fresh herbs',
      price: 13.99,
      discountPrice: 11.99,
      image: 'https://images.unsplash.com/photo-1551892374-ecf7e0eacb81?w=800',
      rating: 4.6,
      reviewCount: 98,
      restaurantId: 'res_4',
      restaurantName: 'Pasta Paradise',
      categoryId: 'cat_4',
      tags: ['Traditional', 'Hearty'],
      preparationTime: 20,
      isPopular: true,
    ),
    FoodEntity(
      id: 'food_11',
      name: 'Caesar Salad',
      description:
          'Crisp romaine lettuce, parmesan cheese, croutons, and classic Caesar dressing',
      price: 11.99,
      image:
          'https://images.unsplash.com/photo-1546793669-ca1c3ce17fd4d9?w=800',
      rating: 4.3,
      reviewCount: 67,
      restaurantId: 'res_5',
      restaurantName: 'Green Bowl',
      categoryId: 'cat_5',
      tags: ['Classic', 'Light'],
      preparationTime: 10,
    ),
    FoodEntity(
      id: 'food_12',
      name: 'Acai Power Bowl',
      description:
          'Organic acai topped with granola, fresh berries, coconut, and honey',
      price: 13.99,
      image:
          'https://images.unsplash.com/photo-1590301157829-3f4b1d5e8259?w=800',
      rating: 4.7,
      reviewCount: 89,
      restaurantId: 'res_5',
      restaurantName: 'Green Bowl',
      categoryId: 'cat_5',
      tags: ['Superfood', 'Organic'],
      preparationTime: 10,
      isPopular: true,
      isNew: true,
    ),
    FoodEntity(
      id: 'food_13',
      name: 'Chocolate Lava Cake',
      description:
          'Warm chocolate cake with a molten center, served with vanilla ice cream',
      price: 9.99,
      image:
          'https://images.unsplash.com/photo-1624353365286-3f8d62caad51?w=800',
      rating: 4.8,
      reviewCount: 201,
      restaurantId: 'res_6',
      restaurantName: 'Sweet Dreams Bakery',
      categoryId: 'cat_6',
      tags: ['Indulgent', 'Best Seller'],
      preparationTime: 15,
      isPopular: true,
    ),
    FoodEntity(
      id: 'food_14',
      name: 'Tiramisu',
      description:
          'Classic Italian tiramisu with espresso-soaked ladyfingers and mascarpone',
      price: 8.99,
      discountPrice: 7.49,
      image:
          'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=800',
      rating: 4.6,
      reviewCount: 134,
      restaurantId: 'res_6',
      restaurantName: 'Sweet Dreams Bakery',
      categoryId: 'cat_6',
      tags: ['Italian', 'Coffee'],
      preparationTime: 10,
    ),
    FoodEntity(
      id: 'food_15',
      name: 'Mango Smoothie',
      description: 'Fresh mango blended with yogurt and a hint of honey',
      price: 6.99,
      image:
          'https://images.unsplash.com/photo-1623065426488-1472120d296d?w=800',
      rating: 4.5,
      reviewCount: 76,
      restaurantId: 'res_8',
      restaurantName: 'Café Mocha',
      categoryId: 'cat_7',
      tags: ['Fresh', 'Tropical'],
      preparationTime: 5,
      isNew: true,
    ),
    FoodEntity(
      id: 'food_16',
      name: 'Iced Caramel Latte',
      description:
          'Espresso with milk and caramel syrup over ice, topped with whipped cream',
      price: 5.99,
      image:
          'https://images.unsplash.com/photo-1461023058943-4d1ac6c94e9e?w=800',
      rating: 4.4,
      reviewCount: 98,
      restaurantId: 'res_8',
      restaurantName: 'Café Mocha',
      categoryId: 'cat_7',
      tags: ['Coffee', 'Refreshing'],
      preparationTime: 5,
    ),
    FoodEntity(
      id: 'food_17',
      name: 'Crispy Fried Chicken',
      description:
          'Golden crispy fried chicken with our signature seasoning blend',
      price: 11.99,
      discountPrice: 9.99,
      image:
          'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f68?w=800',
      rating: 4.7,
      reviewCount: 245,
      restaurantId: 'res_7',
      restaurantName: 'Spice Garden',
      categoryId: 'cat_8',
      tags: ['Crispy', 'Popular'],
      preparationTime: 18,
      isPopular: true,
    ),
    FoodEntity(
      id: 'food_18',
      name: 'Chicken Biryani',
      description:
          'Fragrant basmati rice layered with spiced chicken, saffron, and caramelized onions',
      price: 13.99,
      image:
          'https://images.unsplash.com/photo-1563379091339-4b6e68398061?w=800',
      rating: 4.9,
      reviewCount: 312,
      restaurantId: 'res_7',
      restaurantName: 'Spice Garden',
      categoryId: 'cat_8',
      tags: ['Aromatic', 'Signature'],
      preparationTime: 25,
      isPopular: true,
      isNew: true,
    ),
    FoodEntity(
      id: 'food_19',
      name: 'Chicken Tikka Wrap',
      description:
          'Grilled chicken tikka with fresh veggies and mint chutney in a warm naan',
      price: 10.99,
      image:
          'https://images.unsplash.com/photo-1626700051175-6716cae10c5b?w=800',
      rating: 4.3,
      reviewCount: 56,
      restaurantId: 'res_7',
      restaurantName: 'Spice Garden',
      categoryId: 'cat_8',
      tags: ['Grilled', 'Wrap'],
      preparationTime: 15,
    ),
    FoodEntity(
      id: 'food_20',
      name: 'Chicken Alfredo Pasta',
      description:
          'Grilled chicken breast on fettuccine with creamy alfredo sauce',
      price: 16.49,
      discountPrice: 14.49,
      image:
          'https://images.unsplash.com/photo-1645112411341-6c4fd023714a?w=800',
      rating: 4.6,
      reviewCount: 78,
      restaurantId: 'res_4',
      restaurantName: 'Pasta Paradise',
      categoryId: 'cat_8',
      tags: ['Creamy', 'Chicken'],
      preparationTime: 22,
    ),
  ];

  // ===================== ORDERS =====================
  static final List<OrderEntity> orders = [
    OrderEntity(
      id: 'order_1',
      userId: 'user_1',
      restaurantId: 'res_1',
      restaurantName: 'Burger Palace',
      riderId: 'rider_1',
      riderName: 'Karim Uddin',
      items: [
        OrderItemEntity(
          foodId: 'food_1',
          foodName: 'Classic Smash Burger',
          foodImage:
              'https://images.unsplash.com/photo-1568901346375-23c9450c5e24?w=800',
          price: 9.99,
          quantity: 2,
        ),
        OrderItemEntity(
          foodId: 'food_2',
          foodName: 'BBQ Bacon Burger',
          foodImage:
              'https://images.unsplash.com/photo-1553979459-d1229babdad9?w=800',
          price: 14.99,
          quantity: 1,
        ),
      ],
      subtotal: 29.97,
      deliveryFee: 2.99,
      tax: 2.40,
      total: 35.36,
      status: OrderStatus.onTheWay,
      deliveryAddress: '45 Gulshan Ave, Dhaka',
      deliveryLat: 23.7935,
      deliveryLng: 90.4066,
      restaurantLat: 23.8103,
      restaurantLng: 90.4125,
      paymentMethod: 'card',
      createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
      confirmedAt: DateTime.now().subtract(const Duration(minutes: 22)),
    ),
    OrderEntity(
      id: 'order_2',
      userId: 'user_1',
      restaurantId: 'res_2',
      restaurantName: 'Pizza Heaven',
      items: [
        OrderItemEntity(
          foodId: 'food_5',
          foodName: 'Pepperoni Supreme',
          foodImage:
              'https://images.unsplash.com/photo-1628840042765-356cda071f44?w=800',
          price: 15.99,
          quantity: 2,
        ),
        OrderItemEntity(
          foodId: 'food_6',
          foodName: 'Veggie Garden Pizza',
          foodImage:
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
          price: 15.99,
          quantity: 1,
        ),
      ],
      subtotal: 35.98,
      deliveryFee: 1.99,
      tax: 2.88,
      total: 40.85,
      status: OrderStatus.delivered,
      deliveryAddress: '45 Gulshan Ave, Dhaka',
      deliveryLat: 23.7935,
      deliveryLng: 90.4066,
      restaurantLat: 23.7935,
      restaurantLng: 90.4066,
      paymentMethod: 'card',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      confirmedAt: DateTime.now().subtract(
        const Duration(hours: 3, minutes: 2),
      ),
      deliveredAt: DateTime.now().subtract(
        const Duration(hours: 2, minutes: 30),
      ),
    ),
    OrderEntity(
      id: 'order_3',
      userId: 'user_1',
      restaurantId: 'res_7',
      restaurantName: 'Spice Garden',
      items: [
        OrderItemEntity(
          foodId: 'food_18',
          foodName: 'Chicken Biryani',
          foodImage:
              'https://images.unsplash.com/photo-1563379091339-4b6e68398061?w=800',
          price: 13.99,
          quantity: 1,
        ),
        OrderItemEntity(
          foodId: 'food_17',
          foodName: 'Crispy Fried Chicken',
          foodImage:
              'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f68?w=800',
          price: 9.99,
          quantity: 1,
        ),
      ],
      subtotal: 24.98,
      deliveryFee: 1.99,
      tax: 2.00,
      total: 28.97,
      status: OrderStatus.delivered,
      deliveryAddress: '45 Gulshan Ave, Dhaka',
      deliveryLat: 23.7935,
      deliveryLng: 90.4066,
      restaurantLat: 23.8065,
      restaurantLng: 90.3980,
      paymentMethod: 'card',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      confirmedAt: DateTime.now().subtract(const Duration(days: 1, minutes: 3)),
      deliveredAt: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
    ),
    OrderEntity(
      id: 'order_4',
      userId: 'user_1',
      restaurantId: 'res_5',
      restaurantName: 'Green Bowl',
      items: [
        OrderItemEntity(
          foodId: 'food_12',
          foodName: 'Acai Power Bowl',
          foodImage:
              'https://images.unsplash.com/photo-1590301157829-3f4b1d5e8259?w=800',
          price: 13.99,
          quantity: 1,
        ),
        OrderItemEntity(
          foodId: 'food_11',
          foodName: 'Caesar Salad',
          foodImage:
              'https://images.unsplash.com/photo-1546793669-ca1c3ce17fd4d9?w=800',
          price: 11.99,
          quantity: 1,
        ),
      ],
      subtotal: 25.98,
      deliveryFee: 0,
      tax: 2.08,
      total: 28.06,
      status: OrderStatus.delivered,
      deliveryAddress: '45 Gulshan Ave, Dhaka',
      deliveryLat: 23.7935,
      deliveryLng: 90.4066,
      restaurantLat: 23.7957,
      restaurantLng: 90.3890,
      paymentMethod: 'card',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      confirmedAt: DateTime.now().subtract(const Duration(days: 3, minutes: 2)),
      deliveredAt: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
    ),
  ];

  // ===================== CHAT MESSAGES =====================
  static final List<ChatMessageEntity> chatMessages = [
    ChatMessageEntity(
      id: 'msg_1',
      senderId: 'rider_1',
      senderName: 'Karim Uddin',
      receiverId: 'user_1',
      orderId: 'order_1',
      message: 'I\'m on my way to the restaurant!',
      createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
      isRead: true,
    ),
    ChatMessageEntity(
      id: 'msg_2',
      senderId: 'user_1',
      senderName: 'Mamun',
      receiverId: 'rider_1',
      orderId: 'order_1',
      message: 'Great, how long will it take?',
      createdAt: DateTime.now().subtract(const Duration(minutes: 18)),
      isRead: true,
    ),
    ChatMessageEntity(
      id: 'msg_3',
      senderId: 'rider_1',
      senderName: 'Karim Uddin',
      receiverId: 'user_1',
      orderId: 'order_1',
      message: 'About 15 minutes. I\'ve picked up your order!',
      createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      isRead: true,
    ),
    ChatMessageEntity(
      id: 'msg_4',
      senderId: 'rider_1',
      senderName: 'Karim Uddin',
      receiverId: 'user_1',
      orderId: 'order_1',
      message: 'Almost there! 3 minutes away 🏍️',
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
      isRead: false,
    ),
  ];

  // ===================== ANALYTICS =====================
  static final SalesAnalyticsEntity salesAnalytics = SalesAnalyticsEntity(
    totalRevenue: 12580.50,
    totalOrders: 342,
    averageOrderValue: 36.78,
    pendingOrders: 5,
    completedOrders: 318,
    cancelledOrders: 19,
    dailySales: List.generate(7, (i) {
      return DailySalesEntity(
        date: DateTime.now().subtract(Duration(days: 6 - i)),
        revenue: 1200 + (i * 350) + (i % 3 * 200),
        orders: 30 + (i * 5) + (i % 2 * 8),
      );
    }),
    topItems: [
      TopItemEntity(
        foodId: 'food_1',
        foodName: 'Classic Smash Burger',
        quantitySold: 156,
        revenue: 1558.44,
      ),
      TopItemEntity(
        foodId: 'food_5',
        foodName: 'Pepperoni Supreme',
        quantitySold: 132,
        revenue: 2509.68,
      ),
      TopItemEntity(
        foodId: 'food_18',
        foodName: 'Chicken Biryani',
        quantitySold: 118,
        revenue: 1650.82,
      ),
    ],
  );

  static final RiderEarningsEntity riderEarnings = RiderEarningsEntity(
    todayEarnings: 85.50,
    weeklyEarnings: 520.00,
    monthlyEarnings: 2180.00,
    todayDeliveries: 8,
    weeklyDeliveries: 47,
    monthlyDeliveries: 198,
    dailyEarnings: List.generate(7, (i) {
      return DailyEarningEntity(
        date: DateTime.now().subtract(Duration(days: 6 - i)),
        earnings: 60 + (i * 12) + (i % 3 * 15),
        deliveries: 5 + (i % 3),
      );
    }),
  );

  // ===================== LOCATIONS =====================
  static final LocationEntity userLocation = LocationEntity(
    lat: 23.7935,
    lng: 90.4066,
    address: '45 Gulshan Ave, Dhaka',
    name: 'Home',
  );

  // ===================== ADDRESSES =====================
  static final List<AddressEntity> addresses = [
    AddressEntity(
      id: 'addr_1',
      userId: 'user_1',
      label: 'Home',
      fullAddress: '45 Gulshan Ave, Dhaka 1212',
      street: 'Gulshan Avenue',
      city: 'Dhaka',
      state: 'Dhaka Division',
      postalCode: '1212',
      country: 'Bangladesh',
      lat: 23.7935,
      lng: 90.4066,
      isDefault: true,
      phone: '+880 1712-345678',
      instructions: 'Ring the doorbell, 3rd floor',
    ),
    AddressEntity(
      id: 'addr_2',
      userId: 'user_1',
      label: 'Office',
      fullAddress: 'Plot 15, Block K, Banani, Dhaka 1213',
      street: 'Banani Main Road',
      city: 'Dhaka',
      state: 'Dhaka Division',
      postalCode: '1213',
      country: 'Bangladesh',
      lat: 23.7925,
      lng: 90.4011,
      isDefault: false,
      phone: '+880 1712-345678',
      instructions: 'Call upon arrival, Reception desk',
    ),
    AddressEntity(
      id: 'addr_3',
      userId: 'user_1',
      label: 'Parents House',
      fullAddress: 'House 22, Road 5, Dhanmondi, Dhaka 1205',
      street: 'Dhanmondi R/A',
      city: 'Dhaka',
      state: 'Dhaka Division',
      postalCode: '1205',
      country: 'Bangladesh',
      lat: 23.7461,
      lng: 90.3742,
      isDefault: false,
      phone: '+880 1712-345679',
      instructions: '',
    ),
  ];

  // ===================== HELPER METHODS =====================
  static List<FoodEntity> getPopularFoods() =>
      foods.where((f) => f.isPopular).toList();
  static List<FoodEntity> getNewFoods() => foods.where((f) => f.isNew).toList();
  static List<FoodEntity> getFoodsByCategory(String categoryId) =>
      foods.where((f) => f.categoryId == categoryId).toList();
  static List<FoodEntity> getFoodsByRestaurant(String restaurantId) =>
      foods.where((f) => f.restaurantId == restaurantId).toList();
  static List<FoodEntity> getDiscountedFoods() =>
      foods.where((f) => f.hasDiscount).toList();
  static List<RestaurantEntity> getFeaturedRestaurants() =>
      restaurants.where((r) => r.isFeatured).toList();
  static List<FoodEntity> searchFoods(String query) {
    final q = query.toLowerCase();
    return foods
        .where(
          (f) =>
              f.name.toLowerCase().contains(q) ||
              f.tags.any((t) => t.toLowerCase().contains(q)) ||
              f.restaurantName.toLowerCase().contains(q),
        )
        .toList();
  }

  static List<RestaurantEntity> searchRestaurants(String query) {
    final q = query.toLowerCase();
    return restaurants
        .where(
          (r) =>
              r.name.toLowerCase().contains(q) ||
              r.categories.any((c) => c.toLowerCase().contains(q)) ||
              r.tags.any((t) => t.toLowerCase().contains(q)),
        )
        .toList();
  }
}
