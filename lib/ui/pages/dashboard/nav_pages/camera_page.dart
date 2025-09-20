import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    // Get list of available cameras
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      // you can display or save the image
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayPicturePage(imagePath: image.path),
        ),
      );
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera Preview')),
      body: _controller == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _captureImage,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPicturePage extends StatelessWidget {
  final String imagePath;
  DisplayPicturePage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Captured Image")),
      body: Center(child: Image.file(File(imagePath))),
    );
  }
}
