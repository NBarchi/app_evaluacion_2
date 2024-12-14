import 'package:app_evaluacion_2/screens/loginScreen.dart';
import 'package:app_evaluacion_2/screens/registerScreen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(Welcome());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Cuerpo(),
    );
  }
}


class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Nombre: Nicholas Barrera", style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),),
              Text("Usuario de Github: nbarchi", style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),),
              login_btn(context),
              register_btn(context)
            ],
          ),
        ),
      ),
    );
  }
}


Widget login_btn(context) {
  return FilledButton(
    onPressed: () => login(context),
    child: Text("Login", style: TextStyle(color: Colors.black),),
    style: TextButton.styleFrom(
      backgroundColor: Colors.yellow,
    ),
  );
}

void login(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Loginscreen()));
}

Widget register_btn(context) {
  return FilledButton(
    onPressed: () => register(context),
    child: Text("Register", style: TextStyle(color: Colors.black)),
    style: TextButton.styleFrom(
      backgroundColor: Colors.yellow,
    ),
  );
}


void register(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Registerscreen()));
}

