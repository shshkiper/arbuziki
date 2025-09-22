import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key});

  @override
  ConsumerState<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _cart = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      final existingIndex = _cart.indexWhere(
        (cartItem) => cartItem['id'] == item['id'],
      );
      
      if (existingIndex >= 0) {
        _cart[existingIndex]['quantity'] += 1;
      } else {
        _cart.add({...item, 'quantity': 1});
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['name']} добавлен в корзину'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CartBottomSheet(
        cart: _cart,
        onUpdateQuantity: (index, quantity) {
          setState(() {
            if (quantity <= 0) {
              _cart.removeAt(index);
            } else {
              _cart[index]['quantity'] = quantity;
            }
          });
        },
        onClearCart: () {
          setState(() => _cart.clear());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartItemsCount = _cart.fold<int>(0, (sum, item) => sum + (item['quantity'] as int));
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Меню'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: _showCart,
              ),
              if (cartItemsCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemsCount',
                      style: TextStyle(
                        color: theme.colorScheme.onError,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Кофе'),
            Tab(text: 'Чай'),
            Tab(text: 'Десерты'),
            Tab(text: 'Книги'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MenuSection(
            items: _coffeeItems,
            onAddToCart: _addToCart,
          ),
          _MenuSection(
            items: _teaItems,
            onAddToCart: _addToCart,
          ),
          _MenuSection(
            items: _dessertItems,
            onAddToCart: _addToCart,
          ),
          _MenuSection(
            items: _bookItems,
            onAddToCart: _addToCart,
          ),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>) onAddToCart;

  const _MenuSection({
    required this.items,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _MenuItem(
            item: item,
            onAddToCart: () => onAddToCart(item),
          ),
        )
            .animate(delay: Duration(milliseconds: index * 100))
            .fadeIn(duration: const Duration(milliseconds: 400))
            .slideX(begin: 0.2, duration: const Duration(milliseconds: 400));
      },
    );
  }
}

class _MenuItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onAddToCart;

  const _MenuItem({
    required this.item,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showItemDetails(context),
        child: Row(
          children: [
            // Изображение
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/${item['image']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Информация о товаре
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['description'],
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₽${item['price']}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            if (item['rating'] != null) ...[
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                item['rating'].toString(),
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(width: 8),
                            ],
                            ElevatedButton.icon(
                              onPressed: onAddToCart,
                              icon: const Icon(Icons.add, size: 16),
                              label: const Text('В корзину'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                textStyle: theme.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _ItemDetailsDialog(item: item),
    );
  }
}

class _ItemDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> item;

  const _ItemDetailsDialog({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Изображение
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: AssetImage('assets/images/${item['image']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['description'],
                    style: theme.textTheme.bodyMedium,
                  ),
                  if (item['ingredients'] != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Состав:',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      (item['ingredients'] as List<String>).join(', '),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₽${item['price']}',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Добавить в корзину'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> cart;
  final Function(int, int) onUpdateQuantity;
  final VoidCallback onClearCart;

  const _CartBottomSheet({
    required this.cart,
    required this.onUpdateQuantity,
    required this.onClearCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = cart.fold<double>(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Заголовок
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Корзина',
                  style: theme.textTheme.headlineSmall,
                ),
                if (cart.isNotEmpty)
                  TextButton(
                    onPressed: onClearCart,
                    child: const Text('Очистить'),
                  ),
              ],
            ),
          ),
          
          // Список товаров
          if (cart.isEmpty)
            const Expanded(
              child: Center(
                child: Text('Корзина пуста'),
              ),
            )
          else ...[
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return _CartItem(
                    item: item,
                    onQuantityChanged: (quantity) {
                      onUpdateQuantity(index, quantity);
                    },
                  );
                },
              ),
            ),
            
            // Итого и кнопка заказа
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Итого:',
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        '₽${total.toInt()}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // TODO: Переход к оформлению заказа
                      },
                      child: const Text('Оформить заказ'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(int) onQuantityChanged;

  const _CartItem({
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage('assets/images/${item['image']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₽${item['price']}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => onQuantityChanged(item['quantity'] - 1),
                  icon: const Icon(Icons.remove),
                  iconSize: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['quantity'].toString(),
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                IconButton(
                  onPressed: () => onQuantityChanged(item['quantity'] + 1),
                  icon: const Icon(Icons.add),
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Данные для меню
final _coffeeItems = [
  {
    'id': 'coffee_1',
    'name': 'Капучино',
    'description': 'Классический итальянский кофе с молочной пенкой',
    'price': 250,
    'image': 'capuchino.jpg',
    'rating': 4.8,
    'ingredients': ['Эспрессо', 'Молоко', 'Молочная пенка'],
  },
  {
    'id': 'coffee_2',
    'name': 'Латте',
    'description': 'Нежный кофе с большим количеством молока',
    'price': 280,
    'image': 'latte.jpg',
    'rating': 4.7,
    'ingredients': ['Эспрессо', 'Молоко', 'Молочная пенка'],
  },
  {
    'id': 'coffee_3',
    'name': 'Flat White',
    'description': 'Крепкий кофе с микропенкой',
    'price': 320,
    'image': 'Flat White.jpg',
    'rating': 4.9,
    'ingredients': ['Двойной эспрессо', 'Молоко'],
  },
  {
    'id': 'coffee_4',
    'name': 'Айс Латте',
    'description': 'Освежающий холодный латте',
    'price': 300,
    'image': 'ice latte.jpg',
    'rating': 4.6,
    'ingredients': ['Эспрессо', 'Молоко', 'Лед'],
  },
  {
    'id': 'coffee_5',
    'name': 'Двойной Эспрессо',
    'description': 'Крепкий двойной эспрессо для истинных ценителей',
    'price': 200,
    'image': 'double espresso.jpg',
    'rating': 4.5,
    'ingredients': ['Двойной эспрессо'],
  },
];

final _teaItems = [
  {
    'id': 'tea_1',
    'name': 'Айс Матча Латте',
    'description': 'Освежающий японский зеленый чай матча с молоком',
    'price': 350,
    'image': 'ice matcha latte.jpg',
    'rating': 4.7,
    'ingredients': ['Матча', 'Молоко', 'Лед', 'Сироп'],
  },
  {
    'id': 'tea_2',
    'name': 'Черный чай',
    'description': 'Классический черный чай высшего сорта',
    'price': 150,
    'image': '1.jpg',
    'rating': 4.4,
    'ingredients': ['Черный чай'],
  },
];

final _dessertItems = [
  {
    'id': 'dessert_1',
    'name': 'Круассан',
    'description': 'Свежий французский круассан',
    'price': 180,
    'image': '2.jpg',
    'rating': 4.6,
  },
  {
    'id': 'dessert_2',
    'name': 'Чизкейк',
    'description': 'Нежный чизкейк с ягодами',
    'price': 320,
    'image': '3.jpg',
    'rating': 4.8,
  },
];

final _bookItems = [
  {
    'id': 'book_1',
    'name': 'Кофе и философия',
    'description': 'Размышления о жизни за чашкой кофе',
    'price': 450,
    'image': '4.jpg',
    'rating': 4.3,
  },
  {
    'id': 'book_2',
    'name': 'Искусство чаепития',
    'description': 'История и традиции чайной культуры',
    'price': 520,
    'image': '5.jpg',
    'rating': 4.5,
  },
];
