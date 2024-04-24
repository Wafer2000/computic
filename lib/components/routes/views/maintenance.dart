// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:computic/components/routes/tools/my_drawer.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';

class Maintenance extends StatefulWidget {
  static const String routname = '/maintenance';
  const Maintenance({super.key});

  @override
  State<Maintenance> createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Maintenance')),
        actions: const [
          SizedBox(
            width: 48,
          )
        ],
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? WallpaperColor.steelBlue().color
            : WallpaperColor.kashmirBlue().color,
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
