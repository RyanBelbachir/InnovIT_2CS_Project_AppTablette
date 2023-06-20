import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import '../styles/theme.dart';
import '../utils/functions.dart';
import '../widgets/footer.dart';

class Unavailable extends StatefulWidget {
  final VoidCallback onRetry;
  const Unavailable({super.key, required this.onRetry});

  @override
  State<Unavailable> createState() => _UnavailableState();
}

class _UnavailableState extends State<Unavailable> {
  late Future<String> codeVerou;

  @override
  void initState() {
    super.initState();
    codeVerou = fetchVerouCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: CustomColors.bgColor,
        child: Stack(children: [
          Positioned(
              top: 16,
              right: 16,
              child: FutureBuilder(
                  future: codeVerou,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                          onPressed: () {
                            screenLock(
                                title: const Text("Please enter the PIN code",
                                    style: Fonts.bold24White),
                                footer: const Padding(
                                  padding: EdgeInsets.only(top: 64),
                                  child: Footer(),
                                ),
                                maxRetries: 3,
                                context: context,
                                correctString: snapshot.data!,
                                onUnlocked: () {
                                  notifyMaintenanceMode();
                                  Navigator.of(context).pushNamed("/settings");
                                },
                                retryDelay: const Duration(seconds: 60));
                          },
                          icon: CustomIcons.settingsIcon);
                    } else if (snapshot.hasError) {
                      return const Text("");
                    }
                    return const Text("");
                  })),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/alert.png",
                height: 120,
                width: 120,
              ),
              Gaps.customVGap(120),
              const Center(
                child: Text(
                  "Service not available, please come back later",
                  style: Fonts.bold20Red,
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.customVGap(45),
              TextButton(
                style: ButtonStyle(
                    alignment: Alignment.center,
                    fixedSize: const MaterialStatePropertyAll(Size(120, 48)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                    backgroundColor: const MaterialStatePropertyAll(
                        CustomColors.lightRedColor)),
                onPressed: widget.onRetry,
                child: const Text(
                  'Retry',
                  style: Fonts.light14white,
                ),
              )
            ],
          )
        ]),
      ),
    ));
  }
}
