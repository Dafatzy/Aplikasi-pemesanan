import 'package:aplikasi_pemesanan/models/cart_item.dart';
import 'package:aplikasi_pemesanan/screenns/expandable_fab.dart';
import 'package:aplikasi_pemesanan/screenns/feedback_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:aplikasi_pemesanan/provider/cart_provider.dart';
import 'package:aplikasi_pemesanan/screenns/menu_detail_page.dart';
import 'package:aplikasi_pemesanan/widget/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  final String nama;
  const HomePage({super.key, required this.nama});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> carouselImages = [
    'assets/banner1.png',
    'assets/banner2.png',
    'assets/banner3.png',
  ];

  final List<Map<String, String>> foods = [
    {
      'name': 'Bakso Urat Komplit',
      'price': 'Rp. 20000',
      'image': 'assets/bakso.png', // tanpa ../
      'category': 'Makanan',
    },
    {
      'name': 'Nasi Goreng Kampung Spesial',
      'price': 'Rp. 28000',
      'image': 'assets/nasigoreng.png',
      'category': 'Makanan',
    },
    {
      'name': 'Ayam Bakar',
      'price': 'Rp. 36000',
      'image': 'assets/ayambakar.png',
      'category': 'Makanan',
    },
    {
      'name': 'Ayam Bakar Bu Endang',
      'price': 'Rp. 24000',
      'image': 'assets/ayambakar.png',
      'category': 'Makanan',
    },
    {
      'name': 'Lemon Squash',
      'price': 'Rp. 20000',
      'image': 'assets/minuman.jpg',
      'category': 'Minuman',
    },
    {
      'name': 'Coklat Smotiesh',
      'price': 'Rp. 22000',
      'image': 'assets/minuman2.jpg',
      'category': 'Minuman',
    },
    {
      'name': 'Desert Anmitsu',
      'price': 'Rp. 25000',
      'image': 'assets/desert1.jpg',
      'category': 'Desert',
    },
    {
      'name': 'Desert Box Tiramisu',
      'price': 'Rp. 19000',
      'image': 'assets/desert2.jpg',
      'category': 'Desert',
    },
  ];

  List<Map<String, String>> filteredFoods = [];
  String searchQuery = '';
  bool showBanner = true;
  final double _maxPrice = 100000;

  final List<String> categories = ['Semua', 'Makanan', 'Minuman', 'Desert'];
  String selectedCategory = 'Semua';

  String selectedJob = 'Paling relevan';
  final List<String> jobs = [
    'Paling relevan',
    'Paling enak',
    'Paling Favorite',
    'Paling baru',
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    filteredFoods = foods;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      _filterFoods();
    });
  }

  void _filterFoods() {
    setState(() {
      filteredFoods =
          foods.where((food) {
            final name = food['name']!.toLowerCase();
            final category = food['category']!;
            final priceStr = food['price']!.replaceAll(RegExp(r'[^0-9]'), '');
            final price = int.tryParse(priceStr) ?? 0;

            final matchesSearch = name.contains(searchQuery);
            final matchesPrice = price <= _maxPrice.toInt();
            final matchesCategory =
                selectedCategory == 'Semua' || selectedCategory == category;

            return matchesSearch && matchesPrice && matchesCategory;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Selamat Memesan, ${widget.nama}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          Stack(
            children: [
              Tooltip(
                message: 'Lihat Keranjang',
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Color(0xFF1598A1)),
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Consumer<CartProvider>(
                  builder:
                      (_, cart, __) =>
                          cart.itemCount > 0
                              ? Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${cart.itemCount}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                              : SizedBox.shrink(),
                ),
              ),
            ],
          ),
          Builder(
            builder:
                (context) => IconButton(
                  icon: Icon(Icons.menu, color: Color(0xFF1598A1)),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1598A1)),
              child: Row(
                children: [
                  Icon(Icons.account_circle, size: 40, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Pelanggan',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(title: Text('Info Meja'), onTap: () {}),
            ListTile(title: Text('Riwayat Pemesanan'), onTap: () {}),
            ListTile(title: Text('Riwayat Restoran'), onTap: () {}),
            ListTile(title: Text('Bantuan'), onTap: () {}),
            ListTile(title: Text('Tentang Aplikasi'), onTap: () {}),
            ListTile(
              title: Text('Feedback'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showBanner)
                MaterialBanner(
                  content: Text(
                    '🎉 Promo Hari Ini! Diskon 20% untuk pembelian Dessert 🍰',
                  ),
                  leading: Icon(Icons.local_offer, color: Colors.white),
                  backgroundColor: Color(0xFF1598A1),
                  contentTextStyle: TextStyle(color: Colors.white),
                  actions: [
                    TextButton(
                      onPressed: () => setState(() => showBanner = false),
                      child: Text(
                        'Tutup',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 12),
              CarouselSlider(
                options: CarouselOptions(
                  height: 160,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 3),
                ),
                items:
                    carouselImages.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        },
                      );
                    }).toList(),
              ),
              SizedBox(height: 8),
              TextField(
                onChanged: updateSearch,
                decoration: InputDecoration(
                  hintText: 'Cari Makanan Favoritmu',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      categories
                          .map((category) => _buildCategoryButton(category))
                          .toList(),
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menu Makanan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedJob,
                    items:
                        jobs.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedJob = newValue!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredFoods.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final food = filteredFoods[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.asset(
                            food['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    Container(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(food['name']!),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(food['price']!),
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1598A1),
                            ),
                            onPressed: () {
                              Provider.of<CartProvider>(
                                context,
                                listen: false,
                              ).addToCart(
                                CartItem(
                                  name: food['name']!,
                                  price: food['price']!,
                                  imagePath: food['image']!,
                                  quantity: 1,
                                  subtotal: '',
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${food['name']} ditambahkan ke pesanan!',
                                  ),
                                  backgroundColor: Color(0xFF1598A1),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => MenuDetailPage(
                                        name: food['name']!,
                                        price: food['price']!,
                                        imagePath: food['image']!,
                                      ),
                                ),
                              );
                            },
                            child: Text(
                              'Tambah',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/user-info');
              break;
          }
        },
      ),
      floatingActionButton: ExpandableFAB(),
    );
  }

  Widget _buildCategoryButton(String label) {
    final isSelected = selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Color(0xFF1598A1) : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          shape: StadiumBorder(),
        ),
        onPressed: () {
          setState(() {
            selectedCategory = label;
            _filterFoods();
          });
        },
        child: Text(label),
      ),
    );
  }
}
