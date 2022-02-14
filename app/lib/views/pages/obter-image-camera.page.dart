import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

class ObterImagemCameraPage extends StatefulWidget {
  final List<CameraDescription> camera;
  ObterImagemCameraPage({this.camera});

  @override
  _ObterImagemCameraPage createState() => _ObterImagemCameraPage();
}

class _ObterImagemCameraPage extends State<ObterImagemCameraPage> {
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;
  String filePathReturn;
  int cameraSelected = 0;
  bool carregando = false;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera[cameraSelected], ResolutionPreset.high, enableAudio: false);
    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      FutureBuilder(
        future: _initializeCameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: AspectRatio(
                  aspectRatio: _cameraController.value.aspectRatio,
                  child: CameraPreview(_cameraController),
                ),
              ),
              floatingActionButton: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: (){
                            alterarCamera();
                          },
                          child: const Icon(
                            Icons.change_circle_sharp,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      )
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: new FloatingActionButton(
                        backgroundColor: Colors.green,
                        onPressed: (){
                          obterImagem(context);
                        },
                        child: const Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                      )
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: new FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.exit_to_app_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )
                  ),
                  carregando ? Center(child: CircularProgressIndicator()) : Container()
                ],
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    ]);
  }
  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        iosUiSettings: IOSUiSettings(
          //minimumAspectRatio: 1,
          //aspectRatioPickerButtonHidden: true,
            rotateButtonsHidden: true,
            aspectRatioLockDimensionSwapEnabled: true,
            aspectRatioLockEnabled: true
        )
    );

    if (filePath != null) {
      setState(() {
        filePathReturn = croppedImage.path;
        carregando = true;
      });
      // ConfiguracoesService service = Provider.of<ConfiguracoesService>(context, listen: false);
      // await service.alterarFoto(XFile(croppedImage!.path));
      // await service.alterarFoto(XFile(filePath));
      setState(() {
        // _cameraController = CameraController(widget.camera[cameraSelected], ResolutionPreset.high, enableAudio: false);
        _initializeCameraControllerFuture = _cameraController.initialize();
      });
      // imageCache!.clear();
      // await _initializeCameraControllerFuture;

      fecharTelar(true);
    }
  }

  void obterImagem(BuildContext context) async {
    try{
      imageCache.clear();
      await _initializeCameraControllerFuture;
      final Directory extDir = await getTemporaryDirectory();
      final String dirPath = '${extDir.path}/GetDesk/Camera/Images';
      await new Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
      // await _cameraController!.takePicture(filePath);
      var file = await _cameraController.takePicture();
      print(111111);
      print(file.path);
      _cropImage(file.path);
      // _cropImage(filePath);
    }on Exception catch(ex){

    }

  }

  void alterarCamera(){
    setState(() {
      cameraSelected = cameraSelected == 0 ? 1 : 0;
      _cameraController = CameraController(widget.camera[cameraSelected], ResolutionPreset.high, enableAudio: false);
      _initializeCameraControllerFuture = _cameraController.initialize();
    });
  }

  void fecharTelar(bool resp){
    setState(() {
      carregando = false;
    });
    if(resp){
      Navigator.pop(context, filePathReturn);
    }
  }

}