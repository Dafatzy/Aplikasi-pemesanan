import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpandableFAB extends StatelessWidget {
  const ExpandableFAB({Key? key}) : super(key: key);

  void _goToCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  void _goToFeedback(BuildContext context) {
    Navigator.pushNamed(context, '/feedback');
  }

  Future<void> _goToUserInfo(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final orderType = prefs.getString('orderType') ?? 'Makan di Tempat';
    final detail = prefs.getString('detail') ?? 'Meja 1';
    Navigator.pushNamed(context, '/user-info', arguments: {
      'orderType': orderType,
      'detail': detail,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: Color(0xFF1598A1),
      children: [
        SpeedDialChild(
          child: Icon(Icons.shopping_cart),
          label: 'Keranjang',
          backgroundColor: Colors.blue,
          onTap: () => _goToCart(context),
        ),
        SpeedDialChild(
          child: Icon(Icons.feedback),
          label: 'Feedback',
          backgroundColor: Colors.orange,
          onTap: () => _goToFeedback(context),
        ),
        SpeedDialChild(
          child: Icon(Icons.person),
          label: 'User Info',
          backgroundColor: Colors.green,
          onTap: () => _goToUserInfo(context),
        ),
      ],
    );
  }
}
