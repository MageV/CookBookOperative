import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
//import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:mainapp/main.dart';
import 'package:xml/xml.dart';




class ioService {
  ioService._privateConstructor();

//  Vision? vision = null;



  static final ioService _instance = ioService._privateConstructor();


  factory ioService()
  {
    return _instance;
  }

 /* Future<Vision?> getApi()
  async {
    if(vision==null) {
      vision = GoogleMlKit.vision;
      print("LOCALE "+defaultLocale);
      print("MODEL "+defaultLocale.split("_")[1]);
      await vision!.languageModelManager().downloadModel(
          defaultLocale.split("_")[1]);
    }
    return vision;
  }*/



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

  Future<String> retrieveRemote(String key)
  async{
    if(Firebase.apps.length==0) {
      Firebase.initializeApp(name: "My cookbook");
    }
    RemoteConfig config=RemoteConfig.instance;//});
    await config.fetchAndActivate();
    String value=config.getValue(key).asString();
    print("KEY"+value);
    return value;
  }


  Future<String> parseImageFree(XFile image)
  async{
    //String key=await retrieveRemote("OCRFree");
    String key="44cb80079a88957";
    String locale=defaultLocale.split('_')[1];
    String _url = "https://api.ocr.space/parse/image";
    Map<String,String> httpParams=new Map();
    String langkey="";
    switch(locale)
    {
      case 'EN':
        {
          langkey='eng';
          break;
        }
      case 'RU':
        {
          langkey='rus';
          break;
        }
      default:
        {
          langkey='eng';
          break;
        }
    }

    String ImgBase64=base64Encode(io.File(image.path).readAsBytesSync());
    httpParams.putIfAbsent("apiKey", () => key);
    print(key);
    httpParams.putIfAbsent("language", () => langkey);
    httpParams.putIfAbsent("base64Image", () => ImgBase64);
    Uri uri=Uri.parse(_url);
    http.Response response=await http.post(uri,body:httpParams);
    return (response.body);
  }


  Future<String> parseImageGoogle(XFile image) async{
    String ImgBase64=base64Encode(io.File(image.path).readAsBytesSync());
    String key=await retrieveRemote("OCRKey_Google");
    String langkey=defaultLocale.split('_')[1];
    String body = """{
   "requests":[
      {
         "features":[
            {
               "type":"DOCUMENT_TEXT_DETECTION"
            }
         ],
         "image":{
            "content":"$ImgBase64"
         },
         "imageContext":{
            "languageHints":[
               "$langkey"
            ]
         }
      }
   ]
}""";
    String _url='https://vision.googleapis.com/v1/images:annotate?key=$key';
    Uri uri=Uri.parse(_url);
    http.Response response=await http.post(uri,body:body);
    return (response.body);
  }
}