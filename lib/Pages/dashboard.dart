
import 'package:flutter/material.dart';
import 'package:cat_1/Pages/home_page.dart';
import 'package:cat_1/Pages/shopping_cart_page.dart';
import 'package:cat_1/Pages/Chats.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int _selectedIndex = 0;
  var screenList = [
    Home(),
    ShoppingCartPage(),
    Chats()
  ];
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Add to Cart', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Chat', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      resizeToAvoidBottomInset: true,
      extendBody: false,
      body: Center(
        child: screenList[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text('Home'),
                backgroundColor: Colors.cyanAccent
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text('Cart'),
                backgroundColor: Colors.purple
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Chat'),
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 30,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          elevation: 5
      ),
    );
  }
}
