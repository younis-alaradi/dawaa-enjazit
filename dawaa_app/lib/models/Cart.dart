import 'package:flutter/material.dart';

import 'Product.dart';
import 'Product.dart';

class Cart {
  final Product product;
  final int numOfItem;


  const Cart({@required this.product, @required this.numOfItem});
  static List<Cart> carts =[];
  static double total_price =0;
}


// Demo data for our cart


