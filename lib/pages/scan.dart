import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/styles/theme.dart';
import '../widgets/back_arrow.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/footer.dart';
import 'package:camera/camera.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  late int commandeId;
  late String link;

  dynamic scanResults; // for camera
  late CameraController camera;

  bool isDetecting = false;
  final CameraLensDirection direction = CameraLensDirection.front;

  @override
  void initState() {
    super.initState();
    initializeCamera();
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
  void initializeCamera() async {
    camera = CameraController(
      await getCamera(direction),
      ResolutionPreset.medium,
    );
    await camera.initialize();
    camera.startImageStream((CameraImage image) {
      if (isDetecting) return;
      isDetecting = true;
      try {} catch (e) {
        rethrow;
      } finally {
        isDetecting = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    commandeId = ModalRoute.of(context)!.settings.arguments as int;
    link = "${dotenv.env["API_URL"]}Distributeur/command/$commandeId";
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
                // Text(
                //   commandeId.toString(),
                //   style: Fonts.bold20,
                //   textAlign: TextAlign.center,
                // ),
                Gaps.customVGap(64),
                CameraPreview(camera),
                // Center(
                //   child: QrImage(
                //     data: link,
                //     size: 280,
                //   ),
                // ),
                Gaps.gapV25,
                Center(
                  child: TextButton(
                      style: ButtonStyle(
                          alignment: Alignment.center,
                          fixedSize:
                              const MaterialStatePropertyAll(Size(260, 58)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                          backgroundColor: const MaterialStatePropertyAll(
                              CustomColors.greenColor)),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/progress");
                      },
                      child: const Text(
                        "Proceed",
                        style: Fonts.bold24White,
                      )),
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}
