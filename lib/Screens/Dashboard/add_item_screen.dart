import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/Screens/Dashboard/components/form_addlist.dart';
import 'package:flutter_manajemen_waktu/components/back.dart';
import 'package:flutter_manajemen_waktu/constants.dart';
import 'package:flutter_manajemen_waktu/layout.dart';
import 'package:flutter_manajemen_waktu/responsive.dart';

import 'components/item.dart';

class AddItem extends StatefulWidget {
  final List<ItemBuilder> listItems;
  final dynamic Function(ItemBuilder addItem) addItem;

  const AddItem({
    super.key,
    required this.listItems,
    required this.addItem,
  });

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  DateTime today = DateTime.now();
  // DateTime _focusedDay = DateTime.now();
  // DateTime _selectedDay = DateTime.now();

  // void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
  //   setState(() {
  //     _selectedDay = selectedDay;
  //     _focusedDay = focusedDay;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
      backgroundColor: kBgPrimaryColor,
      leading: const ArrowBack(),
      title: const Text(
        "Add Activity",
        style: TextStyle(
          fontSize: 25,
          color: titleColor,
          fontFamily: "SF Pro Display",
          fontWeight: FontWeight.bold,
        ),
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            mobile: MobileItemAddScreen(
              items: widget.listItems,
              saveItem: widget.addItem,
            ),
            desktop: DesktopItemAddScreen(
              listItems: widget.listItems,
              saveItem: widget.addItem,
            ),
          ),
        ),
      ),
    );
  }
}

class DesktopItemAddScreen extends StatelessWidget {
  final List<ItemBuilder> listItems;
  final dynamic saveItem;

  const DesktopItemAddScreen({
    super.key,
    required this.listItems,
    required this.saveItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AddListForm(
            listItems: listItems,
            addItem: saveItem,
          ),
        )
      ],
    );
  }
}

class MobileItemAddScreen extends StatelessWidget {
  final List<ItemBuilder> items;
  final dynamic saveItem;

  const MobileItemAddScreen({
    super.key,
    required this.items,
    required this.saveItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddListForm(
          listItems: items,
          addItem: saveItem,
        )
      ],
    );
  }
}
