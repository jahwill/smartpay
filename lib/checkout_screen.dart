import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:smartpay/utility/helper/const_utility.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'components/msc/animated_alert_modal.dart';
import 'cores/service/paystack_service.dart';
import 'home_screen.dart';

class CheckOutPayment extends StatefulWidget {
  const CheckOutPayment({Key? key}) : super(key: key);

  @override
  State<CheckOutPayment> createState() => _CheckOutPaymentState();
}

class _CheckOutPaymentState extends State<CheckOutPayment> {
  final plugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    plugin.initialize(publicKey: payStackKey);
  }

  Future<String> createAccessCode(skTest, _getReference, int amount,
      {Function(String transationRefrennce)? onSuccess}) async {
    Map<String, dynamic> payload = {
      "amount": 100 * amount,
      "email": "meetjahwill@gmail.com",
      "reference": _getReference
    };
    final Response? res;
    InitPayStack service = InitPayStack();

    res = await service.initPayment(skTest, payload: payload);

    if (res != null) {
      String accessCode = res.data['data']['authorization_url'];
      if (onSuccess != null) {
        onSuccess(res.data['data']['reference']);
      }
      return accessCode;
    } else {
      return '';
    }
  }

  String _getRefrence() {
    var platForm = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().microsecondsSinceEpoch;
    return 'ChargeFrom${platForm}_$thisDate';
  }

  chargeCard(int amount) async {
    var charge = Charge()
      ..amount = 100 * amount
      ..reference = _getRefrence()
      ..putCustomField('custom_id', 'Jtech Ltd')
      ..email = 'meetjahwill@gmail.com'
      ..accessCode =
          await createAccessCode(payStackSecreteKey, _getRefrence(), 2000);

    CheckoutResponse response = await plugin.checkout(context,
        method: CheckoutMethod.bank, charge: charge);

    if (response.status == true) {
      AnimatedAlertModal.emptyModalWithNoTitle(context,
          body: Text(
              'Your $ngn$amount Funding was Successful Check Your Wallet For Balance '));
    } else {
      AnimatedAlertModal.emptyModalWithNoTitle(
        context,
        // bgColor: Colors.red,
        body: Text('Your funding failed'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        height: 50,
        onPressed: () async {
          String transactionRef = '';
          String token = await createAccessCode(
              payStackSecreteKey, _getRefrence(), 2000, onSuccess: (val) {
            transactionRef = val;
          });

          if (token != '') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => PayStackFundPage(
                          payStackUrl: token,
                          paymentAmount: 2000,
                          paymentRef: transactionRef,
                        )));
          }
          // chargeCard(2000);
        },
        child: Text(
          'Pay through redirect',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class PayStackFundPage extends StatefulWidget {
  const PayStackFundPage(
      {Key? key,
      required this.payStackUrl,
      this.paymentRef = '',
      required this.paymentAmount})
      : super(key: key);
  final String payStackUrl;
  final String paymentRef;
  final int paymentAmount;

  @override
  State<PayStackFundPage> createState() => _PayStackFundPageState();
}

class _PayStackFundPageState extends State<PayStackFundPage> {
  late WebViewController webViewController;

  Future<void> verifyPayStackTransaction(String reference) async {
    InitPayStack service = InitPayStack();
    Response? res = await service.verifyPaymentPayment(
      payStackSecreteKey,
      referenceID: reference,
    );

    if (res != null) {
      log(res.toString());
    } else {
      log(res.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // print('did not use u but calling me');
        ///
        // InitializationCmd(context).refreshUser();
        // PayStackCmd(context)
        //     .getPaymentStatus(widget.paymentRef, amount: widget.paymentAmount);
        // context.pushOff(const MainScreen());

        verifyPayStackTransaction(widget.paymentRef);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            // onTapLeadingIcon: () {
            //   // print('did not use u but calling me');
            //   // PayStackCmd(context)
            //   //     .getPaymentStatus(paymentRef, amount: paymentAmount);
            //   context.pop();
            // },
            ),
        body: WebView(
          initialUrl: widget.payStackUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            webViewController = controller;
          },
          navigationDelegate: (f) {
            return NavigationDecision.prevent;
          },
        ),
      ),
    );
  }
}
