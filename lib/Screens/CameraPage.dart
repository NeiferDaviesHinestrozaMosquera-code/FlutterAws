import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  // 1 TOMAR FOTOS
  final CameraDescription camera;
  // 2 RUTA PARA GUARDAR LA IAMGEN
  final ValueChanged didProvideImagePath;

  CameraPage({Key? key, required this.camera, required this.didProvideImagePath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // 3 INICIALIZAR LA INSTANCIA
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          // 4 VISTA PREVIA DE LA IMAGEN
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(this._controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // 5 ACTIVAR EL TAKEPICTURE
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera), onPressed: _takePicture),
    );
  }

  // 6 CREA UNA RUTA TEMPORAL DE LA IMAGEN
  void _takePicture() async {
    try {
      await _initializeControllerFuture;

      final tmpDirectory = await getTemporaryDirectory();
      final filePath = '${DateTime.now().millisecondsSinceEpoch}.png';
      final path = join(tmpDirectory.path, filePath);

      await _controller.takePicture();    //REVISAR ESTO BIEN XXX

      widget.didProvideImagePath(path);
    } catch (e) {
      print(e);
    }
  }

  // 7 ELIMINA LA INSTANCIA DE CAMARE CONTROLLER
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}