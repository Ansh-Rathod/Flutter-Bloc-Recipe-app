import 'package:flutter/material.dart';

ListTile Nutritents({
  IconData icon,
  String text,
  String value,
}) {
  return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 35,
          color: Colors.orange,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        value,
        style: TextStyle(
            fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
      ));
}
