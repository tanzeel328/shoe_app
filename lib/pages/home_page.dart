import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_app/global_variables.dart';
import 'package:shoe_app/models/products.dart';
import 'package:shoe_app/pages/cart_page.dart';
import 'package:shoe_app/pages/profile_page.dart';
import 'package:shoe_app/widgets/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Widget> pages = const [
    ProductList(),
    CartPage(),
    ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }

  // void getData() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   products = await getAllProducts();
  //   print(products);
  // }


}
