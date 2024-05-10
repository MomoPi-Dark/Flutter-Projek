import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/Screens/Dashboard/add_item_screen.dart';
import 'package:flutter_manajemen_waktu/constants.dart';
import 'package:flutter_manajemen_waktu/layout.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../responsive.dart';
import 'components/item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late SharedPreferences sp;

  List<ItemBuilder> items = [];

  int selectedIndex = -1;
  bool focusPress = false;

  @override
  void initState() {
    getSharedPrefrences();
    super.initState();
  }

  setFocusIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  setFocusPress(bool focus) {
    setState(() {
      focusPress = focus;
    });
  }

  getSharedPrefrences() async {
    // await resetSharedPreferences();
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  resetSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    print("SharedPreferences reset successfully.");
  }

  saveIntoSp() {
    List<String> listItems =
        items.map((item) => jsonEncode(item.toJson())).toList();

    sp.setStringList("items", listItems);
  }

  addItem(ItemBuilder item) {
    setState(() {
      items.add(item);
    });

    saveIntoSp();
  }

  deleteItem(ItemBuilder item) {
    setState(() {
      items.remove(item);
    });

    saveIntoSp();
  }

  readFromSp() {
    List<String>? listItems = sp.getStringList("items");

    if (listItems != null) {
      setState(() {
        items = listItems
            .map((item) => ItemBuilder.fromJson(jsonDecode(item)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
        backgroundColor: kBgPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 3,
              bottom: 3,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(
                Icons.account_circle,
                size: 45,
              ),
              iconSize: 23,
              color: kBgSecondaryColor,
              tooltip: 'Profile',
            ),
          ),
        ],
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItem(
                      listItems: items,
                      addItem: addItem,
                    ),
                  ));
            },
            backgroundColor: Colors.amberAccent,
            tooltip: "Add Activity",
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        child: Responsive(
          mobile: MobileDashboardScreen(
            listItems: items,
            focusPress: focusPress,
            selectedIndex: selectedIndex,
            deleteItem: deleteItem,
            setFocusIndex: setFocusIndex,
            setFocusPress: setFocusPress,
          ),
          desktop: DesktopDashboardScreen(listItems: items),
        ));
  }
}

class DesktopDashboardScreen extends StatelessWidget {
  final List<ItemBuilder> listItems;

  const DesktopDashboardScreen({
    Key? key,
    required this.listItems,
  });

  @override
  Widget build(BuildContext context) {
    return const Text("TOLOl");
  }
}

class MobileDashboardScreen extends StatelessWidget {
  final List<ItemBuilder> listItems;
  final int selectedIndex;
  final bool focusPress;
  final Function(ItemBuilder) deleteItem;
  final Function(int index) setFocusIndex;
  final Function(bool focus) setFocusPress;

  const MobileDashboardScreen({
    Key? key,
    required this.listItems,
    required this.selectedIndex,
    required this.deleteItem,
    required this.focusPress,
    required this.setFocusIndex,
    required this.setFocusPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (listItems.isNotEmpty) ...[
          Expanded(
            child: ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return getRow(context, index);
              },
            ),
          ),
        ] else ...[
          Center(
            child: Image.asset(
              "assets/images/not_data.png",
              width: 300,
              height: 500,
            ),
          ),
        ],
      ],
    );
  }

  Widget getRow(BuildContext context, int index) {
    ItemBuilder item = listItems[index];

    return Card(
      // color: selectedIndex == index ? Colors.amberAccent : Colors.white,
      child: ListTile(
        minVerticalPadding: 30,
        onTap: () {
          setFocusIndex(index);
          setFocusPress(true);

          showDialog(
            context: context,
            builder: (builder) {
              return AlertDialog(
                title: Text(item.title),
                content: ListTile(
                  title: Text(
                      "Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(item.date))}"),
                  subtitle: SizedBox(
                    height: 60, // Adjust the height as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Start Time: ${item.timeFirst}"),
                        Text("End Time: ${item.timeEnd}"),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  ),
                ],
              );
            },
          );
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "${DateFormat('dd/MM/yyyy').format(DateTime.parse(item.date))} (${item.timeFirst}) - (${item.timeEnd})",
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text("Edit"),
                value: "edit",
              ),
              const PopupMenuItem(
                child: Text("Delete"),
                value: "delete",
              ),
            ];
          },
          onSelected: (value) {
            if (value == "delete") {
              showDialog(
                  context: context,
                  builder: (builder) {
                    return AlertDialog(
                      title: const Text("Delete"),
                      content:
                          const Text("Are you sure want to delete this item?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            deleteItem(item);
                            Navigator.pop(context);
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
