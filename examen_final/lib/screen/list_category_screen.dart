import 'package:examen_final/models/categoria.dart';
import 'package:examen_final/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriaScreen extends StatelessWidget {
  const CategoriaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<CategoriaService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
      ),
      body: Consumer<CategoriaService>(
        builder: (context, categoriaService, _) {
          if (categoriaService.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: categoriaService.categorias.length,
              itemBuilder: (context, index) {
                final categoria = categoriaService.categorias[index];
                return _buildCategoriaItem(categoria);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildCategoriaItem(CategoriaItem categoria) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ID: ${categoria.categoryId}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Nombre: ${categoria.categoryName}'),
          Text('Estado: ${categoria.categoryState}'),
          SizedBox(height: 8),
          Divider(),
        ],
      ),
    );
  }
}
