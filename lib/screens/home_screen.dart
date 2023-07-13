import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_bootcamp/controller/items_provider.dart';

import 'add_item.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context, listen: false);

    itemProvider.getAllItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<ItemProvider>(
          builder: (context, data, _) {
            if (data.itemLoaded == false && data.items.isEmpty) {
              return const CircularProgressIndicator();
            } else if (data.itemLoaded == true && data.items.isEmpty) {
              return const Text(
                "No Items",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: data.items.length,
                        itemBuilder: (context, index) {
                          var item = data.items[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Text(
                                          item.name ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text("Price: ${item.price ?? 0}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          constraints: const BoxConstraints(),
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return AddItem(
                                                name: item.name,
                                                price: item.price.toString(),
                                                id: item.id,
                                              );
                                            }));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            data.deleteItem(
                                                item.id ?? "", context);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red.withOpacity(0.8),
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints()),
                                    ],
                                  )
                                ]),
                          );
                        }),
                  )
                ],
              );
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddItem();
          }));
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
