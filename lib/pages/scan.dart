import "package:flutter/material.dart";
import '/styles/theme.dart';
import '../widgets/back_arrow.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/footer.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  late int commandeId;
  late String link;
  @override
  @override
  Widget build(BuildContext context) {
    commandeId = ModalRoute.of(context)!.settings.arguments as int;
    link =
        "https://daf1-105-101-134-89.eu.ngrok.ioDistributeur/command/$commandeId";
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
                Center(
                  child: QrImage(
                    data: link,
                    size: 280,
                  ),
                ),
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
