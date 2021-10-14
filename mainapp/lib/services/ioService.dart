import 'dart:convert';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
//import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:mainapp/main.dart';
import 'package:xml/xml.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as html_dom;





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

  Future<String> retrieveRemote(String key) async {
    if (Firebase.apps.length == 0) {
      Firebase.initializeApp(name: "My cookbook");
    }
    RemoteConfig config = RemoteConfig.instance; //});
    await config.fetchAndActivate();
    String value = config.getValue(key).asString();
    print("KEY" + value);
    return value;
  }

  Future<String> Image2Pdf(XFile file) async {
    final ByteData data = ByteData.sublistView(await file.readAsBytes());
    PdfDocument document = PdfDocument();
    PdfPage page = document.pages.add();
    final PdfImage image = PdfBitmap(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)
    );
    page.graphics.drawImage(
        image, Rect.fromLTWH(0, 0, page.size.width, page.size.height));
    page.graphics.colorSpace = PdfColorSpace.grayScale;
    document.compressionLevel = PdfCompressionLevel.normal;
    List<int> retList = document.save();
    String b64e = base64Encode(retList);
    String header = "data:application/pdf;base64,";
    String returnValue = header + b64e;
    print("SIZE:" + (returnValue.length / 1024).toString());
    return returnValue;
  }

  Future<dynamic> parse({String? url,
                        required bool fromFile,
                        XFile? file,
                        bool? free})
  async{
    if(fromFile)
      {
        if(free!)
          {
            return parseImageFree(file!);
          }
        else
          {
            return parseImageGoogle(file!);
          }
      }
    else
      {
        String fetched=await fetchHTML(url!);
        html_dom.Document parsed= parser.parse(fetched);
      }
  }


  Future<String> parseImageFree(XFile image) async {
    //String key=await retrieveRemote("OCRFree");
    String key = "44cb80079a88957";
    String locale = defaultLocale.split('_')[1];
    String _url = "https://api.ocr.space/parse/image";
    Map<String, dynamic> httpParams = new Map();
    Map<String, String> httpHeaders = new Map();
    String langkey = "";
    switch (locale) {
      case 'EN':
        {
          langkey = 'eng';
          break;
        }
      case 'RU':
        {
          langkey = 'rus';
          break;
        }
      default:
        {
          langkey = 'eng';
          break;
        }
    }
    httpParams.putIfAbsent("apiKey", () => key);
    String base64String = await Image2Pdf(image);
    httpParams.putIfAbsent("base64Image", () => base64String);
    httpParams.putIfAbsent("IsOverlayRequired", () => "true");
    httpHeaders.putIfAbsent("User-Agent", () => "Mozilla/5.0");
    httpHeaders.putIfAbsent("Accept-Language", () => "$defaultLocale,$langkey");
    Uri uri = Uri.parse(_url);
    http.Response response = await http.post(
        uri, headers: httpHeaders, body: httpParams);
    print(response.body);
    return (response.body);
  }


  Future<String> parseImageGoogle(XFile image) async {
    final String  ImgBase64 = base64Encode(io.File(image.path).readAsBytesSync());
    String key = await retrieveRemote("OCRKey_Google");
    final String langkey = defaultLocale.split('_')[1];
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
    String _url = 'https://vision.googleapis.com/v1/images:annotate?key=$key';
    Uri uri = Uri.parse(_url);
    http.Response response = await http.post(uri, body: body);
    return (response.body);
  }

  Future<String> fetchHTML(String url)
  async{
    final response=await http.get(Uri.parse(url));
    if(response.statusCode==200)
      {
        return response.body;
      }
    throw Exception("html retrieve Failed");
  }
}

