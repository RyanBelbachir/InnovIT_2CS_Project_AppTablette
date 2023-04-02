import 'dart:convert';
import 'dart:io';
import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '/styles/theme.dart';
import '../widgets/back_arrow.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/footer.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  late int commandeId;
  late String link;
  late Future<File> image;
  dynamic scanResults; // for camera
  late CameraController camera;
  late Future<void> cameraFuture;
  late Future<String> videoUrl;
  late Future<XFile> picture;

  bool isDetecting = false;
  final CameraLensDirection direction = CameraLensDirection.front;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    camera.dispose();
    super.dispose();
  }

  //function to get the front camera
  Future<CameraDescription> getCamera(CameraLensDirection direction) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == direction,
      ),
    );
  }

  // fucntion to initialize the camera
  Future<XFile> initializeCamera() async {
    camera = CameraController(
      await getCamera(direction),
      ResolutionPreset.high,
    );
    await camera.initialize();
    var pic = await camera.takePicture();
    return pic;
  }

  Future<String> getVideoUrl(XFile image) async {
    File imageFile = File(image.path);
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://innovit-2cs-project.onrender.com/Distributeur/pub/$commandeId"));
    request.headers.addAll({"Content-Type": "multipart/form-data"});
    request.files.add(http.MultipartFile.fromBytes(
        "image", imageFile.readAsBytesSync(),
        filename: imageFile.path));
    var streamedResponse = await request.send();
    var res = await http.Response.fromStream(streamedResponse);
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      return json["url"].toString();
    } else {
      throw Exception('failed to get url,error code: ${res.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    commandeId = ModalRoute.of(context)!.settings.arguments as int;
    link = "${dotenv.env["API_URL"]}Distributeur/command/$commandeId";
    picture = initializeCamera();

    return Scaffold(
        body: SafeArea(
            child: Container(
      color: CustomColors.bgColor,
      child: Stack(
        children: [
          const Back(),
          const Footer(),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Text(
                //   "Please scan the QR code bellow using the payment App to proceed with payment",
                //   style: Fonts.bold20,
                //   textAlign: TextAlign.center,
                // ),
                // Text(
                //   commandeId.toString(),
                //   style: Fonts.bold20,
                //   textAlign: TextAlign.center,
                // ),
                // Gaps.customVGap(64),
                // Center(
                //   child: QrImage(
                //     data: link,
                //     size: 280,
                //   ),
                // ),
                Gaps.gapV25,
                Center(
                    child: FutureBuilder(
                  future: picture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      videoUrl = getVideoUrl(snapshot.data!);
                      return Column(
                        children: [
                          Container(
                              height: 200,
                              width: 200,
                              child: Image.file(File(snapshot.data!.path),
                                  scale: 0.2)),
                          FutureBuilder(
                              future: videoUrl,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  //print(snapshot.data!);
                                  return TextButton(
                                      style: ButtonStyle(
                                          alignment: Alignment.center,
                                          fixedSize:
                                              const MaterialStatePropertyAll(
                                                  Size(260, 58)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          )),
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  CustomColors.greenColor)),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            "/progress",
                                            arguments: snapshot.data!);
                                      },
                                      child: const Text(
                                        "Proceed",
                                        style: Fonts.bold24White,
                                      ));
                                } else if (snapshot.hasError) {
                                  return const Text("");
                                }
                                return const Text("");
                              }),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Text("");
                    }
                    return const Text("");
                  },
                ))
              ],
            ),
          )
        ],
      ),
    )));
  }
}
