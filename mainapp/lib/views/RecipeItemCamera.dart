import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

import '../main.dart';

//TO-DO need to download from https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_ml_vision/lib/src/barcode_detector.dart

class RecipeItemCamera extends StatefulWidget {
  RecipeItemCamera({Key? key}) : super(key: key);
  static const routeName = '/RecipeItemCamera';

  @override
  _RecipeItemCameraState createState() => _RecipeItemCameraState();
}

class _RecipeItemCameraState extends State<RecipeItemCamera> {
  final _formKey = GlobalKey<_RecipeItemCameraState>();
  late io.File _file_ing;
  late io.File _file_desc;
  late io.File _file_img;
  //late io.File _file;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CoolStepper(onCompleted: _onStepperCompleted(), steps: <CoolStep>[
        CoolStep(
            title: LocaleService.of("recipe_cam_step1_title")!,
            subtitle: LocaleService.of("recipe_cam_step1_subtitle")!,
            content: Container(
              child: Center(
                child:LimitedBox(
                  child:Image.file(_file_ing),
                  maxHeight: 300,
                )
              ),
            ),
            validation: () {
              if(!(_file_ing.exists() as bool))
              {
                _file_ing=_getFileFromCamera(context) as io.File;
              }
              else
                {
                  return null;
                }
            }),
        CoolStep(
            title: LocaleService.of("recipe_cam_step2_title")!,
            subtitle: LocaleService.of("recipe_cam_step2_subtitle")!,
            content: Container(
              child: Center(
                  child:LimitedBox(
                    child:Image.file(_file_desc),
                    maxHeight: 300,
                  )
              ),
            ),
            validation: () {
              if(!(_file_desc.exists() as bool))
              {
                _file_desc=_getFileFromCamera(context) as io.File;

              }
              else
              {
                return null;
              }
            }),
        CoolStep(
            title: LocaleService.of("recipe_cam_step3_title")!,
            subtitle: LocaleService.of("recipe_cam_step3_subtitle")!,
            content: Container(
              child: Center(
                  child:LimitedBox(
                    child:Image.file(_file_img),
                    maxHeight: 300,
                  )
              ),
            ),
            validation: () {
              if(!(_file_img.exists() as bool))
              {
                _file_img=_getFileFromCamera(context) as io.File;

              }
              else
              {
                return null;
              }
            }),
      ]),
    );
  }

  _onStepperCompleted() {}

  Future<io.File?> _getFileFromCamera(BuildContext context) async {
    try {
      final XFile? file=await ImagePicker().pickImage(source: ImageSource.camera);
      return file as io.File;
    } catch (e) {print(e);return null;}
  }
}
