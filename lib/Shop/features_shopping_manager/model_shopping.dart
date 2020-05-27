import 'package:flutter/material.dart';

class ShoppingItem {

  ShoppingItem({
      this.id, 
      this.title, 
      this.price, 
      this.color
    });

  final int id;
  final String title;
  final double price;
  final Color color;
}