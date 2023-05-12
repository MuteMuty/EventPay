import 'package:eventpay/bloc/global/global_bloc.dart';
import 'package:eventpay/bloc/kartice/kartice_bloc.dart';
import 'package:eventpay/router/routes.dart';
import 'package:eventpay/services/backend_service.dart';
import 'package:eventpay/style/colors.dart';
import 'package:eventpay/style/styles.dart';
import 'package:eventpay/widgets/vec_button.dart';
import 'package:eventpay/widgets/vec_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FillupScreenArgs {
  final String cardNumber;

  const FillupScreenArgs({required this.cardNumber});
}

class FillupScreen extends StatefulWidget {
  final FillupScreenArgs args;
  const FillupScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<FillupScreen> createState() => _FillupScreenState();
}

class _FillupScreenState extends State<FillupScreen> {
  String no = "";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: EPColor.backgroud,
          middle: Text(
            "Polnjenje kartice",
            style: EPStyles.pageTitleTextStyle(context),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VecTextField(
                placeholder: 'Vrednost polnjenja',
                onChanged: (v) => setState(() => no = v),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: VecTextShadowButton.filled(
                  text: "Polni kartico",
                  textStyle: EPStyles.buttonTextStyle(context),
                  color: EPColor.orange,
                  onPressed: () {
                    BackendService.instance
                        .postFillup("watafak", double.parse(no));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
