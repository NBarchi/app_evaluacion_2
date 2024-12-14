import 'dart:convert';
import 'package:app_evaluacion_2/navigators/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Serviciosscreen extends StatelessWidget {
  const Serviciosscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicios"),
      ),
      drawer: CustomDrawer(),
      body: servicios_listv("https://jritsqmet.github.io/web-api/medico.json"),
    );
  }
}

Future<List> jsonExterno(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final dataTemp = jsonDecode(response.body);
    return dataTemp['servicio_medico'];
  } else {
    throw Exception("Error de conexión");
  }
}

// ignore: non_constant_identifier_names
Widget servicios_listv(String url) {
  return FutureBuilder(
    future: jsonExterno(url),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final data = snapshot.data!;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(
              title: Text(item['nombre']),
              subtitle: Text('Proveedor: ${item['proveedor']['nombre']}'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(item['nombre']),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Proveedor: ${item['proveedor']['nombre']}'),
                            Text('Ubicación: ${item['proveedor']['ubicacion']['ciudad']}, ${item['proveedor']['ubicacion']['pais']}'),
                            Text('Horario: ${item['horario']}'),
                            const SizedBox(height: 8),
                            Text(item['descripcion']),
                            const SizedBox(height: 8),
                            Image.network(item['info']['imagen']),
                            const SizedBox(height: 8),
                            Text('Precio: ${item['info']['precio']}'),
                            Text('Duración: ${item['info']['duracion']}'),
                            const SizedBox(height: 8),
                            Text('Contacto: ${item['contacto']['telefono']}'),
                            Text('Email: ${item['contacto']['email']}'),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      } else {
        return Text('No hay data');
      }
    },
  );
}
