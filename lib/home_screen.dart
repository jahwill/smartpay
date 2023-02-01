import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:smartpay/components/msc/animated_alert_modal.dart';
import 'package:smartpay/cores/service/base_service.dart';
import 'package:smartpay/utility/helper/app_global_context.dart';
import 'package:smartpay/utility/helper/const_utility.dart';
import 'package:smartpay/utility/helper/helper_utilities.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'components/inputs/inputfield.dart';
import 'components/msc/buttons.dart';
import 'cores/service/paystack_service.dart';

class CardPayment extends StatefulWidget {
  const CardPayment({Key? key}) : super(key: key);

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

String get payStackSecreteKey =>
    "sk_test_4f295cca7d1282df0ae553c56ffacfb0d1b61e26";
String get payStackKey =>
    'pk_test_8cd4c9bb7577c63fde8c6608dba29febf59474fa'; //jahswill test key

class _CardPaymentState extends State<CardPayment> {
  final TextEditingController _textController = TextEditingController(text: '');
  final plugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    plugin.initialize(publicKey: payStackKey);
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
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
      ..email = 'meetjahwill@gmail.com';

    CheckoutResponse response = await plugin.checkout(context,
        method: CheckoutMethod.card, charge: charge);

    if (response.status == true) {
      // _authProvider(context).getUser();
      AnimatedAlertModal.emptyModalWithNoTitle(context,
          body: Text(
              'Your $ngn${_textController.value.text} Funding was Successful Check Your Wallet For Balance '));
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Center(
          child: MaterialButton(
            color: Theme.of(context).primaryColor,
            height: 50,
            onPressed: () {
              fundWithPayStack(context);
            },
            child: Text(
              'Make Payment',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> fundWithPayStack(BuildContext context) {
    var size = MediaQuery.of(context).size;
    BuildContext contxt = AppContext.masterKey;
    return showModal(
        context: context,
        builder: (BuildContext context) => Column(
              children: [
                AnimatedContainer(
                  height: 280,
                  width: size.width * 0.9,
                  margin: EdgeInsets.only(top: size.height * 0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  duration: const Duration(milliseconds: 240),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Text(
                          'Specify how much you want to fund.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, height: 1.7),
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Text(
                          'Amount to fund',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        CustomInputField(
                          //
                          textController: _textController,
                          textInputtype: TextInputType.number,

                          sufixIcon: SizedBox(
                            height: 10,
                            width: 10,
                            child: Center(
                                child: Text(
                              "NGN",
                              style: Theme.of(context).textTheme.bodyText2,
                            )),
                          ),
                          hint: 'Enter amount to fund',
                          focus: true,
                        ),
                        const SizedBox(height: 30),
                        EvCustomBtn(
                          ontap: () {
                            Navigator.pop(context);
                            validaAmountToFund(contxt);
                          },
                          title: 'Pay',
                          btnWidth: size.width,
                          btnHeight: 50,
                          textSize: 21,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
  }

  validaAmountToFund(BuildContext? context) {
    int amount = int.parse(_textController.value.text);
    BuildContext contxt = AppContext.masterKey;
    if (amount > 2400) {
      showAlertDialog(context ?? contxt,
          messageContent: Text(
            'You Can only fund  ${ngn}2,400.00 or less,so try lesser amount',
            style: Theme.of(context ?? contxt).textTheme.bodyText2,
          ),
          heightPercent: 0.2);
    } else if (amount <= 2400) {
      double transactionCharges = (1.5 / 100) * amount;
      double totalPayment = transactionCharges + amount;
      // log(totalPayment.toString());
      showAlertDialog(context ?? contxt,
          icon: const Icon(Icons.cancel_outlined),
          tapOnIcon: () => Navigator.pop(context ?? contxt),
          messageContent: Text(
            'You will be charge ${Utilities().ngnFormat(context ?? contxt).format(transactionCharges)} for this transaction, press Ok to Continue',
            // 'You are about to Make Payment of  ${Utilities().ngnFormat(context).format(totalPayment)} press Ok to Continue',
            style: Theme.of(context ?? contxt).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          heightPercent: 0.2,
          onTap: () {
            Navigator.pop(context ?? contxt);
            chargeCard(amount);
          });
    }
  }
}
