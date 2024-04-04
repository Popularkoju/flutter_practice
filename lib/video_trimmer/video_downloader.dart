// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final textController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Insert the video id or url',
//             ),
//             TextField(controller: textController),
//             ElevatedButton(
//               child: const Text('Download'),
//               onPressed: () async {
//                 // Here you should validate the given input or else an error
//                 // will be thrown.
//                 final yt = YoutubeExplode();
//                 final id = VideoId(textController.text.trim());
//                 final video = await yt.videos.get(id);
//                 VideoQuality.high2880;
//                 // VideoQuality.high720;
//
//                 // Display info about this video.
//                 await showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       content: Text(
//                         'Title: ${video.title}, Duration: ${video.duration}',
//                       ),
//                     );
//                   },
//                 );
//
//                 // Request permission to write in an external directory.
//                 // (In this case downloads)
//                 await Permission.storage.request();
//
//                 // Get the streams manifest and the audio track.
//                 final manifest = await yt.videos.streamsClient.getManifest(id);
//
//                 final audio = manifest.audio.last;
//                 final videoD = manifest.video.first;
//                 // var audioStream = ytExplode.videos.streamsClient.get(streamInfo);
//                 //   var videoFile = yt.videos.streamsClient.get(videoD);
//
//                 // Build the directory.
//                 final dir = await getDownloadsDirectory();
//                 final filePath = path.join(
//                   dir!.path,
//                   '${video.id}.${audio.container.name}',
//                 );
//
//                 // Open the file to write.
//                 final file = File(filePath);
//                 final fileStream = file.openWrite();
//
//                 // Pipe all the content of the stream into our file.
//                 await yt.videos.streamsClient.get(videoD).pipe(fileStream);
//                 /*
//                   If you want to show a % of download, you should listen
//                   to the stream instead of using `pipe` and compare
//                   the current downloaded streams to the totalBytes,
//                   see an example ii example/video_download.dart
//                    */
//
//                 // Close the file.
//                 await fileStream.flush();
//                 await fileStream.close();
//
//                 // Show that the file was downloaded.
//                 await showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       content:
//                           Text('Download completed and saved to: $filePath'),
//                     );
//                   },
//                 );
//                 // Navigator.push(context, MaterialPageRoute(builder: (context) => RawVideoFile(path: file.path,)));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
