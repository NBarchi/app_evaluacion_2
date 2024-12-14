import 'package:app_evaluacion_2/screens/citasScreen.dart';
import 'package:app_evaluacion_2/screens/serviciosScreen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'App Medica',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Citas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Citasscreen()),
              );
            },
          ),
          ListTile(
            title: Text('Servicios'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Serviciosscreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
