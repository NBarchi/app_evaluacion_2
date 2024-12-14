import 'package:app_evaluacion_2/navigators/drawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Citasscreen extends StatefulWidget {
  const Citasscreen({super.key});

  @override
  _CitasscreenState createState() => _CitasscreenState();
}

class _CitasscreenState extends State<Citasscreen> {
  final _idController = TextEditingController();
  final _especialidadController = TextEditingController();
  final _diaController = TextEditingController();

  final DatabaseReference _citasRef = FirebaseDatabase.instance.ref("citas");


  Future<void> _guardarCita() async {
    String id = _idController.text;
    String especialidad = _especialidadController.text;
    String dia = _diaController.text;

    if (id.isNotEmpty && especialidad.isNotEmpty && dia.isNotEmpty) {
      try {
        // Crear un nuevo ID para la cita usando un push en Realtime Database
        DatabaseReference nuevaCitaRef = _citasRef.push();
        
        // Guardar la cita en la base de datos
        await nuevaCitaRef.set({
          'id': id,
          'especialidad': especialidad,
          'dia': dia,
        });

        // Limpiar los campos después de guardar
        _idController.clear();
        _especialidadController.clear();
        _diaController.clear();

        // Mostrar un mensaje de éxito
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cita guardada con exito'),
          content: const Text('La cita ha sido registrada'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar diálogo
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
      } catch (e) {
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('La cita no se registro'),
          content: const Text('La cita no fue registrada'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar diálogo
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Citas"),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ID de la cita
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID de la Cita',
              ),
            ),
            SizedBox(height: 20),
            
            // Especialidad
            TextField(
              controller: _especialidadController,
              decoration: InputDecoration(
                labelText: 'Especialidad',
              ),
            ),
            SizedBox(height: 20),
            
            // Día
            TextField(
              controller: _diaController,
              decoration: InputDecoration(
                labelText: 'Día de la Cita',
              ),
            ),
            SizedBox(height: 30),
            
            // Botón para guardar la cita
            ElevatedButton(
              onPressed: _guardarCita,
              child: const Text('Guardar Cita'),
            ),
          ],
        ),
      ),  
    );
  }
}
