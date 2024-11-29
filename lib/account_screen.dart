import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AccountScreen();
  }
}

class _AccountScreen extends State<AccountScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Que souhaitez vous faire ?", style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/register',
                );
              },
              child: const Text('S\'inscrire'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/login',
                );
              },
              child: const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }   
}