import 'package:examen_final/models/proveedores.dart';
import 'package:examen_final/services/proveedor_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgregarProveedorScreen extends StatefulWidget {
  @override
  _AgregarProveedorScreenState createState() => _AgregarProveedorScreenState();
}

class _AgregarProveedorScreenState extends State<AgregarProveedorScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  bool _estado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Proveedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre del proveedor'),
            ),
            TextField(
              controller: _apellidoController,
              decoration: InputDecoration(labelText: 'Apellido del proveedor'),
            ),
            TextField(
              controller: _correoController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            SwitchListTile(
              title: Text('Estado Activo, Inactivo'),
              value: _estado,
              onChanged: (value) {
                setState(() {
                  _estado = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _agregarProveedor(context),
              child: Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }

  void _agregarProveedor(BuildContext context) {
    final String nombre = _nombreController.text.trim();
    final String apellido = _apellidoController.text.trim();
    final String correo = _correoController.text.trim();

    if (nombre.isNotEmpty && apellido.isNotEmpty && correo.isNotEmpty) {
      final ProveedorItem nuevoProveedor = ProveedorItem(
        providerId: 0,
        providerName: nombre,
        providerLastName: apellido,
        providerMail: correo,
        providerState: _estado ? 'Activo' : 'Inactivo',
      );

      Provider.of<ProveedorService>(context, listen: false)
          .createProveedor(nuevoProveedor);

      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, completa todos los campos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }
}
