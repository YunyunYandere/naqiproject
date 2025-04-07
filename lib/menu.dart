import 'package:flutter/material.dart';
import 'package:naqiuddin/register.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Builder(
            builder: (context) {
              return Column(
                children: [
                  SizedBox(height: 30,),
                  Text('Dish'),
                  ListTile(leading: Image.network('src'), title: Text('Dish 1'),),
                  ListTile(leading: Image.network('src'), title: Text('Dish 12'),),
                  ListTile(leading: Image.network('src'), title: Text('Dish 3'),),
                  ListTile(leading: Image.network('src'), title: Text('Dish 4'),),
                  SizedBox(height: 30,),
                  Text('Regiter to buy.'),
                  SizedBox(height: 30,),
                  ElevatedButton(
                    child: Text('Register'),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage())
                      );
                    },
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, child: Text('Back'))
                ],
              );
            }
        ),
      ),
    );
  }
}
