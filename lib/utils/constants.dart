import 'package:flutter/material.dart';
import 'package:lcpl_admin/screens/homescreen/tabs/audio_tab.dart';
import 'package:lcpl_admin/screens/homescreen/tabs/doc_tab.dart';
import 'package:lcpl_admin/screens/homescreen/tabs/quotes_tab.dart';
import 'package:lcpl_admin/screens/homescreen/tabs/video_tab.dart';

class Constants {
  static const String logo = 'assets/Lotte_Chemicals_Pak_Logo.png';
  static const String login = 'Login';
  static const String register = 'Signup';
  static const String loginPassword = 'Pakistan123!@#';
  static const String documents = 'Documents';
  static const String audios = 'Audios';
  static const String videos = 'videos';
  static const String quotes = 'Quotes';
  static const String cloudName = 'dxhhsvyh9';
  static const String uploadPreset = 'pztytpl7';
  static const String apiKey = '139194639628115';
  static const String apiSecret = 'crq7f6wso_OhEsFYJWBdwFju4Fo';
  static const List<Widget> widgetOptions = <Widget>[
    DocumentsTab(),
    AudioTab(),
    QuotesTab(),
    VideoTab(),
  ];
}
