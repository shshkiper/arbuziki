import 'package:flutter/material.dart';
import '../../data/models/book_model.dart';

class BookAdModal extends StatefulWidget {
  final VoidCallback? onViewBooks;

  const BookAdModal({
    super.key,
    this.onViewBooks,
  });

  @override
  State<BookAdModal> createState() => _BookAdModalState();
}

class _BookAdModalState extends State<BookAdModal> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.85,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.outline.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Рекомендуем почитать',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontFamily: 'G',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          // Page indicator
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _getBookCategories().length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),

          // Book categories
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _getBookCategories().length,
              itemBuilder: (context, index) {
                final category = _getBookCategories()[index];
                return _buildBookCategory(category, theme);
              },
            ),
          ),

          // Action buttons
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // View all books button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onViewBooks?.call();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Посмотреть все книги',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontFamily: 'G',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getBookCategories() {
    return [
      {
        'title': 'Классика',
        'books': BookData.featuredBooks.take(3).toList(),
        'icon': Icons.menu_book_rounded,
      },
      {
        'title': 'Новинки',
        'books': BookData.newReleases,
        'icon': Icons.new_releases_rounded,
      },
      {
        'title': 'Бестселлеры',
        'books': BookData.bestsellers,
        'icon': Icons.star_rounded,
      },
    ];
  }

  Widget _buildBookCategory(Map<String, dynamic> category, ThemeData theme) {
    final books = category['books'] as List<Book>;
    final title = category['title'] as String;
    final icon = category['icon'] as IconData;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Row(
            children: [
              Icon(
                icon,
                color: theme.colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontFamily: 'G',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Books list
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return _buildBookCard(book, theme);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Book book, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Book cover
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/images/${book.image}'),
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

          // Book info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  book.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: 'G',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Author
                Text(
                  book.author,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: 'G',
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),

                const SizedBox(height: 8),

                // Description
                Text(
                  book.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'G',
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    height: 1.3,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 12),

                // Rating and price
                Row(
                  children: [
                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          book.rating.toString(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontFamily: 'G',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Price
                    Text(
                      '${book.price.toInt()} ₽',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontFamily: 'G',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Genre tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    book.genre,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'G',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
