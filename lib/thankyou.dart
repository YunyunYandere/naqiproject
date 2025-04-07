import 'package:flutter/material.dart';
import 'package:naqiuddin/welcome.dart';

class Thankyou extends StatefulWidget {
  const Thankyou({super.key});

  @override
  State<Thankyou> createState() => _ThankyouState();
}

class _ThankyouState extends State<Thankyou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(child:
            Text('Thank You For Your Registration!', ),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WelcomePage()));
                }, child: Text('Home')),
          ],
        ),
      ),
    );
  }
}
