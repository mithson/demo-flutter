import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../provider/product_provider.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({Key? key}) : super(key: key);

  @override
  _MyListScreenState createState() => _MyListScreenState();
}

var product = Product();

class _MyListScreenState extends State<MyListScreen> {
  @override
  Widget build(BuildContext context) {
    final _myList = context.watch<ProductProvider>().myList;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart "),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ListView.builder(
                physics: BouncingScrollPhysics(),
                // scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _myList.length,
                itemBuilder: (_, index) {
                  final currentProduct = _myList[index];
                  int currentPrice = currentProduct.price!;

                  // print(currentTotal);
                  // final currentPrice = _myList[index].price;
                  return Card(
                    key: ValueKey(currentProduct.title),
                    elevation: 4,
                    child: ListTile(
                      title: Text(currentProduct.title!),
                      subtitle: Text(
                        'Rs. ${currentPrice.toString()}',
                      ),
                      trailing: OutlinedButton(
                        child: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context
                              .read<ProductProvider>()
                              .removeFromList(currentProduct);
                          total = total! - currentPrice;
                        },
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              width: 230,
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.black, Colors.black]),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    height: 50,
                    minWidth: double.infinity,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.black87,
                          width: MediaQuery.of(context).size.width - 80,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Successful Payment",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )));
                    },
                    child: Text(
                      "Total Payment: $total",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 150,
            ),
          ]),
        ),
      ),
    );
  }
}
