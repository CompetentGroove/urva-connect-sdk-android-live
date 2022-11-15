import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor2.dart';

const themecolor = Color(0xFFeeeeee);
Color white = Colors.white;
Color red = Colors.red;
const recievercolor = Color.fromRGBO(229, 229, 229, 1);
const settingicon = Color(0xFF475062);
const social_textColorPrimary = Color(0xFF333333);
const textColorSecondary = Color(0xFF9D9D9D);
const menucolor = Color(0xFFFAFAFA);
const unselectedtab = Color(0xFF7A7A7A);
const whatsapp = Color(0xFF075e54);
const whatsapp_light_color=Color(0xFFb8e8e2);
const facebook = Color(0xFF2C408D);
const facebook_light_color = Color(0xFFAAC9FF);
const twitter = Color(0xFF00acee);

const google = Color(0xFF4285F4);
const google_light_color=Color(0xFF71a3f2);

const twitter_light_color=Color(0xFF98d9f3);
const telegram = Color(0xFF0088cc);
const telegram_light_color=Color(0xFFb1e4fd);
const calls=Color(0xFFC81E1F);
const call_light_color=Color(0xFFffc7c7);
Color chatabselected = Color(0xFF0b4fb4);
// const chatabselected = Color(0xFF4978F1);

//#4978F1

const privatetheme = Color.fromRGBO(214, 214, 214, 90);
const converge_light_color=Color(0xFFd3e4fd);

 Color HeaderBackgroundColor =Color(int.parse("#F2F2F2".substring(1, 7), radix: 16) + 0xFF000000);
Color StickyHeaderTitleColor = Color(int.parse("#A8A8A8".substring(1, 7), radix: 16) + 0xFF000000);

var Headercolors = { "a": ["#ffcdd2", "#000000"], "b": ["#e53935", "#ffffff"], "c": ["#d32f2f", "#ffffff"], "d": ["#a5d6a7", "#000000"], "e": ["#d81b60", "#ffffff"], "f": ["#c2185b", "#ffffff"], "g": ["#ce93d8", "#000000"], "h": ["#7b1fa2", "#ffffff"], "i": ["#ffcc80", "#000000"], "j": ["#512da8", "#ffffff"], "k": ["#f48fb1", "#000000"],
  "l": ["#3949ab", "#ffffff"], "m": ["#009688", "#000000"], "n": ["#ffcc80", "#ffffff"], "o": ["#00796b", "#ffffff"],
  "p": ["#ffccbc", "#000000"], "q": ["#f4511e", "#ffffff"], "r": ["#e64a19", "#ffffff"], "s": ["#ffab91", "#000000"], "t": ["#6d4c41", "#ffffff"], "u": ["#5d4037", "#ffffff"], "v": ["#ef9a9a", "#000000"], "w": ["#e1bee7", "#000000"], "x": ["#c8e6c9", "#000000"], "y": ["#ffe0b2", "#000000"], "z": ["#80cbc4", "#000000"]   ,
};

Color GetColorFromString(String color){
  return TinyColor.fromString(color).color;
}

Color GetColorFromStringDarken(String color, int darken){
  return TinyColor.fromString(color).darken(darken).color;
}

Color GetColorDarken(Color colors, int darken){
  return TinyColor.fromColor(colors).darken(darken).color;
}


// Color changeColorSaturation(Color color, double newSaturationValue ) =>
//     HSLColor.fromColor(color).withSaturation(newSaturationValue).toColor();


Color GetColorFromStringLighten(String color, int lighten){
  return TinyColor.fromString(color).lighten(lighten).color;
}

