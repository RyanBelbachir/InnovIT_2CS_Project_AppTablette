import 'dart:convert';
import 'dart:io';
import "package:flutter/material.dart";
import '/styles/theme.dart';
import '../widgets/back_arrow.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/footer.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  late int commandeId;
  late String data;
  late Future<File> image;
  dynamic scanResults; // for camera
  late CameraController camera;
  late Future<void> cameraFuture;
  late Future<String> videoUrl;
  late Future<XFile> picture;
  bool isDetecting = false;
  final CameraLensDirection direction = CameraLensDirection.front;
  bool paymentValidated = false;
  String paymentStatus = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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

  void checkPayment() {
    IO.Socket socket =
        IO.io('https://innovit-payment.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // handle connection events
    socket.onConnect((_) {
      print('Connected to payment server!');
    });

    socket.onDisconnect((_) {
      print('Disconnected from payment server!');
    });

    // event handler to recieve paiement validation
    socket.on('validation', (data) {
      print('Received a validation message: $data');
      if (data["commandId"] == commandeId) {
        if (data["valid"]) {
          setState(() {
            paymentValidated = true;
          });
        } else {
          setState(() {
            paymentStatus = "there was an error with payment please try again";
          });
        }
      }
    });

    // connect to the server
    socket.connect();

    // send a message to the server
    socket.emit('chat message', 'Hello server!');
  }

  @override
  Widget build(BuildContext context) {
    commandeId = ModalRoute.of(context)!.settings.arguments as int;
    print("commandeID : $commandeId");
    data = '{"idComm":$commandeId,"idDistr":1}';
    picture = initializeCamera();
    checkPayment();

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
                const Text(
                  "Please scan the QR code bellow using the payment App to proceed with payment",
                  style: Fonts.bold20,
                  textAlign: TextAlign.center,
                ),
                Gaps.customVGap(64),
                Center(
                  child: QrImage(
                    data: data,
                    size: 280,
                  ),
                ),
                Gaps.gapV25,
                Center(child: Text(paymentStatus, style: Fonts.bold24Red)),
                Center(
                    child: FutureBuilder(
                  future: picture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      camera.dispose();
                      print("picture taken");
                      videoUrl = getVideoUrl(snapshot.data!);
                      return FutureBuilder(
                          future: videoUrl,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && paymentValidated) {
                              return TextButton(
                                  style: ButtonStyle(
                                      alignment: Alignment.center,
                                      fixedSize: const MaterialStatePropertyAll(
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
                                    Navigator.of(context).pushNamed("/progress",
                                        arguments: {
                                          "videoUrl": snapshot.data!,
                                          "commandeId": commandeId
                                        });
                                  },
                                  child: const Text(
                                    "Proceed",
                                    style: Fonts.bold24White,
                                  ));
                            } else if (snapshot.hasError) {
                              return const Text("");
                            }
                            return const Text("");
                          });
                    } else if (snapshot.hasError) {
                      return const Text(
                        "An error has accured, please try again",
                        style: Fonts.bold24Red,
                      );
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
