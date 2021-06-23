
import 'package:flutter/material.dart';

class fav_item extends StatelessWidget {
final List<String> favoriteItems;

const fav_item ({Key key, @required this.favoriteItems}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Favorites words'),
    ),
    body: ListView.separated(
      itemCount: favoriteItems.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(favoriteItems[index]),
      ),
    ),
  );
}
}