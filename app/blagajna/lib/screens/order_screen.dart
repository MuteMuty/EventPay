import 'package:blagajna/data/events_repo.dart';
import 'package:blagajna/data/login_repo.dart';
import 'package:blagajna/data/models/order_post_model.dart';
import 'package:blagajna/qr_reader/qr_reader.dart';
import 'package:blagajna/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final TextEditingController _qrInputController =
      TextEditingController(text: "");

  final TextEditingController _priceController =
      TextEditingController(text: "");
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final eventId = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: ThemeColors.backeground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "New order",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(children: [
          TextField(
            readOnly: true,
            controller: _qrInputController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: _qrInputController.text.isNotEmpty
                        ? Colors.green
                        : Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white24),
              ),
              label: Text("Card number", style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          SizedBox(
            height: h * 0.1,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _priceController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white24),
              ),
              label: Text("Price", style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              if (_priceController.text.isNotEmpty &&
                  _qrInputController.text.isNotEmpty) {
                var orderModel = OrderPostModel(
                    cardNumber: _qrInputController.text,
                    amount: double.parse(_priceController.text),
                    workerUsername: LoginRepo.username ?? 'janez');
                var eventsRepo = EventsRepo();
                eventsRepo.postTransaction(orderModel).then((value) {
                  var mes =
                      value ? "Transaction was successful" : "Balance too low";
                  Navigator.pushNamed(context, "/events");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(mes)
                  ));
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeColors.orange),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Create order",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: h * 0.15,
          ),
        ]),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          _qrInputController.text = result!.code ?? '';
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
