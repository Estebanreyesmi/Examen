import 'package:examen_final/models/categoria.dart';
import 'package:examen_final/screen/loading_screen.dart';
import 'package:examen_final/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCategoriaScreen extends StatelessWidget {
  const ListCategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriaService = Provider.of<CategoriaService>(context);
    if (categoriaService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de categorías'),
      ),
      body: ListView.builder(
        itemCount: categoriaService.categorias.length,
        itemBuilder: (BuildContext context, index) {
          final categoria = categoriaService.categorias[index];
          return ListTile(
            title: Text(categoria.categoryName),
            subtitle: Text(categoria.categoryState),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    categoriaService.selectedCategoria = categoria;
                    Navigator.pushNamed(context, 'editcat');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Eliminar la categoría seleccionada
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Eliminar Categoría'),
                        content: Text(
                            '¿Estás seguro de que deseas eliminar esta categoría?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Cierra el cuadro de diálogo sin hacer nada
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Confirma la eliminación de la categoría
                              categoriaService.deleteCategoria(
                                  categoria, context);
                              Navigator.of(context)
                                  .pop(); // Cierra el cuadro de diálogo
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
            onTap: () {
              // Realizar acciones adicionales al tocar el ListTile si es necesario
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          categoriaService.selectedCategoria =
              CategoriaItem(categoryId: 0, categoryName: '', categoryState: '');
          Navigator.pushNamed(context, 'addcat');
        },
      ),
    );
  }
}
