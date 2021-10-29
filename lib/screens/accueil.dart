import 'package:e_pay/screens/home.dart';
import 'package:e_pay/screens/panier.dart';
import 'package:e_pay/screens/profil.dart';
import 'package:flutter/material.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {




  List<Widget> widgetList = [
    const HomePage(),
    const PanierPage(),
    const ProfilPage(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[50],
        elevation: 20,
        fixedColor: Colors.cyan,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('Accueil'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('panier'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 32,
            ),
            // ignore: deprecated_member_use
            title: Text('Profile'),
          ),
        ],
        onTap: (int index) {
          setState(() {
            widgetList[index];
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
