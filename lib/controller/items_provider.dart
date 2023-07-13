import 'package:flutter/material.dart';
import 'package:todo_bootcamp/models/item_modal.dart';
import 'package:todo_bootcamp/network/end_point.dart';
import 'package:todo_bootcamp/network/network_manager.dart';

class ItemProvider extends ChangeNotifier {
  List<ItemsModal> items = [];
  bool itemLoaded = false;

  void getAllItems() async {
    var response = await NetworkManager().getDio().get(Endpoints.getAllItem);

    if (response.statusCode == 200) {
      items = List<ItemsModal>.from(
          response.data.map((e) => ItemsModal.fromJson(e)));
      itemLoaded = true;
    } else {
      itemLoaded = true;
    }
    notifyListeners();
  }

  void deleteItem(String id, context) async {
    var response =
        await NetworkManager().getDio().delete("${Endpoints.getAllItem}/$id");

    if (response.statusCode == 200) {
      getAllItems();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Item Deleted",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        duration: Duration(seconds: 2),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Something went wrong",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        duration: Duration(seconds: 2),
      ));
    }
    notifyListeners();
  }

  void addItem(String id, String name, String price, context) async {
    var data = {"id": id, "name": name, "price": int.parse(price)};
    var response =
        await NetworkManager().getDio().put(Endpoints.getAllItem, data: data);

    if (response.statusCode == 200) {
      getAllItems();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "List Updated",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        duration: Duration(seconds: 2),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Something went wrong",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        duration: Duration(seconds: 2),
      ));
    }
    notifyListeners();
  }
}
