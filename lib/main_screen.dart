import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/export.dart';

import 'checkout_screen.dart';
import 'cores/providers/main_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // InitializationCmd(context).initUser();
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 100,
          width: 200,
          child: Image.asset(
            "assets/images/paystack_logo.png",
            color: Colors.cyan.shade700,
          ),
        ),
        // centerTitle: true,
      ),
      bottomNavigationBar: const BottomNav(),
      body: Consumer<MainProvider>(builder: (context, store, child) {
        return IndexedStack(
          index: store.pageIndex,
          children: const [
            CardPayment(),
            CheckOutPayment(),
          ],
        );
      }),
    );
  }
}
