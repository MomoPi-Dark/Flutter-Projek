import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/constants.dart';

class LayoutScreen extends StatelessWidget {
  final Widget? child;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;

  const LayoutScreen({
    super.key,
    this.child,
    this.title,
    this.leading,
    this.actions,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: kBgPrimaryColor,
        elevation: 0,
        leading: leading,
        actions: actions,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black, // Set black color for the bottom border
            height: 1.0, // Adjust height of the bottom border
          ),
        ),
      ),

      // FLOATING
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,

      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          onTap: () => {FocusScope.of(context).unfocus()},
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: backgroundColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: defaultPadding,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
