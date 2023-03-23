import 'package:flutter/material.dart';

class RouterPage extends StatelessWidget {
  const RouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Router')),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 2,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/reCut');
                break;
              case 1:
                Navigator.pushNamed(context, '/timer');
                break;
            }
          },
          child: Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black26,
              ),
            ),
            width: 50,
            height: 50,
            child: Text('${index + 1}'),
          ),
        ),
      ),
    );
  }
}
