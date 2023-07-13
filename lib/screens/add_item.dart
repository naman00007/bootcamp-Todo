import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_bootcamp/controller/items_provider.dart';

class AddItem extends StatelessWidget {
  String? name;
  String? price;
  String? id;
  AddItem({Key? key, this.name, this.price, this.id}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (name != null && price != null) {
      nameController.text = name ?? "";
      priceController.text = price ?? "";
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add - Item"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Name"),
            const SizedBox(
              height: 7,
            ),
            commonTextField(nameController, "Name"),
            const SizedBox(
              height: 20,
            ),
            commonText("Price"),
            const SizedBox(
              height: 7,
            ),
            commonTextField(priceController, "Price"),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text != "" &&
                          priceController.text != "") {
                        // update an item
                        if (name != null && price != null && id != null) {
                          Provider.of<ItemProvider>(context, listen: false)
                              .addItem(id ?? "", nameController.text,
                                  priceController.text, context);
                        }
                        // Create new item
                        else {
                          Provider.of<ItemProvider>(context, listen: false)
                              .addItem(
                                  Random().nextInt(100000).toString(),
                                  nameController.text,
                                  priceController.text,
                                  context);
                        }
                      } else {
                        ///Todo: Add condition when user does not added the name and price
                      }
                    },
                    child: commonText("Add Item")))
          ],
        ),
      ),
    );
  }

  Widget commonText(String txt) {
    return Text(
      txt,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    );
  }

  Widget commonTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      maxLength: hint == "Price" ? 10 : null,
      decoration: InputDecoration(
          hintText: hint,
          // labelText: hint,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          )),
    );
  }
}
