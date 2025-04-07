import 'package:flutter/material.dart';
import 'package:naqiuddin/thankyou.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            Text('Register Now', ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name'
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email'
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone No.'
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Adrreees'
                ),
              )),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Thankyou()));
                }, child: Text('Regiter')),
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Back')
            ),
          ],

        ),
      ),
    );
  }
}
