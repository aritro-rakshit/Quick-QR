import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 late ScrollController _scrollController;
 String _scanBarcode = 'Unknown';

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> startScanning(Function(String value) result) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    result(barcodeScanRes);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,title:const Text("Quick QR"),) ,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child:
                  ElevatedButton(
                    child: const Text("Start Scanning"),
                    onPressed: (){
                      startScanning(
                          (value){
                            setState(() {
                              _scanBarcode = value;
                            });
                          }
                      );
                    },
                  )
                  ,),
                SizedBox(height: 14,),
                Text(_scanBarcode)
              ],
          ),
        ),
      ),
    );
  }
}
