import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  List<Image> images = [];
  //late io.File _file;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CoolStepper(
          onCompleted: (() => _onStepperCompleted()),
          steps: <CoolStep>[
            CoolStep(
                title: LocaleService.of("recipe_cam_step1_title")!,
                subtitle: LocaleService.of("recipe_cam_step1_subtitle")!,
                content: Container(
                  child: Center(
                      child: LimitedBox(
                          child: FutureBuilder(
                    future: _getFileFromCamera(context),
                    builder: (BuildContext context,
                        AsyncSnapshot<io.File?> snapshot) {
                      if (!snapshot.hasData) {}
                      var localImage = new Image.file(snapshot.data!);
                      images.add(localImage);
                      return localImage;
                    },
                  ))),
                ),
                validation: () {
                  return;
                }),
            CoolStep(
                title: LocaleService.of("recipe_cam_step2_title")!,
                subtitle: LocaleService.of("recipe_cam_step2_subtitle")!,
                content: Container(
                  child: Center(
                      child: LimitedBox(
                          child: FutureBuilder(
                    future: _getFileFromCamera(context),
                    builder: (BuildContext context,
                        AsyncSnapshot<io.File?> snapshot) {
                      if (!snapshot.hasData) {}
                      var localImage = new Image.file(snapshot.data!);
                      images.add(localImage);
                      return localImage;
                    },
                  ))),
                ),
                validation: () {
                  return;
                }),
            CoolStep(
                title: LocaleService.of("recipe_cam_step3_title")!,
                subtitle: LocaleService.of("recipe_cam_step3_subtitle")!,
                content: Container(
                  child: Center(
                      child: LimitedBox(
                          child: FutureBuilder(
                    future: _getFileFromCamera(context),
                    builder: (BuildContext context,
                        AsyncSnapshot<io.File?> snapshot) {
                      if (!snapshot.hasData) {}
                      var localImage = new Image.file(snapshot.data!);
                      images.add(localImage);
                      return localImage;
                    },
                  ))),
                ),
                validation: () {
                    return;
                }),
          ]),
    );
  }

  _onStepperCompleted() {}

  Future<io.File?> _getFileFromCamera(BuildContext context) async {
    try {
      final XFile? file =
          await ImagePicker().pickImage(source: ImageSource.camera);
      return file as io.File;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
