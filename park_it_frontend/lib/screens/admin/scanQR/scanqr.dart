import 'package:flutter/material.dart';
import 'package:park_it/config/theme.dart';
import 'package:park_it/screens/admin/scanQR/scanned.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          iconTheme: IconThemeData(color: Theme2.black),
          backgroundColor: Theme2.yellow,
          title: Text(
            "Scan QR Code",
            style: TextStyle(color: Theme2.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: QRViewExample(),
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  Icon isFlashOn = Icon(
    Icons.flash_off_outlined,
    color: Theme2.black,
    size: 28,
  );
  int tappedOnFlash = 0;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Theme2.grey2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    controller.flipCamera();
                  },
                  icon: Icon(
                    Icons.flip_camera_android_outlined,
                    color: Palette.blue,
                    size: 28,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    tappedOnFlash = tappedOnFlash + 1;
                    controller.toggleFlash();
                    setState(() {
                      if (tappedOnFlash % 2 == 0) {
                        isFlashOn = Icon(
                          Icons.flash_off_outlined,
                          color: Theme2.black,
                          size: 28,
                        );
                      } else {
                        isFlashOn = Icon(
                          Icons.flash_on_outlined,
                          color: Theme2.black,
                          size: 28,
                        );
                      }
                    });
                  },
                  icon: isFlashOn,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      result = null;
                      controller.resumeCamera();
                    });
                  },
                  icon: Icon(
                    Icons.refresh_outlined,
                    color: Theme2.black,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: QRView(
              overlay: QrScannerOverlayShape(borderColor: Theme2.grey),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Theme2.grey2,
              child: Center(
                child: ifQRscanned(result, context),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget ifQRscanned(Barcode result, BuildContext context) {
    if (result != null) {
      controller.pauseCamera();
      String data = result.code;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScannedData(
                      result: data,
                    )));
      });

      return Text("Code detected!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500));
    }
    return Text("Scan A Code", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),);
  }
}
