import 'package:demo/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
import 'my_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var products = context.watch<ProductProvider>().products;
    var myList = context.watch<ProductProvider>().myList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right: 50,
              top: 10,
              bottom: 10,
            ),
            child: Container(
                height: 150.0,
                width: 30.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyListScreen()));
                  },
                  child: Stack(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        onPressed: null,
                      ),
                      myList.length == 0
                          ? Container()
                          : Positioned(
                              child: Stack(
                              children: <Widget>[
                                Icon(Icons.brightness_1,
                                    size: 20.0, color: Colors.black),
                                Positioned(
                                    top: 3.0,
                                    right: 7.0,
                                    child: Center(
                                      child: Text(
                                        myList.length.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            )),
                    ],
                  ),
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyListScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.list_alt_rounded),
              label: Text(
                "View Cart items (${myList.length})",
                style: const TextStyle(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 20)),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    final currentProduct = products[index];
                    final currentPrice = products[index].price;
                    return Card(
                      key: ValueKey(currentProduct.title),
                      color: myList.contains(currentProduct)
                          ? Colors.black
                          : Colors.white,
                      elevation: 4,
                      child: ListTile(
                        title: Text(currentProduct.title!,
                            style: TextStyle(
                              color: myList.contains(currentProduct)
                                  ? Colors.black
                                  : Colors.white,
                            )),
                        subtitle: Text(
                          'Rs. ${currentPrice.toString()}',
                          style: TextStyle(
                            color: myList.contains(currentProduct)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline_rounded,
                            color: myList.contains(currentProduct)
                                ? Colors.black
                                : Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            if (!myList.contains(currentProduct)) {
                              context
                                  .read<ProductProvider>()
                                  .addToList(currentProduct);

                              total = total! + currentPrice!.toInt();
                            } else {
                              context
                                  .read<ProductProvider>()
                                  .removeFromList(currentProduct);
                              total = total! - currentPrice!.toInt();
                            }
                          },
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
