import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AnimatedAlertModal {
  static double get sm => 6;

  static double get m => 12;

  static double get l => 20;

  static double get xl => 36;
  static Future<Object?> showEmptyModal(BuildContext context,
      {String? title,
      TextStyle? titleStyle,
      Widget? body,
      String? iconPath,
      bool showIcon = true,
      double screenFraction = 0.4}) {
    bool fromTop = true;
    Size size = MediaQuery.of(context).size;
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment:
              fromTop == true ? Alignment.topCenter : Alignment.bottomCenter,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 400),
            margin: EdgeInsets.only(
                top: size.height * screenFraction,
                left: 20,
                right: 20,
                bottom: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: l, vertical: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 20,
                        width: 40,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -45.0,
                              child: showIcon
                                  ? CircleAvatar(
                                      radius: 28,
                                      child: Image.asset(iconPath!),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    title == null
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 10),
                    title == null
                        ? const SizedBox.shrink()
                        : Text(
                            title,
                            textAlign: TextAlign.center,
                            style: titleStyle ??
                                Theme.of(context).textTheme.headline5?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF1D43FE)),
                          ),
                    const SizedBox(height: 20),
                    body ?? const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
                  begin: Offset(0, fromTop == true ? -1 : 1),
                  end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  static Future<Object?> showNetworkExceptionModal(BuildContext context,
      {String? title,
      Widget? body,
      String? iconPath,
      double screenFraction = 0.4}) {
    bool fromTop = true;
    Size size = MediaQuery.of(context).size;
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment:
              fromTop == true ? Alignment.topCenter : Alignment.bottomCenter,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 270),
            margin: EdgeInsets.only(
                top: size.height * screenFraction,
                left: l,
                right: l,
                bottom: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: l, vertical: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 20,
                        width: 40,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -45.0,
                              child: CircleAvatar(
                                radius: 28,
                                child: Icon(FeatherIcons.alertOctagon),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    title == null
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 10),
                    title == null
                        ? const SizedBox.shrink()
                        : Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF1D43FE)),
                          ),
                    const SizedBox(height: 20),
                    body ?? const SizedBox.shrink(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
                  begin: Offset(0, fromTop == true ? -1 : 1),
                  end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  static Future<Object?> emptyModalWithNoTitle(BuildContext context,
      {String? title,
      TextStyle? titleStyle,
      Widget? body,
      String? iconPath,
      bool showIcon = true,
      Color? bgColor,
      bool fromTop = true,
      bool autoPop = true,
      Duration? closeDuration,
      double screenFraction = 0.4}) {
    bool dialogIsOpen = true;

    autoPop
        ? Future.delayed(closeDuration ?? const Duration(seconds: 3), () {
            if (dialogIsOpen == true) {
              Navigator.of(context, rootNavigator: true).pop();
            } else {
              null;
            }
          })
        : null;
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.transparent.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 620),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        Size size = MediaQuery.of(context).size;

        return Align(
          alignment:
              fromTop == true ? Alignment.topCenter : Alignment.bottomCenter,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 280),
            margin: EdgeInsets.only(
                top: size.height * screenFraction,
                left: m,
                right: m,
                bottom: 50),
            decoration: BoxDecoration(
              color: bgColor ?? Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: l, vertical: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    showIcon
                        ? Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 20,
                              width: 40,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: -45.0,
                                    child: CircleAvatar(
                                      radius: 28,
                                      child: Icon(FeatherIcons.alertOctagon),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 8),
                    body ?? const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (modalContext, anim1, anim2, child) {
        // thisContext = modalContext;

        return SlideTransition(
          position: Tween(
                  begin: Offset(0, fromTop == true ? -1 : 1),
                  end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    ).then((value) {
      dialogIsOpen = false;
      // print(dialogIsOpen);
      return true;
    });
  }
}
