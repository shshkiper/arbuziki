import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';

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
        toolbarHeight: 100,
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: Container(), // Пустой title
  centerTitle: false,
  flexibleSpace: ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 25.0),
      child: Container(
        color: Colors.white.withOpacity(0.00001),
        child: Column(
          children: [
            // Верхняя часть с логотипом и корзиной
            Container(
              height: 80,
              child: Row(
                children: [
                  // Логотип
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0, top:24.0 ),
                    child: Image.asset(
                      height: 45,
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Spacer(),
                  // Иконка корзины
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, top: 26), // ← Добавь этот отступ
                        child: IconButton(
                          icon: const Icon(Icons.shopping_basket_outlined),
                          iconSize: 30,
                          onPressed: _showCart,
                        ),
                      ),
                      if (cartItemsCount > 0)
                        Positioned(
                          right: 20,
                          top: 33,
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
              ),
            ),
            // TabBar
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TabBar(
                      dividerHeight: 0,
                      controller: _tabController,
                      labelStyle: TextStyle(
                        fontSize: 16.4,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'G'
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 16.4,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'G',
                      ),
                      tabs: const [
                        Tab(text: 'Кофе'),
                        Tab(text: 'Пончики'),
                        Tab(text: 'Книги'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
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
            .animate(delay: Duration(milliseconds: index * 50))
            .fadeIn(duration: const Duration(milliseconds: 10))
            .scale(begin: const Offset(0.8, 0.8), duration: const Duration(milliseconds: 150));
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
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                        fontFamily: 'G',
                        height: 1.3,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.8),
                            blurRadius: 6,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.3),
                                Colors.white.withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '${item['price']} ₽',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'G',
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onAddToCart,
                          child: Container(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.white,
                              size: 35,
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
                            color: isFavorite ? Colors.red.withValues(alpha: 0.85) : theme.colorScheme.onSurface,
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
                const SizedBox(height: 5),
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
                              fontFamily: 'G',
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.item['description'],
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'G',
                              fontSize:19,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // Контент в белой области
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Кастомизация (только для кофе)
                      if (widget.item['id'].toString().startsWith('coffee')) ...[
                        _buildCustomizationOptions(theme),
                        const SizedBox(height: 10),
                        _buildNutritionInfo(theme),
                        const SizedBox(height: 13),
                      ],
                      
                      // Размеры
                      if(widget.item['ingredients'] != null)
                      _buildSizeSelection(theme),
                      
                      const SizedBox(height: 13),
                      if (widget.item['ingredients'] != null) ...[
                        Container( 
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.outline.withOpacity(0.1),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Состав',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontFamily: 'G',
                                    fontSize: 20,
                                    color: theme.colorScheme.onSurface.withOpacity(1),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                (widget.item['ingredients'] as List<String>).join(', '),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontFamily: 'G',
                                  fontSize: 17,
                                  color: theme.colorScheme.onSurface.withOpacity(0.9),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      
                      
                      // Блок "Вместе вкуснее"
                      Container( 
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 0, bottom: 16, left: 16,right: 16),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Предложения',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontFamily: 'G',
                                    fontSize: 20,
                                    color: theme.colorScheme.onSurface.withOpacity(1),
                                ),
                              ),
                              const SizedBox(height: 10),
                      // Предложения
                              _buildSuggestions(theme),
                            ],
                          ),
                        ),
                      
                      const SizedBox(height: 100), // Отступ для кнопки корзины
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
                borderRadius: BorderRadius.circular(20),
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
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                       Text(
                          '${_getCurrentPrice()} ₽',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontFamily: 'G',
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
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            fontFamily: "G",
            fontSize: 13.5,
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
          style: theme.textTheme.titleLarge?.copyWith(
            fontFamily: 'G',
            fontSize: 20,
            color: theme.colorScheme.onSurface.withOpacity(1),
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.9),
            fontFamily: 'G',
            fontSize: 14,
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
              ),
              child: Column(
                children: [
                  Text(
                    'M',
                        style: theme.textTheme.headlineMedium?.copyWith(
                      fontFamily: 'G',
                      fontSize: 22,
                      color: selectedSize == 'M' 
                          ? Colors.white 
                          : theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  Text(
                    '350 мл',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'G',
                      fontSize: 16,
                      color: selectedSize == 'M' 
                          ? Colors.white.withOpacity(1) 
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
              ),
              child: Column(
                children: [
                  Text(
                    'L',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontFamily: 'G',
                      fontSize: 22,
                      color: selectedSize == 'L' 
                          ? Colors.white 
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '450 мл',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'G',
                      fontSize: 16,
                      color: selectedSize == 'L' 
                          ? Colors.white.withOpacity(1) 
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
        {'name': 'Капучино', 'price': 250, 'image': 'capuchino.jpg'},
        {'name': 'Пончик', 'price': 120, 'image': 'donat3.jpg'},
      ];
    }
    
    return SizedBox(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return Container(
          width: 150,
          margin: EdgeInsets.only(
            right: index < suggestions.length - 1 ? 15 : 0,
            left: index == 0 ? 0 : 0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  // Изображение
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/${suggestion['image']}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Текст
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          suggestion['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '${suggestion['price']} ₽',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                fontFamily: 'G',
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_circle,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
            padding: cart.isEmpty
            ?const EdgeInsets.only(right: 16, left: 20, bottom:15, top: 15)
            :const EdgeInsets.only(right: 16, left: 20, bottom:5, top: 5),
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
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontFamily: 'G',
                    fontSize: 22,
                  ),
                ),
                if (cart.isNotEmpty)
                  TextButton(
                    onPressed: onClearCart,
                    child: Text(
                      'Очистить', 
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontFamily: 'G',
                        fontSize: 17,
                        color:theme.colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Список товаров
          if (cart.isEmpty)
             Expanded(
              child: Center(
                child: Text('Корзина пуста', 
                style: theme.textTheme.headlineSmall?.copyWith(
                    fontFamily: 'G',
                    fontSize: 18,
                    color: theme.colorScheme.outline.withOpacity(0.9),
                  ),
                ),
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
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontFamily: 'G',
                          fontSize: 23,
                        ),
                      ),
                      Text(
                        '₽${total.toInt()}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'G',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // TODO: Переход к оформлению заказа
                      },
                      child:  Text('Оформить заказ',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'G',
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Изображение
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/images/${item['image']}'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          
          // Текст
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '${item['price']} ₽',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          
          // Счетчик
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => onQuantityChanged(item['quantity'] - 1),
                  icon: Icon(Icons.remove, color: theme.colorScheme.primary),
                  iconSize: 18,
                  padding: const EdgeInsets.all(6),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    item['quantity'].toString(),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => onQuantityChanged(item['quantity'] + 1),
                  icon: Icon(Icons.add, color: theme.colorScheme.primary),
                  iconSize: 18,
                  padding: const EdgeInsets.all(6),
                ),
              ],
            ),
          ),
        ],
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

