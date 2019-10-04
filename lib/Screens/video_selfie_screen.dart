import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoSelfieScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const VideoSelfieScreen({Key key, this.cameras}) : super(key: key);
  @override
  _VideoSelfieScreenState createState() => _VideoSelfieScreenState();
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _VideoSelfieScreenState extends State<VideoSelfieScreen>
    with WidgetsBindingObserver {
  var formKey = new GlobalKey<FormState>();

  CameraController controller;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  bool enableAudio = true;

  List<CameraDescription> cameras;

  Future<void> getCameras() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getCameras();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 15),
                  child: Text(
                    "Credify",
                    style: Theme.of(context).primaryTextTheme.display2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15),
                  child: Text(
                    " Upload",
                    style: Theme.of(context).primaryTextTheme.display1,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 15),
                  child: Text(
                    "  1/2",
                    style: Theme.of(context).primaryTextTheme.display3,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, bottom: 20),
                  child: Text(
                    "  Video Selfie",
                    style: Theme.of(context).primaryTextTheme.display4,
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  child: Center(
                    child: _cameraPreviewWidget(),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: controller != null &&
                              controller.value.isRecordingVideo
                          ? Colors.redAccent
                          : Colors.grey,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.grey,
                child: _captureControlRowWidget(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 30.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    elevation: 5.0,
                    color: Color.fromRGBO(45, 156, 219, 1),
                    shape: new RoundedRectangleBorder(
                        side: BorderSide(
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                        borderRadius: new BorderRadius.circular(5)),
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                      child: new Text('Continue',
                          style: new TextStyle(
                              fontSize: 18.0, color: Colors.white)),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/bankScreen1',
                          (Route<dynamic> route) => false);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return GestureDetector(
        onTap: () {
          if (cameras == null) {
            Fluttertoast.showToast(msg: "Loading Cameras!!");
          } else {
            if (cameras.isEmpty) {
              showInSnackBar("No Cameras Found");
            } else {
              onNewCameraSelected(cameras[0]);
            }
          }
        },
        onDoubleTap: () {
          if (cameras == null) {
            Fluttertoast.showToast(msg: "Loading Cameras!!");
          } else {
            if (cameras.isEmpty) {
              showInSnackBar("No Cameras Found");
            } else {
              onNewCameraSelected(cameras[1]);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: const Text(
            'Tap here ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: 1,
        child: CameraPreview(controller),
      );
    }
  }

//  /// Display the thumbnail of the captured image or video.
//  Widget _thumbnailWidget() {
//    return Expanded(
//      child: Align(
//        alignment: Alignment.centerRight,
//        child: Row(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            videoController == null
//                ? Container()
//                : SizedBox(
//                    child: (videoController == null)
//                        ? Container()
//                        : Container(
//                            child: Center(
//                              child: AspectRatio(
//                                  aspectRatio:
//                                      videoController.value.size != null
//                                          ? videoController.value.aspectRatio
//                                          : 1.0,
//                                  child: VideoPlayer(videoController)),
//                            ),
//                            decoration: BoxDecoration(
//                                border: Border.all(color: Colors.pink)),
//                          ),
//                    width: 64.0,
//                    height: 64.0,
//                  ),
//          ],
//        ),
//      ),
//    );
//  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onVideoRecordButtonPressed
              : null,
        ),
        IconButton(
          icon: controller != null && controller.value.isRecordingPaused
              ? Icon(Icons.play_arrow)
              : Icon(Icons.pause),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  controller.value.isRecordingVideo
              ? (controller != null && controller.value.isRecordingPaused
                  ? onResumeButtonPressed
                  : onPauseButtonPressed)
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  controller.value.isRecordingVideo
              ? onStopButtonPressed
              : null,
        )
      ],
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: enableAudio,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted) setState(() {});
      if (filePath != null) showInSnackBar('Saving video to $filePath');
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recorded to: $videoPath');
    });
  }

  void onPauseButtonPressed() {
    pauseVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recording paused');
    });
  }

  void onResumeButtonPressed() {
    resumeVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recording resumed');
    });
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    await _startVideoPlayer();
  }

  Future<void> pauseVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.pauseVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.resumeVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> _startVideoPlayer() async {
    final VideoPlayerController vcontroller =
        VideoPlayerController.file(File(videoPath));
    videoPlayerListener = () {
      if (videoController != null && videoController.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoController.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(true);
    await vcontroller.initialize();
    await videoController?.dispose();
    if (mounted) {
      setState(() {
        videoController = vcontroller;
      });
    }
    await vcontroller.play();
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
