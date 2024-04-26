import 'package:computic/components/routes/tools/my_drawer.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';

class ShopeService extends StatefulWidget {
  static const String routname = '/shope';
  const ShopeService({super.key});

  @override
  State<ShopeService> createState() => _ShopeServiceState();
}

class _ShopeServiceState extends State<ShopeService> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Tienda')),
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
              child: FloatingActionButton(
                mini: true,
                onPressed: () {},
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? WallpaperColor.danube().color
                        : WallpaperColor.baliHai().color,
                child: const Text('Nueva Creacion'),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Column(
                  children: [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}