import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mainapp/main.dart';
import 'package:xml/xml.dart';

class ioService {
  ioService._privateConstructor();

  Vision? vision = null;


  static final ioService _instance = ioService._privateConstructor();


  factory ioService()
  {
    return _instance;
  }

  Future<Vision?> getApi()
  async {
    if(vision==null) {
      vision = GoogleMlKit.vision;
      print("LOCALE "+defaultLocale);
      print("MODEL "+defaultLocale.split("_")[1]);
      await vision!.languageModelManager().downloadModel(
          defaultLocale.split("_")[1]);
    }
    return vision;
  }


  Future<List<String>> parseXml(bool fromFile) async {
    final List<String> output = [];
    Iterable<XmlElement> elements = [];
    if (fromFile) {
      output.clear();
      String filename = 'assets/data/ingredients_' + defaultLocale + '.xml';
      String xmlString = await rootBundle.loadString(filename);
      final document = XmlDocument.parse(xmlString);
      elements = document.findAllElements("row");
      elements.forEach((element) {
        output.add(element.text);
      });
    }
    return output;
  }

  Future<Map<String, String>> parseAppXml(bool fromFile) async {
    Iterable<XmlElement> elements = [];
    XmlDocument document;
    final Map<String, String> output = new Map<String, String>();
    if (fromFile) {
      String filename = 'assets/data/appstring_' + defaultLocale + '.xml';
      String xmlString = await rootBundle.loadString(filename);
      document = XmlDocument.parse(xmlString);
      elements = document.findAllElements("item");
      elements.forEach((element) {
        if (element.hasParent) {
          // print(element.getAttribute("name"));
          output.putIfAbsent(element.getAttribute("name")!, () => element.text);
        }
      });
    }
    return output;
  }

}