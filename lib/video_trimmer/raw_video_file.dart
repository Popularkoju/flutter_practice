// // ignore_for_file: avoid_print
//
// import 'dart:io';
//
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter/log.dart';
// import 'package:ffmpeg_kit_flutter/return_code.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
//
// class RawVideoFile extends StatefulWidget {
//   // final String path;
//
//   const RawVideoFile({Key? key}) : super(key: key);
//
//   @override
//   State<RawVideoFile> createState() => _RawVideoFileState();
// }
//
// class _RawVideoFileState extends State<RawVideoFile> {
//   late String inputPath;
//   String outputPath = "";
//
//   bool _isPlaying = false;
//   bool _progressVisibility = false;
//
//   VideoPlayerController? controller;
//   VideoPlayerController? outputController;
//   Duration? totalDuration;
//
//   bool isOutputPlaying = false;
//
//   TextEditingController seekFromController = TextEditingController();
//   TextEditingController seekToController = TextEditingController();
//   TextEditingController croppedWidthController = TextEditingController();
//   TextEditingController croppedHeightController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     loadVideo();
//     // copyVideoToApplicationDirectory().then((path) async {
//
//     // });
//   }
//
//   loadVideo() async {
//     // inputPath = (widget.path);
//     // controller = VideoPlayerController.file(File(inputPath));
//     controller = VideoPlayerController.networkUrl(
//         Uri.parse("https://www.youtube.com/watch?v=okRpBllhJeY"));
//     print("i am here");
//     print(controller?.value);
//     await controller?.initialize();
//     totalDuration = controller!.value.duration;
//     setState(() {});
//   }
//
//   // void _downloadVideo(String url) async {
//   //   var ytExplode = YoutubeExplode();
//   //   var video = await ytExplode.videos.get(url);
//   //
//   //   var manifest = await ytExplode.videos.streamsClient.getManifest(video);
//   //
//   //   var streamInfo = manifest.audioOnly.first;
//   //   var videoStream = manifest.video.first;
//   //
//   //   var audioStream = ytExplode.videos.streamsClient.get(streamInfo);
//   //   var videoFile = await ytExplode.videos.streamsClient.get(videoStream);
//   // var vFile=   videoFile.cast<Uint8List>();
//   //   var uint8ListStream = videoFile.map((list) => list.cast<Uint8List>());
//   //
//   //   // _saveVideo(File(uint8ListStream), "videoTitle");
//   // }
//   //
//   // void _saveVideo(File videoFile, String videoTitle) async {
//   //   final appDocDir = await getApplicationDocumentsDirectory();
//   //   final savePath = '${appDocDir.path}/$videoTitle.mp4';
//   //
//   //   final videoBytes = await videoFile.readAsBytes();
//   //   final File file = File(savePath);
//   //
//   //   await file.writeAsBytes(videoBytes);
//   //
//   //   // Show a success message or handle errors here
//   // }
//
//   ///Copy input file to ApplicationStorage Directory
//   ///returns path to copied video
//   Future<String> copyVideoToApplicationDirectory() async {
//     const filename = "file1.mp4";
//     var bytes = await rootBundle.load("assets/file1.mp4");
//     String dir = (await getApplicationDocumentsDirectory()).path;
//     writeToFile(bytes, '$dir/$filename');
//
//     return '$dir/$filename';
//   }
//
//   ///Write to Path.
//   Future<void> writeToFile(ByteData data, String path) {
//     final buffer = data.buffer;
//     return File(path).writeAsBytes(
//         buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
//   }
//
//   /// Loads preview for the output video.
//   loadOutputPreview() async {
//     outputController = VideoPlayerController.file(File(outputPath))
//       ..initialize().then((_) {
//         setState(() {});
//       });
//     await outputController?.setLooping(true);
//   }
//
//   ///Executes the FFMPEG [command]
//   ///Note: Green bar on the right is a Flutter issue. https://github.com/flutter/engine/pull/24888
//   ///Should get fixed in 3.1.0+ stable release https://github.com/flutter/engine/pull/24888#issuecomment-1212374010
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
//   /// Output path with file name where the result will be stored.
//   Future<String> getOutputPath() async {
//     final appDirectory = Platform.isAndroid
//         ? await getDownloadsDirectory()
//         : await getDownloadsDirectory();
//     final externalPath = '${appDirectory?.path}/out_file.mp4';
//     return externalPath;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Popular"),
//       ),
//       body: Center(
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: <Widget>[
//             const Text(
//               "Input Preview",
//             ),
//             (controller != null)
//                 ? AspectRatio(
//                     aspectRatio: controller!.value.aspectRatio,
//                     child: VideoPlayer(controller!))
//                 : const SizedBox(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Total Duration $totalDuration'),
//                 Text(
//                     'W: ${controller?.value.size.width} x H: ${controller?.value.size.height}')
//               ],
//             ),
//             TextButton(
//                 onPressed: () {
//                   if (!_isPlaying) {
//                     controller!.play();
//                   } else {
//                     controller!.pause();
//                   }
//                   _isPlaying = !_isPlaying;
//                 },
//                 child: const Text('Play / Pause')),
//             Text(
//               "Trim",
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   width: 100,
//                   child: TextField(
//                     controller: seekFromController,
//                     decoration: const InputDecoration(
//                         labelText: "Seek From",
//                         hintText: "00:00:10",
//                         helperText: 'format: hh:mm:ss'),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 100,
//                   child: TextField(
//                     controller: seekToController,
//                     decoration: const InputDecoration(
//                         labelText: "Seek To",
//                         hintText: "00:00:15",
//                         helperText: 'format: hh:mm:ss'),
//                   ),
//                 )
//               ],
//             ),
//             Text(
//               'Crop',
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   width: 100,
//                   child: TextField(
//                     controller: croppedWidthController,
//                     decoration: const InputDecoration(
//                         labelText: "Width",
//                         hintText: "250",
//                         helperText: 'in Pixels'),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 100,
//                   child: TextField(
//                     controller: croppedHeightController,
//                     decoration: const InputDecoration(
//                         labelText: "Height",
//                         hintText: "250",
//                         helperText: 'in Pixels'),
//                   ),
//                 )
//               ],
//             ),
//             TextButton(
//                 onPressed: () async {
//                   String outputPath = await getOutputPath();
//                   await ffmpegExecute(
//                       '-ss ${seekFromController.text.trim()} -to ${seekToController.text.trim()} -y -i $inputPath -filter:v "crop=${croppedWidthController.text.trim()}:${croppedHeightController.text.trim()}" -c:a copy $outputPath');
//                   setState(() {
//                     this.outputPath = outputPath;
//                     loadOutputPreview();
//                     FocusManager.instance.primaryFocus?.unfocus();
//                   });
//                 },
//                 child: const Text('Save')),
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 2,
//               child: const DecoratedBox(
//                   decoration: BoxDecoration(color: Colors.grey)),
//             ),
//             _progressVisibility
//                 ? const LinearProgressIndicator()
//                 : const SizedBox(),
//             Visibility(
//                 visible: outputPath.isNotEmpty,
//                 child: const Text(
//                   "Output Preview",
//                 )),
//             const SizedBox(
//               height: 16,
//             ),
//             outputController != null
//                 ? Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: AspectRatio(
//                       aspectRatio: outputController!.value.aspectRatio,
//                       child: VideoPlayer(outputController!),
//                     ),
//                   )
//                 : const SizedBox(),
//             outputController != null
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                           'Total Duration ${outputController!.value.duration}'),
//                       Text(
//                           'W: ${outputController?.value.size.width} x H: ${outputController?.value.size.height}')
//                     ],
//                   )
//                 : const SizedBox(),
//             Visibility(
//               visible: outputPath.isNotEmpty,
//               child: TextButton(
//                   onPressed: () {
//                     if (!isOutputPlaying) {
//                       outputController!.play();
//                     } else {
//                       outputController!.pause();
//                     }
//                     isOutputPlaying = !isOutputPlaying;
//                   },
//                   child: const Text('Play / Pause')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
