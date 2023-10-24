import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('NewsApi'),
            Text(
              'TestApp',
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: const Text('News'),
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  final imageUrl, categorieName;
  const CategoryTitle({this.imageUrl, this.categorieName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
            Image.network(imageUrl, width: 120, height: 60,),
          ],
      ),
    );
  }
}
