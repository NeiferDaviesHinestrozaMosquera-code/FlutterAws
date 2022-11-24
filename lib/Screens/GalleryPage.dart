import 'package:flutter/material.dart';

// 1
class GalleryPage extends StatelessWidget {

  // 2 Esta VoidCallback se conectará al método shouldLogOut en CameraFlow.

  final VoidCallback shouldLogOut;

  // 3 Esta VoidCallback actualizará el indicador _shouldShowCamera en CameraFlow

  final VoidCallback shouldShowCamera;

  GalleryPage({Key? key, required this.shouldLogOut, required this.shouldShowCamera})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        actions: [
          // 4 BOTON DE CERRAR SESION
          // Log Out Button
          Padding(
            padding: const EdgeInsets.all(8),
            child:
                GestureDetector(child: Icon(Icons.logout), onTap: shouldLogOut),
          )
        ],
      ),
      // 5 MOSTRAR LA CAMARA 
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt), onPressed: shouldShowCamera),
      body: Container(child: _galleryGrid()),
    );
  }

  Widget _galleryGrid() {
    // 6 MOSTRAR LAS IAMGENES
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 3,
        itemBuilder: (context, index) {
          // 7
          return Placeholder();
        });
  }
}