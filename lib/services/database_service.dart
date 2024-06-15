import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoe_app/models/orderz.dart';
import 'package:shoe_app/models/products.dart';

const String ORDER_Collection_REF = 'order';
const String PRODUCTS_COLLECTION_REF = 'products';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _orderRef;

  DatabaseService() {
    _orderRef =
        _firestore.collection(ORDER_Collection_REF).withConverter<Orderz>(
            fromFirestore: (snapshots, _) => Orderz.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (order, _) => order.toJson());
  }

  void addOrder(Orderz order) async {
    _orderRef.add(order);
  }

  void updateOrder(String orderid, Orderz order) {
    _orderRef.doc(orderid).update(order.toJson());
  }
}

