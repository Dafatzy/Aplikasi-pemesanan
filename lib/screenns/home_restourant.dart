import 'package:aplikasi_pemesanan/screenns/pilihan_makanan.dart';
import 'package:aplikasi_pemesanan/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';

class HomeRestaurantPage extends StatefulWidget {
  const HomeRestaurantPage({super.key});

  @override
  _HomeRestaurantPageState createState() => _HomeRestaurantPageState();
}

class _HomeRestaurantPageState extends State<HomeRestaurantPage> {
  double _sliderValue = 10.0;
  String _searchQuery = '';

  final List<Map<String, dynamic>> _restaurants = [
    {
      'title': 'Paveda Kitchen Denai',
      'subtitle': 'Sebrang gedung putih',
      'distance': 0.01, 
    },
    {
      'title': 'Paveda Kitchen Kesawan',
      'subtitle': 'Depan Hotel healset',
      'distance': 3.5,
    },
    {
      'title': 'Paveda Kitchen Sunggal',
      'subtitle': 'gg. asmara pelangi PT.PDAM',
      'distance': 5.5,
    },
    {
      'title': 'Paveda Kitchen Helvetia',
      'subtitle': 'JL. Sumarsono',
      'distance': 7.5,
    },
  ];

  @override
  Widget build(BuildContext context) {

    final filteredRestaurants = _restaurants.where((restaurant) {
      final title = restaurant['title'].toString().toLowerCase();
      final distance = restaurant['distance'] as double;
      return title.contains(_searchQuery.toLowerCase()) &&
          distance <= _sliderValue;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.store_mall_directory, color: Color(0xFF1598A1)),
            SizedBox(width: 8),
            Text(
              'Pilih Lokasi Restoran',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Color(0xFF1598A1)),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari Restoran Terdekat...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.location_searching, color: Color(0xFF1598A1)),
                SizedBox(width: 8),
                Text(
                  'Radius: ${_sliderValue.toStringAsFixed(2)} km',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Slider(
            value: _sliderValue,
            min: 0.01,
            max: 10.0,
            divisions: 20,
            label: '${_sliderValue.toStringAsFixed(2)} km',
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
            activeColor: Color(0xFF1598A1),
            inactiveColor: Colors.grey[300],
          ),

          Divider(),

          ListTile(
            title: Text('Menu Makanan'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),

          Divider(),
          Expanded(
            child: ListView(
              children: filteredRestaurants.isNotEmpty
                  ? filteredRestaurants
                      .map((restaurant) => _buildRestaurantItem(
                            context,
                            title: restaurant['title'],
                            subtitle: restaurant['subtitle'],
                            distance: restaurant['distance'],
                          ))
                      .toList()
                  : [
                      ListTile(
                        leading: Icon(Icons.location_off, color: Colors.grey),
                        title: Text('Tidak ditemukan...'),
                        subtitle: Text(
                            'Coba perbesar jarak pencarian atau ubah kata kunci.'),
                        trailing: Icon(Icons.more_horiz, color: Colors.grey),
                      ),
                    ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
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
    );
  }

  Widget _buildRestaurantItem(BuildContext context,
      {required String title,
      required String subtitle,
      required double distance}) {
    return ListTile(
      leading: Icon(Icons.location_on, color: Color(0xFF1598A1)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text('${distance.toStringAsFixed(2)} km'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PilihanMakanPage(lokasi: title),
          ),
        );
      },
    );
  }
}
