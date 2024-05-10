import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/Screens/Dashboard/components/addlist_createTextField.dart';
import 'package:flutter_manajemen_waktu/Screens/Dashboard/components/item.dart';
import 'package:flutter_manajemen_waktu/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_manajemen_waktu/constants.dart';
import 'package:intl/intl.dart';

class AddListForm extends StatefulWidget {
  final List<ItemBuilder> listItems;
  final dynamic Function(ItemBuilder item) addItem;

  const AddListForm({
    super.key,
    required this.listItems,
    required this.addItem,
  });

  @override
  _AddListFormState createState() => _AddListFormState();
}

class _AddListFormState extends State<AddListForm> {
  final TextEditingController _nameActivity = TextEditingController();
  final TextEditingController _dateActivity = TextEditingController();
  final TextEditingController _timeActivityFirst = TextEditingController();
  final TextEditingController _timeActivityEnd = TextEditingController();

  late DateTime _selectedDate;

  late TimeOfDay _selectedTimeFirst;
  late TimeOfDay _selectedTimeEnd;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Form(
          child: Column(
            children: [
              BuildFieldTextAddList(
                placeholder: "Masukan Nama Aktivitas",
                keyboardType: TextInputType.text,
                controller: _nameActivity,
              ),
              BuildFieldTextAddList(
                placeholder: "Masukan Tanggal Aktivitas",
                keyboardType: TextInputType.text,
                controller: _dateActivity,
                sufficIcon: IconButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    setState(
                      () {
                        if (date != null) {
                          final formatter = DateFormat('dd/MM/yyyy');
                          _dateActivity.text = formatter.format(date);
                          _selectedDate = date;
                        }
                      },
                    );
                  },
                  icon: const Icon(Icons.date_range),
                ),
              ),
              BuildFieldTextAddList(
                placeholder: "Masukan Waktu Awal Aktivitas",
                keyboardType: TextInputType.datetime,
                controller: _timeActivityFirst,
                sufficIcon: IconButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(
                      () {
                        if (time != null) {
                          _timeActivityFirst.text = time.format(context);
                          _selectedTimeFirst = time;
                        }
                      },
                    );
                  },
                  icon: const Icon(Icons.access_time),
                ),
              ),
              BuildFieldTextAddList(
                placeholder: "Masukan Waktu Akhir Aktivitas",
                keyboardType: TextInputType.datetime,
                controller: _timeActivityEnd,
                sufficIcon: IconButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(
                      () {
                        if (time != null) {
                          _timeActivityEnd.text = time.format(context);
                          _selectedTimeEnd = time;
                        }
                      },
                    );
                  },
                  icon: const Icon(Icons.access_time),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameActivity.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nama Aktivitas tidak boleh kosong"),
                        ),
                      );
                    } else if (_dateActivity.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Tanggal Aktivitas tidak boleh kosong"),
                        ),
                      );
                    } else if (_timeActivityFirst.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Waktu Awal Aktivitas tidak boleh kosong"),
                        ),
                      );
                    } else if (_timeActivityEnd.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Waktu Akhir Aktivitas tidak boleh kosong"),
                        ),
                      );
                    } else {
                      String first = _selectedTimeFirst.format(context);
                      String end = _selectedTimeEnd.format(context);

                      if (_selectedTimeFirst.hourOfPeriod >
                          _selectedTimeEnd.hourOfPeriod) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Waktu Awal Aktivitas tidak boleh lebih besar dari Waktu Akhir Aktivitas",
                            ),
                          ),
                        );
                      } else {
                        // If all fields are filled and time is valid, proceed with saving the data
                        final item = ItemBuilder(
                          title: _nameActivity.text,
                          date: _selectedDate.toIso8601String(),
                          timeFirst: first,
                          timeEnd: end,
                        );

                        widget.addItem(item);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DashboardScreen();
                            },
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButtonPrimaryColor,
                    elevation: 0,
                  ),
                  child: Text(
                    "Save".toUpperCase(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
