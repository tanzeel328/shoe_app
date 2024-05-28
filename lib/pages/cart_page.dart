import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/models/orderz.dart';
import 'package:shoe_app/providers/cart_provider.dart';
import 'package:shoe_app/services/database_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;

    // Function to calculate total price
    int calculateTotalPrice() {
      int total = 0;
      for (var item in cart) {
        total += item['price'] as int;
      }
      return total;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cartItem = cart[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                    radius: 30,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Delete Product',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: const Text(
                              'Are you sure you want to remove the product from your cart?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<CartProvider>()
                                      .removeProduct(cartItem);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  title: Text(
                    cartItem['title'].toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Size: ${cartItem['size']}'),
                      Text('PKR ${cartItem['price']}'),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price: PKR ${calculateTotalPrice()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MaterialButton(
                  textColor: Colors.black,
                  color: const Color.fromRGBO(254, 206, 1, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {
                    print(cart);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Order'),
                          content: TextField(
                            controller: addressController,
                            decoration: const InputDecoration(
                                hintText: 'Enter Address'),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                Orderz order = Orderz(
                                  address: addressController.text,
                                  orderTime: Timestamp.now(),
                                  productz: cart.map((item) {
                                    return {
                                      'title': item['title'] as Object,
                                      'price': item['price'] as Object,
                                      'size': item['size'] as Object,
                                    };
                                  }).toList(),
                                  total: calculateTotalPrice(),
                                );
                                _databaseService.addOrder(order);

                                // print(cartz);
                                Navigator.of(context).pop();
                                addressController.clear();
                              },
                              color: Theme.of(context).colorScheme.primary,
                              textColor: Colors.white,
                              child: const Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Confirm Order',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
