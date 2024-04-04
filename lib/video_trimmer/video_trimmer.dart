// import 'dart:io';
//
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter/log.dart';
// import 'package:ffmpeg_kit_flutter/return_code.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_trimmer/video_trimmer.dart';
// import 'package:file_picker/file_picker.dart';
//
// class VideoTrimmer extends StatefulWidget {
//   @override
//   _VideoTrimmerState createState() => _VideoTrimmerState();
// }
//
// class _VideoTrimmerState extends State<VideoTrimmer> {
//   @override
//   void initState() {
//     requestPermissions();
//     super.initState();
//   }
//
//   Future<void> requestPermissions() async {
//     await Permission.storage.request();
//   }
//
//   VideoPlayerController? _controller;
//   double _startValue = 0.0;
//   double _endValue = 1.0;
//   final Trimmer _trimmer = Trimmer();
//   bool _isPlaying = false;
//
//   Future<void> ffmpegExecute(String command) async {
//     final session = await FFmpegKit.execute(command);
//     final returnCode = await session.getReturnCode();
//     if (ReturnCode.isSuccess(returnCode)) {
//       print("Success");
//     } else if (ReturnCode.isCancel(returnCode)) {
//       print("Cancel");
//     } else {
//       print("error");
//       final failStackTrace = await session.getFailStackTrace();
//       print(failStackTrace);
//       List<Log> logs = await session.getLogs();
//       for (var element in logs) {
//         print(element.getMessage());
//       }
//     }
//   }
//
//   Future<void> loadVideo(String url) async {
//     _controller = VideoPlayerController.networkUrl(Uri.parse(url));
//     await _controller!.initialize();
//
//     setState(() {});
//   }
//
//   Future<String> getOutputPath() async {
//
//     final appDirectory = Platform.isAndroid
//         ? await getDownloadsDirectory()
//         : await getDownloadsDirectory();
//     final externalPath = '${appDirectory?.path}/out_file.mp4';
//     return externalPath;
//   }
//   Future<void> clipVideo() async {
//     String ? filePath = await getOutputPath();
//     // final String? filePath = await FilePicker.platform.saveFile(
//     //   dialogTitle: 'Select output file',
//     // );
//     if (filePath != null) {
//       // final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
//
//
//       await ffmpegExecute(
//         '-i ${_controller!.dataSource} -ss $_startValue -to $_endValue $filePath',
//       );
//       await _trimmer.loadVideo(videoFile: File(filePath));
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Video clipped and saved!')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Video Clipper')),
//         body: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(labelText: 'Enter video URL'),
//               onSubmitted: (url) => loadVideo(url),
//             ),
//             if (_controller != null)
//               Container(
//                 height: 200,
//                 child: VideoPlayer(
//                   _controller!,
//                 ),
//               )
//             else
//               Container(),
//             VideoViewer(trimmer: _trimmer),
//             if (_controller != null)
//               TrimViewer(
//                 trimmer: _trimmer,
//                 viewerHeight: 50.0,
//                 viewerWidth: MediaQuery.of(context).size.width,
//                 maxVideoLength: const Duration(seconds: 10),
//                 onChangeStart: (value) => _startValue = value,
//                 onChangeEnd: (value) => _endValue = value,
//                 onChangePlaybackState: (value) =>
//                     setState(() => _isPlaying = value),
//               )
//             // VideoTrimmer(
//             //   min: 0.0,
//             //   max: 1.0,
//             //   startValue: _startValue,
//             //   endValue: _endValue,
//             //   onEndValueChange: (newValue) => setState(() => _endValue = newValue),
//             //   onStartValueChange: (newValue) => setState(() => _startValue = newValue),
//             // )
//             else
//               Container(),
//             ElevatedButton(onPressed: clipVideo, child: Text('Clip Video')),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
// }
