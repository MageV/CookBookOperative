
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_ocr_plugin/simple_ocr_plugin.dart';
import 'dart:io' as io;



import '../main.dart';

//TO-DO need to download from https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_ml_vision/lib/src/barcode_detector.dart

enum stepID { stepID_One, stepID_Two, stepID_Three }


class RecipeItemCamera extends StatefulWidget {
  RecipeItemCamera({Key? key}) : super(key: key);
  static const routeName = '/RecipeItemCamera';

  @override
  _RecipeItemCameraState createState() => _RecipeItemCameraState();
}

class _RecipeItemCameraState extends State<RecipeItemCamera> {
  final _formKey = GlobalKey<_RecipeItemCameraState>();
  Map<stepID, Image> images = new Map();
  Map<stepID, Size> imagesizes=new Map();
  late bool _complete=false;
  int _currentStep = 0;
  //late io.File _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: Stepper(
              controlsBuilder: (BuildContext context,
                  {VoidCallback? onStepContinue, VoidCallback? onStepCancel})
                {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: onStepContinue,
                        child: Icon(Icons.add_a_photo_rounded),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.red)
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onStepCancel,
                        child:Icon(Icons.clear),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent)
                        ),
                      )
                    ],
                  );
                },
                type: StepperType.vertical,
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue:()=> continued(_currentStep,context),
                onStepCancel: cancel,
                steps: <Step>[
              Step(
                  title: Text(LocaleService.of("recipe_cam_step1_title")),
                  content: Column(
                    children: [
                      Text(LocaleService.of("recipe_cam_step1_subtitle")),

                    ],
                  )),
              Step(
                  title: Text(LocaleService.of("recipe_cam_step2_title")),
                  content: Column(
                    children: [
                      Text(LocaleService.of("recipe_cam_step2_subtitle")),

                    ],
                  )),
              Step(
                  title:Text( LocaleService.of("recipe_cam_step3_title")),
                  content: Column(
                    children: [
                      Text(LocaleService.of("recipe_cam_step3_subtitle")),

                    ],
                  ))
            ]))
      ],
    ));
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued(int step,BuildContext context) async{
    switch(step)
    {
      case 0: {await _getFileFromCamera(context,stepID.stepID_One);break;}
      case 1: {await _getFileFromCamera(context,stepID.stepID_Two);break;}
      case 2: {await _getFileFromCamera(context,stepID.stepID_Three);break;}
    }
    _currentStep <2 ? setState(() => _currentStep += 1) : _finishRecipe();
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  _getFileFromCamera(BuildContext context, stepID step) async {
    try {
      final Completer<Size> completer = Completer<Size>();
      final XFile? file =
          await ImagePicker().pickImage(source: ImageSource.camera);
      Image image=decodeXFile(file!);
      image.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool _) {
          completer.complete(Size(
            info.image.width.toDouble(),
            info.image.height.toDouble(),
          ));
        }),
      );
      final Size imageSize = await completer.future;
      imagesizes.putIfAbsent(step, () => imageSize);
      images.putIfAbsent(step,()=> image);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Image decodeXFile(XFile infile)
   {
    final path=io.File(infile.path);
    return Image.file(path);
  }

  _finishRecipe()
  async{
    Image ingredients=images[stepID.stepID_One]!;
    Image process=images[stepID.stepID_Two]!;
    //String ingrs_string=await SimpleOcrPlugin.performOCR()
  }
}
