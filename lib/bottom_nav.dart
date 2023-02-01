import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cores/providers/main_provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);
  static List<Map<String, dynamic>> navItems = [
    {"icon": Icons.wallet, "label": "Card Payment", 'setIndex': 0},
    {"icon": Icons.account_balance, "label": "Check Out", 'setIndex': 1},
  ];
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = navItems;
    return Consumer<MainProvider>(
      builder: (context, store, child) {
        return Container(
          height: 75,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 3),
          margin: const EdgeInsets.only(bottom: 0.5),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.08),
                    offset: Offset(0, 0),
                    blurRadius: 4,
                    spreadRadius: 2),
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(
                items.length,
                (index) => _NavItem(
                  icon: items[index]['icon'],
                  title: items[index]['label'],
                  isSelected: store.pageIndex == index,
                  onPressed: () => store.setPageIndex = index,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem(
      {Key? key,
      required this.icon,
      required this.title,
      required this.isSelected,
      this.onPressed})
      : super(key: key);
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(
                    icon,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.withOpacity(.4),
                  )),
              const SizedBox(height: 5),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.withOpacity(.4),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
