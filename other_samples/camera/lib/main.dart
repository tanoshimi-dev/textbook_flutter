import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? _image;
  final imagePicker = ImagePicker();

  // カメラから写真を取得するメソッド
  Future getImageFromCamera() async {
    final permissionStatus = await Permission.camera.request();
    // カメラロールの権限の状態を取得.
    var status = await Permission.photos.status;
    print("status: $status");
    await Permission.photos.request();
    if (status == Permission.unknown) {
      // 一度もリクエストしてないので権限のリクエスト.
      status = await Permission.photos.request();
    }
    // 権限がない場合の処理.
    if ((status == Permission.unknown) ||
        status.isDenied ||
        status.isRestricted ||
        status.isPermanentlyDenied) {
      // 端末の設定画面へ遷移.
      print("権限がない場合の処理: $status");
      await openAppSettings();
      //await Permission.photos.request();
      return;
    }

    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
      }
    });
  }

  // ギャラリーから写真を取得するメソッド
  Future getImageFromGarally() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            // 取得した写真を表示(ない場合はメッセージ)
            child: _image == null
                ? Text(
                    '写真を選択してください',
                    style: Theme.of(context).textTheme.headline4,
                  )
                : Image.file(File(_image!.path))),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // カメラから取得するボタン
          FloatingActionButton(
              onPressed: getImageFromCamera,
              child: const Icon(Icons.photo_camera)),
          // ギャラリーから取得するボタン
          FloatingActionButton(
              onPressed: getImageFromGarally,
              child: const Icon(Icons.photo_album))
        ]));
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   VideoPlayerController? _controller;
//   final imagePicker = ImagePicker();

//   // カメラから動画を取得するメソッド
//   Future getVideoFromCamera() async {
//     XFile? pickedFile = await imagePicker.pickVideo(source: ImageSource.camera);
//     if (pickedFile != null) {
//       _controller = VideoPlayerController.file(File(pickedFile.path));
//       _controller!.initialize().then((_) {
//         setState(() {
//           _controller!.play();
//         });
//       });
//     }
//   }

//   // ギャラリーから動画を取得するメソッド
//   Future getVideoFromGarally() async {
//     XFile? pickedFile =
//         await imagePicker.pickVideo(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       _controller = VideoPlayerController.file(File(pickedFile.path));
//       _controller!.initialize().then((_) {
//         setState(() {
//           _controller!.play();
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Center(
//             // 取得した動画を表示(ない場合はメッセージ)
//             child: _controller == null
//                 ? Text(
//                     '動画を選択してください',
//                     style: Theme.of(context).textTheme.headline4,
//                   )
//                 : VideoPlayer(_controller!)),
//         floatingActionButton:
//             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//           // カメラから取得するボタン
//           FloatingActionButton(
//               onPressed: getVideoFromCamera,
//               child: const Icon(Icons.video_call)),
//           // ギャラリーから取得するボタン
//           FloatingActionButton(
//               onPressed: getVideoFromGarally,
//               child: const Icon(Icons.movie_creation))
//         ]));
//   }
// }
