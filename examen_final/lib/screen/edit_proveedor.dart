import 'package:examen_final/models/proveedores.dart';
import 'package:examen_final/services/proveedor_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProveedorScreen extends StatefulWidget {
  const EditProveedorScreen({Key? key}) : super(key: key);
  @override
  _EditProveedorScreenState createState() => _EditProveedorScreenState();
}

class _EditProveedorScreenState extends State<EditProveedorScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _correoController;
  late bool _estado;

  @override
  void initState() {
    super.initState();
    final proveedorService =
        Provider.of<ProveedorService>(context, listen: false);
    final selectedProveedor = proveedorService.selectedProveedor;
    _nombreController =
        TextEditingController(text: selectedProveedor?.providerName ?? '');
    _apellidoController =
        TextEditingController(text: selectedProveedor?.providerLastName ?? '');
    _correoController =
        TextEditingController(text: selectedProveedor?.providerMail ?? '');
    _estado = selectedProveedor?.providerState == 'Activo';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Proveedor'),
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
              value: _estado ?? false,
              onChanged: (value) {
                setState(() {
                  _estado = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _guardarCambios(context),
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  void _guardarCambios(BuildContext context) {
    final proveedorService =
        Provider.of<ProveedorService>(context, listen: false);
    final String nombre = _nombreController.text.trim();
    final String apellido = _apellidoController.text.trim();
    final String correo = _correoController.text.trim();
    final String estado = _estado ? 'Activo' : 'Inactivo';

    if (nombre.isNotEmpty && apellido.isNotEmpty && correo.isNotEmpty) {
      final ProveedorItem proveedorActualizado = ProveedorItem(
        providerId: proveedorService.selectedProveedor?.providerId ?? 0,
        providerName: nombre,
        providerLastName: apellido,
        providerMail: correo,
        providerState: estado,
      );

      proveedorService.updateProveedor(proveedorActualizado);

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

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _correoController.dispose();
    super.dispose();
  }
}
