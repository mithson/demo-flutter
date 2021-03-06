import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/product_provider.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider<ProductProvider>(
    child: const MyApp(),
    create: (_) => ProductProvider(), // Create a new ChangeNotifier object
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
