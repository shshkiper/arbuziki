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
        title: SizedBox(
          height: 40,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
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
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _MenuItem(
            item: item,
            onAddToCart: () => onAddToCart(item),
        )
            .animate(delay: Duration(milliseconds: index * 100))
            .fadeIn(duration: const Duration(milliseconds: 400))
            .scale(begin: const Offset(0.8, 0.8), duration: const Duration(milliseconds: 400));
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
    
    return Container(
              decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage('assets/images/${item['image']}'),
                  fit: BoxFit.cover,
                ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showItemDetails(context),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      item['name'],
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2,
                      ),
                    ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                      '${item['price']} ₽',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: onAddToCart,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  void _showItemDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ItemDetailsBottomSheet(
        item: item,
        onAddToCart: onAddToCart,
      ),
    );
  }
}

class _ItemDetailsBottomSheet extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onAddToCart;

  const _ItemDetailsBottomSheet({
    required this.item,
    required this.onAddToCart,
  });

  @override
  State<_ItemDetailsBottomSheet> createState() => _ItemDetailsBottomSheetState();
}

class _ItemDetailsBottomSheetState extends State<_ItemDetailsBottomSheet> {
  bool isFavorite = false;
  String selectedSize = 'M';
  int basePrice = 0;

  @override
  void initState() {
    super.initState();
    basePrice = widget.item['price'] as int;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.93, // 93% экрана
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          // Прокручиваемый контент
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outline.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                
                // Header с кнопками
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Кнопка избранного
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.outline.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : theme.colorScheme.onSurface,
                            size: 24,
                          ),
                        ),
                      ),
                      
                      // Кнопка закрытия
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.outline.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.close,
                            color: theme.colorScheme.onSurface,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Изображение (теперь прокручивается)
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.4,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/images/${widget.item['image']}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item['name'],
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'настрой как любишь',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Контент в белой области
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Кастомизация (только для кофе)
                      if (widget.item['id'].toString().startsWith('coffee')) ...[
                        _buildCustomizationOptions(theme),
                        const SizedBox(height: 20),
                        _buildNutritionInfo(theme),
                        const SizedBox(height: 20),
                      ],
                      
                      // Размеры
                      _buildSizeSelection(theme),
                      
                      const SizedBox(height: 24),
                      
                      // Описание
                      Text(
                        widget.item['description'],
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                        ),
                      ),
                      
                      if (widget.item['ingredients'] != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Состав: ${(widget.item['ingredients'] as List<String>).join(', ')}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.8),
                          ),
                        ),
                      ],
                      
                      const SizedBox(height: 24),
                      
                      // Блок "Вместе вкуснее"
                      Text(
                        'Вместе вкуснее',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Предложения
                      _buildSuggestions(theme),
                      
                      const SizedBox(height: 120), // Отступ для кнопки корзины
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Закрепленная кнопка добавления в корзину
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onAddToCart();
                  },
                  borderRadius: BorderRadius.circular(25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                      Text(
                          '${_getCurrentPrice()} ₽',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getCurrentPrice() {
    int price = basePrice;
    if (selectedSize == 'L') {
      price += 50;
    }
    return price;
  }

  Widget _buildCustomizationOptions(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCustomizationItem(
          theme,
          Icons.add_circle_outline,
          'Полезные\nдобавки',
        ),
        _buildCustomizationItem(
          theme,
          Icons.add_circle_outline,
          'Сырная\nпенка и мусс',
        ),
        _buildCustomizationItem(
          theme,
          Icons.local_drink_outlined,
          'Молоко\nкоровье',
        ),
        _buildCustomizationItem(
          theme,
          Icons.coffee_outlined,
          'Эспрессо\nДринкит',
        ),
      ],
    );
  }

  Widget _buildCustomizationItem(ThemeData theme, IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: theme.colorScheme.outline.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.onSurface,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNutritionInfo(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNutritionItem('156 ккал', 'Энергия', theme),
          _buildNutritionItem('7,7 г', 'Белки', theme),
          _buildNutritionItem('8,0 г', 'Жиры', theme),
          _buildNutritionItem('11,9 г', 'Углеводы', theme),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(String value, String label, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildSizeSelection(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedSize = 'M'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: selectedSize == 'M' 
                    ? theme.colorScheme.primary 
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedSize == 'M' 
                      ? theme.colorScheme.primary 
                      : theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'M',
                        style: theme.textTheme.headlineMedium?.copyWith(
                      color: selectedSize == 'M' 
                          ? Colors.white 
                          : theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  Text(
                    '350 мл',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: selectedSize == 'M' 
                          ? Colors.white.withOpacity(0.8) 
                          : theme.colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedSize = 'L'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: selectedSize == 'L' 
                    ? theme.colorScheme.primary 
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedSize == 'L' 
                      ? theme.colorScheme.primary 
                      : theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'L',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: selectedSize == 'L' 
                          ? Colors.white 
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '450 мл',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: selectedSize == 'L' 
                          ? Colors.white.withOpacity(0.8) 
                          : theme.colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
              ),
            ),
          ],
    );
  }

  Widget _buildSuggestions(ThemeData theme) {
    // Примерные предложения в зависимости от типа товара
    List<Map<String, dynamic>> suggestions = [];
    
    if (widget.item['id'].toString().startsWith('coffee')) {
      suggestions = [
        {'name': 'Круассан', 'price': 180, 'image': 'donat1.jpg'},
        {'name': 'Чизкейк', 'price': 320, 'image': 'donat2.jpg'},
      ];
    } else if (widget.item['id'].toString().startsWith('dessert')) {
      suggestions = [
        {'name': 'Капучино', 'price': 250, 'image': 'capuchino.jpg'},
        {'name': 'Латте', 'price': 280, 'image': 'latte.jpg'},
      ];
    } else if (widget.item['id'].toString().startsWith('book')) {
      suggestions = [
        {'name': 'Чай', 'price': 150, 'image': '1.jpg'},
        {'name': 'Печенье', 'price': 120, 'image': 'donat3.jpg'},
      ];
    }
    
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return Container(
            width: 100,
            margin: EdgeInsets.only(right: index < suggestions.length - 1 ? 12 : 0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage('assets/images/${suggestion['image']}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        suggestion['name'],
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '₽${suggestion['price']}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
    'name': 'Рефрешер',
    'description': 'Освежающий фруктовый напиток',
    'price': 280,
    'image': 'refresher.jpg',
    'rating': 4.5,
    'ingredients': ['Фруктовый сироп', 'Лед', 'Газированная вода'],
  },
  {
    'id': 'tea_3',
    'name': 'Далгона кофе',
    'description': 'Трендовый взбитый кофе с молоком',
    'price': 320,
    'image': 'dalgona-сofe.jpg',
    'rating': 4.6,
    'ingredients': ['Растворимый кофе', 'Сахар', 'Молоко'],
  },
];

final _dessertItems = [
  {
    'id': 'dessert_1',
    'name': 'Пончик с глазурью',
    'description': 'Классический пончик с сахарной глазурью',
    'price': 120,
    'image': 'donat1.jpg',
    'rating': 4.6,
  },
  {
    'id': 'dessert_2',
    'name': 'Пончик с шоколадом',
    'description': 'Пончик в шоколадной глазури с посыпкой',
    'price': 140,
    'image': 'donat2.jpg',
    'rating': 4.8,
  },
  {
    'id': 'dessert_3',
    'name': 'Пончик с карамелью',
    'description': 'Воздушный пончик с карамельной начинкой',
    'price': 150,
    'image': 'donat3.jpg',
    'rating': 4.7,
  },
  {
    'id': 'dessert_4',
    'name': 'Пончик с ягодами',
    'description': 'Пончик с ягодной начинкой и пудрой',
    'price': 160,
    'image': 'donat4.jpg',
    'rating': 4.9,
  },
  {
    'id': 'dessert_5',
    'name': 'Пончик с кремом',
    'description': 'Нежный пончик с заварным кремом',
    'price': 155,
    'image': 'donat5.jpg',
    'rating': 4.8,
  },
  {
    'id': 'dessert_6',
    'name': 'Пончик с орехами',
    'description': 'Хрустящий пончик с измельченными орехами',
    'price': 165,
    'image': 'donat6.jpg',
    'rating': 4.7,
  },
];

final _bookItems = [
  {
    'id': 'book_1',
    'name': 'Мастер и Маргарита',
    'description': 'Классический роман Михаила Булгакова',
    'price': 450,
    'image': 'book1.jpg',
    'rating': 4.9,
  },
  {
    'id': 'book_2',
    'name': '1984',
    'description': 'Антиутопия Джорджа Оруэлла',
    'price': 380,
    'image': 'book2.jpg',
    'rating': 4.8,
  },
  {
    'id': 'book_3',
    'name': 'Гарри Поттер',
    'description': 'Магическая сага Дж.К. Роулинг',
    'price': 520,
    'image': 'book3.jpg',
    'rating': 4.9,
  },
  {
    'id': 'book_4',
    'name': 'Преступление и наказание',
    'description': 'Психологический роман Достоевского',
    'price': 420,
    'image': 'book4.jpg',
    'rating': 4.7,
  },
  {
    'id': 'book_5',
    'name': 'Война и мир',
    'description': 'Эпопея Льва Толстого',
    'price': 650,
    'image': 'book5.jpg',
    'rating': 4.8,
  },
  {
    'id': 'book_6',
    'name': 'Анна Каренина',
    'description': 'Роман о любви и судьбе',
    'price': 480,
    'image': 'book6.jpg',
    'rating': 4.6,
  },
  {
    'id': 'book_7',
    'name': 'Собачье сердце',
    'description': 'Сатирическая повесть Булгакова',
    'price': 320,
    'image': 'book7.jpg',
    'rating': 4.7,
  },
  {
    'id': 'book_8',
    'name': 'Евгений Онегин',
    'description': 'Роман в стихах Пушкина',
    'price': 350,
    'image': 'book8.jpg',
    'rating': 4.5,
  },
];

