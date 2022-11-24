import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutteraws/Screens/CameraPage.dart';
import 'package:flutteraws/Screens/GalleryPage.dart';

class CameraFlow extends StatefulWidget {

  // 1 ESTO SE ACTIVA CUANDO EL USUARIO CERRA SESION
  final VoidCallback shouldLogOut;

  CameraFlow({Key? key, required this.shouldLogOut}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraFlowState();
}

class _CameraFlowState extends State<CameraFlow> {

  late CameraDescription _camera; //XXXX
  
  // 2 ES PARA MOSTRAR O NO LA CAMARA 
  bool _shouldShowCamera = false;

  // 3 MARCADOR DE POSICION
  List<MaterialPage> get _pages {
    return [
      // Show Gallery Page
      MaterialPage(
    child: GalleryPage(
        shouldLogOut: widget.shouldLogOut,
        shouldShowCamera: () => _toggleCameraOpen(true))),


      // Show Camera Page
      if (_shouldShowCamera) 
      MaterialPage(
   child: CameraPage(
       camera: _camera,
       didProvideImagePath: (imagePath) {
         this._toggleCameraOpen(false);
       }))
    ];
  }

  @override
  Widget build(BuildContext context) {
    // 4
    return Navigator(
      pages: _pages,
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  //esta función tan pronto como se inicialice _CameraFlowState.

  @override
  void initState() {
  super.initState();
  _getCamera();
  }


  // 5 PARA MOSTRAR LA CAMARA O NO
  void _toggleCameraOpen(bool isOpen) {
    setState(() {
      this._shouldShowCamera = isOpen;
    });
  }

  //6 INICIALIZAR LA CAMARA 
  void _getCamera() async {
  final camerasList = await availableCameras();
  setState(() {
    final firstCamera = camerasList.first;
    this._camera = firstCamera;
  });
}
}