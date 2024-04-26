import 'package:computic/components/routes/tools/my_drawer.dart';
import 'package:computic/components/routes/views/services/creation.dart';
import 'package:computic/components/routes/views/services/facility.dart';
import 'package:computic/components/routes/views/services/maintenance.dart';
import 'package:computic/components/routes/views/services/rent.dart';
import 'package:computic/components/routes/views/services/shope.dart';
import 'package:computic/components/routes/views/services/training.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String routname = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 170,
                        height: 170,
                        child: FloatingActionButton.extended(
                          heroTag: 'mantenimientoTag',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MaintenanceService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.school,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Mantenimiento',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 170,
                        height: 170,
                        child: FloatingActionButton.extended(
                          heroTag: 'capacitacionTag',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, TrainingService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.school,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Capacitacion',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 170,
                        height: 170,
                        child: FloatingActionButton.extended(
                          heroTag: 'instalacionTag',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, FacilityService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_repair_service,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Instalacion',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 170,
                        height: 170,
                        child: FloatingActionButton.extended(
                          heroTag: 'creacionTag',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, CreationService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Creacion',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 170,
                        height: 170,
                        child: FloatingActionButton.extended(
                          heroTag: 'alquilerTag',
                          onPressed: () {
                            Navigator.pushNamed(context, RentService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.device_hub,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Alquiler',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 170,
                        height: 170,
                        child: FloatingActionButton.extended(
                          heroTag: 'tiendaTag',
                          onPressed: () {
                            Navigator.pushNamed(context, ShopeService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.store,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Tienda',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

/*
Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: FloatingActionButton.extended(
                          heroTag: mantenimientoTag,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MaintenanceService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.build,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text('Mantenimiento'),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: FloatingActionButton.extended(
                          heroTag: capacitacionTag,
                          onPressed: () {
                            Navigator.pushNamed(context, TrainingService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.school,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text('Capacitacion'),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: FloatingActionButton.extended(
                          heroTag: instalacionTag,
                          onPressed: () {
                            Navigator.pushNamed(context, FacilityService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_repair_service,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text('Instalacion'),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: FloatingActionButton.extended(
                          heroTag: creacionTag,
                          onPressed: () {
                            Navigator.pushNamed(context, CreationService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text('Instalacion'),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: FloatingActionButton.extended(
                          heroTag: alquilerTag,
                          onPressed: () {
                            Navigator.pushNamed(context, RentService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.device_hub,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text('Alquiler'),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: FloatingActionButton.extended(
                          heroTag: alquilerTag,
                          onPressed: () {
                            Navigator.pushNamed(context, RentService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.store,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                              const SizedBox(height: 8),
                              const Text('Tienda'),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.danube().color
                                  : WallpaperColor.baliHai().color,
                        ),
                      ),
                    ],
                  ),
                )
*/