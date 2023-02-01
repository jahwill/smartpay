import 'package:flutter/material.dart';

import '../../components/msc/buttons.dart';

const ngn = '₦';
const double globalButtonSize = 45.0;

showAlertDialog(BuildContext context,
    {VoidCallback? onTap,
    VoidCallback? tapOnIcon,
    required Widget messageContent,
    String alertTitle = '',
    double heightPercent = 0.4,
    Icon? icon,
    String proceedBtnTitle = 'ok'}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            insetPadding: const EdgeInsets.all(2),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    top: -40,
                    left: -40,
                    child: GestureDetector(
                      onTap: tapOnIcon,
                      child: CircleAvatar(
                        child: icon ??
                            const Icon(
                              Icons.notifications_active_outlined,
                              color: Colors.white,
                            ),
                      ),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    alertTitle,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.blue[800]),
                  ),
                ),
              ],
            ),
            content: Container(
              width: size.width * 0.85,
              constraints: BoxConstraints(
                minHeight: size.height * heightPercent,
                maxHeight: 600,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    messageContent,
                    const SizedBox(height: 40),
                    EvCustomBtn(
                      ontap: onTap ?? () => Navigator.pop(context),
                      btnWidth: 200,
                      btnHeight: globalButtonSize,
                      textSize: 25,
                      title: proceedBtnTitle,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ));
      });
}

optionDialogBtn(BuildContext context,
    {VoidCallback? onTap,
    String subTitle = 'subTitle here',
    String title = 'title',
    String secondBTNTitle = 'Ok',
    firstBTNTitle = 'Cancel'}) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            insetPadding: const EdgeInsets.all(2),
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Center(
                child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.w500),
            )),
            content: SizedBox(
              height: 150.0,
              width: 200,
              child: Column(
                children: [
                  const Divider(),
                  SizedBox(
                      height: 58,
                      // width: 70,
                      child: Text(
                        subTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EvCustomBtn(
                        ontap: () {
                          Navigator.pop(context);
                        },
                        title: firstBTNTitle,
                        borderColor: Theme.of(context).primaryColor,
                        btnWidth: 90,
                        btnHeight: globalButtonSize,
                        textSize: 20,
                        bgColor: Colors.transparent,
                      ),
                      const SizedBox(width: 20),
                      EvCustomBtn(
                          ontap: onTap,
                          btnWidth: 90,
                          textSize: 20,
                          title: secondBTNTitle,
                          btnHeight: globalButtonSize),
                    ],
                  )
                ],
              ),
            ));
      });
}

Widget customTextFieldWithController(
    TextEditingController innerTextController, BuildContext context,
    {Function? onChange,
    String hint = 'Airtime Amount',
    TextInputType textInputType = TextInputType.number,
    Widget? suffixIcon}) {
  return Container(
    height: 48,
    padding: const EdgeInsets.only(
      top: 2,
    ),
    child: TextField(
      controller: innerTextController,
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon ?? const SizedBox.shrink(),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: Colors.grey[600]),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.8, color: Colors.black45),
            borderRadius: BorderRadius.circular(10)),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.3, color: Colors.cyan),
            borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: (val) {
        onChange == null ? null : onChange(val);
      },
    ),
  );
}
