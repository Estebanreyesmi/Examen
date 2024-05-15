import 'package:examen_final/models/proveedores.dart';
import 'package:examen_final/screen/loading_screen.dart';
import 'package:examen_final/services/proveedor_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProveedorScreen extends StatelessWidget {
  const ListProveedorScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);
    if (proveedorService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Proveedores'),
      ),
      body: ListView.builder(
        itemCount: proveedorService.proveedores.length,
        itemBuilder: (BuildContext context, index) {
          final proveedor = proveedorService.proveedores[index];
          return ListTile(
            title: Text(proveedor.providerName),
            subtitle: Text(proveedor.providerState),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    proveedorService.selectedProveedor = proveedor;
                    Navigator.pushNamed(context, 'editprov');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Eliminar Proveedor'),
                        content: Text(
                            '¿Estás seguro de que deseas eliminar este proveedor?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              proveedorService.deleteProveedor(
                                  proveedor, context);
                              Navigator.of(context).pop();
                            },
                            child: Text('Eliminar'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          proveedorService.selectedProveedor = ProveedorItem(
              providerId: 0,
              providerName: '',
              providerLastName: '',
              providerMail: '',
              providerState: 'Activo');
          Navigator.pushNamed(context, 'addprov');
        },
      ),
    );
  }
}
