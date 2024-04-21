import 'package:flutter/material.dart';

/*
Black: White (0xFFFFFFFF)
White: Black (0xFF000000)
Venice Blue: Iceberg (0xFFE5F3F7)
Iceberg: Venice Blue (0xFF07529B)
Steel Blue: Kashmir Blue (0xFF4D7397)
Viking: Blue Zodiac (0xFF123353)
Kashmir Blue: Steel Blue (0xFF4E8EB9)
Blue Zodiac: Viking (0xFF70B3DC)
Danube: Bali Hai (0xFF8894B2)
Catalina Blue: Danube (0xFF639DD6)
Bali Hai: Catalina Blue (0xFF062A78)
*/ 

class WallpaperColor {
  final Color color;

  const WallpaperColor._(this.color);

  factory WallpaperColor.black() {
    return const WallpaperColor._(Color(0xFF000000));
  }

  factory WallpaperColor.white() {
    return const WallpaperColor._(Color(0xFFFFFFFF));
  }

  factory WallpaperColor.veniceBlue() {
    return const WallpaperColor._(Color(0xFF07529B));
  }

  factory WallpaperColor.iceberg() {
    return const WallpaperColor._(Color(0xFFE5F3F7));
  }

  factory WallpaperColor.steelBlue() {
    return const WallpaperColor._(Color(0xFF4E8EB9));
  }

  factory WallpaperColor.viking() {
    return const WallpaperColor._(Color(0xFF70B3DC));
  }

  factory WallpaperColor.kashmirBlue() {
    return const WallpaperColor._(Color(0xFF4D7397));
  }

  factory WallpaperColor.blueZodiac() {
    return const WallpaperColor._(Color(0xFF123353));
  }

  factory WallpaperColor.danube() {
    return const WallpaperColor._(Color(0xFF639DD6));
  }

  factory WallpaperColor.catalinaBlue() {
    return const WallpaperColor._(Color(0xFF062A78));
  }

  factory WallpaperColor.baliHai() {
    return const WallpaperColor._(Color(0xFF8894B2));
  }
}

class IconColor {
  final Color color;

  const IconColor._(this.color);

  factory IconColor.black() {
    return const IconColor._(Color(0xFF040606));
  }

  factory IconColor.white() {
    return const IconColor._(Color(0xFFFFFFFF));
  }

  factory IconColor.veniceBlue() {
    return const IconColor._(Color(0xFF07529B));
  }

  factory IconColor.iceberg() {
    return const IconColor._(Color(0xFFE5F3F7));
  }

  factory IconColor.steelBlue() {
    return const IconColor._(Color(0xFF4E8EB9));
  }

  factory IconColor.viking() {
    return const IconColor._(Color(0xFF70B3DC));
  }

  factory IconColor.kashmirBlue() {
    return const IconColor._(Color(0xFF4D7397));
  }

  factory IconColor.blueZodiac() {
    return const IconColor._(Color(0xFF123353));
  }

  factory IconColor.danube() {
    return const IconColor._(Color(0xFF639DD6));
  }

  factory IconColor.catalinaBlue() {
    return const IconColor._(Color(0xFF062A78));
  }

  factory IconColor.baliHai() {
    return const IconColor._(Color(0xFF8894B2));
  }
}

class TextColor {
  final Color color;

  const TextColor._(this.color);

  factory TextColor.black() {
    return const TextColor._(Color(0xFF000000));
  }

  factory TextColor.white() {
    return const TextColor._(Color(0xFFFFFFFF));
  }

  factory TextColor.veniceBlue() {
    return const TextColor._(Color(0xFF07529B));
  }

  factory TextColor.iceberg() {
    return const TextColor._(Color(0xFFE5F3F7));
  }

  factory TextColor.steelBlue() {
    return const TextColor._(Color(0xFF4E8EB9));
  }

  factory TextColor.viking() {
    return const TextColor._(Color(0xFF70B3DC));
  }

  factory TextColor.kashmirBlue() {
    return const TextColor._(Color(0xFF4D7397));
  }

  factory TextColor.blueZodiac() {
    return const TextColor._(Color(0xFF123353));
  }

  factory TextColor.danube() {
    return const TextColor._(Color(0xFF639DD6));
  }

  factory TextColor.catalinaBlue() {
    return const TextColor._(Color(0xFF062A78));
  }

  factory TextColor.baliHai() {
    return const TextColor._(Color(0xFF8894B2));
  }
}