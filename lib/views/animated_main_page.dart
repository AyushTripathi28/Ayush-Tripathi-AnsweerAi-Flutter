import 'package:chatgpt_clone/providers/settings_provider.dart';
import 'package:chatgpt_clone/views/chat__screen/chat_screen.dart';
import 'package:chatgpt_clone/views/drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedMainPage extends StatefulWidget {
  const AnimatedMainPage({super.key});

  @override
  _AnimatedMainPageState createState() => _AnimatedMainPageState();
}

class _AnimatedMainPageState extends State<AnimatedMainPage> {
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: true);

    return Scaffold(
      body: Stack(
        children: [
          // The Drawer Content with its own AppBar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: settingsProvider.isDrawerOpen
                ? 0
                : -settingsProvider.getScreenSize(context),
            top: 0,
            bottom: 0,
            child: CustomDrawer(),
          ),
          // The Main Content (shifting to the right and down) with its own AppBar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: settingsProvider.isDrawerOpen
                ? settingsProvider.getScreenSize(context)
                : 0,
            right: settingsProvider.isDrawerOpen
                ? -settingsProvider.getScreenSize(context)
                : 0,
            top: settingsProvider.isDrawerOpen ? 0 : 0,
            bottom: 0,
            child: Material(
              elevation: settingsProvider.isDrawerOpen ? 8.0 : 0,
              borderRadius: settingsProvider.isDrawerOpen
                  ? const BorderRadius.all(Radius.circular(8))
                  : const BorderRadius.all(Radius.circular(0)),
              child: GestureDetector(
                  onTap: settingsProvider.isDrawerOpen
                      ? () {
                          settingsProvider.toggleDrawer();
                        }
                      : null,
                  child: ChatScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
