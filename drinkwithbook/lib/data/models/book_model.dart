class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String image;
  final String genre;
  final double rating;
  final int pages;
  final String isbn;
  final double price;
  final bool isAvailable;
  final DateTime publishedDate;
  final String? publisher;
  final List<String>? tags;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.image,
    required this.genre,
    required this.rating,
    required this.pages,
    required this.isbn,
    required this.price,
    required this.isAvailable,
    required this.publishedDate,
    this.publisher,
    this.tags,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      genre: json['genre'] as String,
      rating: (json['rating'] as num).toDouble(),
      pages: json['pages'] as int,
      isbn: json['isbn'] as String,
      price: (json['price'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool,
      publishedDate: DateTime.parse(json['publishedDate'] as String),
      publisher: json['publisher'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'image': image,
      'genre': genre,
      'rating': rating,
      'pages': pages,
      'isbn': isbn,
      'price': price,
      'isAvailable': isAvailable,
      'publishedDate': publishedDate.toIso8601String(),
      'publisher': publisher,
      'tags': tags,
    };
  }
}

// Примеры книг для рекламы
class BookData {
  static List<Book> get featuredBooks => [
    Book(
      id: 'book_1',
      title: '1984',
      author: 'Джордж Оруэлл',
      description: 'Антиутопический роман о тоталитарном обществе, где каждый шаг человека контролируется Большим Братом.',
      image: 'book1.jpg',
      genre: 'Антиутопия',
      rating: 4.5,
      pages: 328,
      isbn: '978-5-17-103633-9',
      price: 450.0,
      isAvailable: true,
      publishedDate: DateTime(1949),
      publisher: 'АСТ',
      tags: ['классика', 'антиутопия', 'политика'],
    ),
    Book(
      id: 'book_2',
      title: 'Мастер и Маргарита',
      author: 'Михаил Булгаков',
      description: 'Мистический роман о добре и зле, любви и предательстве, действие которого разворачивается в Москве 1930-х годов.',
      image: 'book2.jpg',
      genre: 'Мистика',
      rating: 4.8,
      pages: 512,
      isbn: '978-5-17-103634-6',
      price: 520.0,
      isAvailable: true,
      publishedDate: DateTime(1967),
      publisher: 'АСТ',
      tags: ['классика', 'мистика', 'любовь'],
    ),
    Book(
      id: 'book_3',
      title: 'Сто лет одиночества',
      author: 'Габриэль Гарсиа Маркес',
      description: 'Эпический роман о семье Буэндиа и городе Макондо, написанный в стиле магического реализма.',
      image: 'book3.jpg',
      genre: 'Магический реализм',
      rating: 4.7,
      pages: 448,
      isbn: '978-5-17-103635-3',
      price: 480.0,
      isAvailable: true,
      publishedDate: DateTime(1967),
      publisher: 'АСТ',
      tags: ['классика', 'магический реализм', 'семья'],
    ),
    Book(
      id: 'book_4',
      title: 'Война и мир',
      author: 'Лев Толстой',
      description: 'Эпический роман о войне 1812 года и жизни русского общества начала XIX века.',
      image: 'book4.jpg',
      genre: 'Классическая литература',
      rating: 4.6,
      pages: 1274,
      isbn: '978-5-17-103636-0',
      price: 650.0,
      isAvailable: true,
      publishedDate: DateTime(1869),
      publisher: 'АСТ',
      tags: ['классика', 'история', 'война'],
    ),
    Book(
      id: 'book_5',
      title: 'Преступление и наказание',
      author: 'Федор Достоевский',
      description: 'Психологический роман о студенте Раскольникове, который совершает убийство и переживает муки совести.',
      image: 'book5.jpg',
      genre: 'Психологический роман',
      rating: 4.9,
      pages: 608,
      isbn: '978-5-17-103637-7',
      price: 420.0,
      isAvailable: true,
      publishedDate: DateTime(1866),
      publisher: 'АСТ',
      tags: ['классика', 'психология', 'преступление'],
    ),
    Book(
      id: 'book_6',
      title: 'Анна Каренина',
      author: 'Лев Толстой',
      description: 'Роман о трагической любви замужней женщины Анны Карениной к офицеру Вронскому.',
      image: 'book6.jpg',
      genre: 'Классическая литература',
      rating: 4.4,
      pages: 864,
      isbn: '978-5-17-103638-4',
      price: 580.0,
      isAvailable: true,
      publishedDate: DateTime(1877),
      publisher: 'АСТ',
      tags: ['классика', 'любовь', 'семья'],
    ),
  ];

  static List<Book> get newReleases => [
    Book(
      id: 'book_7',
      title: 'Книга кофе',
      author: 'Джеймс Хоффман',
      description: 'Полное руководство по приготовлению идеального кофе в домашних условиях.',
      image: 'book7.jpg',
      genre: 'Кулинария',
      rating: 4.8,
      pages: 256,
      isbn: '978-5-17-103639-1',
      price: 1200.0,
      isAvailable: true,
      publishedDate: DateTime(2023),
      publisher: 'Манн, Иванов и Фербер',
      tags: ['кофе', 'кулинария', 'руководство'],
    ),
    Book(
      id: 'book_8',
      title: 'Искусство чтения',
      author: 'Мортимер Адлер',
      description: 'Классическое руководство по эффективному чтению и пониманию текстов.',
      image: 'book8.jpg',
      genre: 'Образование',
      rating: 4.6,
      pages: 320,
      isbn: '978-5-17-103640-7',
      price: 680.0,
      isAvailable: true,
      publishedDate: DateTime(2023),
      publisher: 'Альпина Паблишер',
      tags: ['чтение', 'образование', 'навыки'],
    ),
  ];

  static List<Book> get bestsellers => [
    Book(
      id: 'book_9',
      title: 'Атлант расправил плечи',
      author: 'Айн Рэнд',
      description: 'Философский роман о капитализме, индивидуализме и роли государства в экономике.',
      image: 'book9.jpg',
      genre: 'Философская проза',
      rating: 4.2,
      pages: 1168,
      isbn: '978-5-17-103641-4',
      price: 750.0,
      isAvailable: true,
      publishedDate: DateTime(1957),
      publisher: 'Альпина Паблишер',
      tags: ['философия', 'капитализм', 'экономика'],
    ),
    Book(
      id: 'book_10',
      title: 'Маленький принц',
      author: 'Антуан де Сент-Экзюпери',
      description: 'Философская сказка о маленьком принце, который путешествует по разным планетам.',
      image: 'book10.jpg',
      genre: 'Философская сказка',
      rating: 4.9,
      pages: 96,
      isbn: '978-5-17-103642-1',
      price: 350.0,
      isAvailable: true,
      publishedDate: DateTime(1943),
      publisher: 'АСТ',
      tags: ['сказка', 'философия', 'детство'],
    ),
  ];
}