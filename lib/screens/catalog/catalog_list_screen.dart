import 'package:flutter/material.dart';

class CatalogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: new List.generate(
            5,
            (i) => new ListTileItem(
                  title: "Item#$i",
                )),
      ),
    );
  }
}

class ListTileItem extends StatefulWidget {
  String? title;
  ListTileItem({this.title});
  @override
  _ListTileItemState createState() => new _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(widget.title!),
      trailing: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _itemCount != 0
              ? new IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => setState(() => _itemCount--),
                )
              : new Container(),
          new Text(_itemCount.toString()),
          new IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => setState(() => _itemCount++))
        ],
      ),
    );
  }
}
