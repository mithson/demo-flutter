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
                        iconSize: 30,
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyListScreen()));
                        },
                      ),
                      myList.length == 0
                          ? Container()
                          : Positioned(
                              child: Stack(
                              children: <Widget>[
                                Icon(Icons.brightness_1,
                                    size: 25.0, color: Colors.white),
                                Positioned(
                                    top: 5.0,
                                    right: 5.5,
                                    child: Center(
                                      child: Text(
                                        myList.length.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
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
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
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
                                  ? Colors.white
                                  : Colors.black,
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
                          icon: myList.contains(currentProduct)
                              ? Icon(
                                  Icons.remove_circle_outline_rounded,
                                  color: Colors.red,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: Colors.black,
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
