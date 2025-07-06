import 'package:aplikasi_pemesanan/screenns/feedback_page.dart';
import 'package:aplikasi_pemesanan/screenns/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aplikasi_pemesanan/provider/cart_provider.dart';
import 'package:aplikasi_pemesanan/screenns/home_page.dart';
import 'package:aplikasi_pemesanan/screenns/home_restourant.dart';
import 'package:aplikasi_pemesanan/screenns/menu_detail_page.dart';
import 'package:aplikasi_pemesanan/screenns/splash_screen.dart';
import 'package:aplikasi_pemesanan/screenns/cart_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await initializeDateFormatting('id_ID', null);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: PesananMakanApp(),
    ),
  );
}


class PesananMakanApp extends StatelessWidget {
  const PesananMakanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PesanMakan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeRestaurantPage(),
        '/home_menu': (context) => HomePage(nama: 'Nama Pengguna'),
        '/menu-detail':
            (context) => MenuDetailPage(name: '', price: '', imagePath: ''),
        '/cart': (context) => CartPage(),
        '/user-info': (context) => UserInfoPage(),
        '/feedback': (context) => FeedbackPage(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/menu-detail') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder:
                (context) => MenuDetailPage(
                  name: args['name']!,
                  price: args['price']!,
                  imagePath: args['imagePath']!,
                ),
          );
        }
        return null;
      },
    );
  }
}
