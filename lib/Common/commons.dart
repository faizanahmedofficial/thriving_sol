import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Screens/Discover/discover_page.dart';
import 'package:schedular_project/Screens/Routines/routine_screen.dart';
import 'package:schedular_project/Screens/accomplishment_screen.dart';

import '../Screens/Settings/settings.dart';

List<IconButton> appactions = [
  IconButton(
    tooltip: 'Routines',
    padding: const EdgeInsets.all(0),
    icon: const Icon(Icons.calendar_today),
    onPressed: () => Get.to(() => const AppRoutines()),
  ),
  IconButton(
    tooltip: 'Discover Page',
    padding: const EdgeInsets.all(0),
    icon: const Icon(Icons.local_florist),
    onPressed: () => Get.to(() => const DiscoverPage()),
  ),
  IconButton(
    tooltip: 'Accomplishments',
    padding: const EdgeInsets.all(0),
    icon: const Icon(Icons.star),
    onPressed: () => Get.to(() => const AccomplishmentScreen()),
  ),
  IconButton(
    tooltip: 'Settings',
    padding: const EdgeInsets.all(0),
    icon: const Icon(Icons.settings_outlined),
    onPressed: () => Get.to(() => const Settings()),
  ),
];
