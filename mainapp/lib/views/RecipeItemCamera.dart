import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:mainapp/services/LocalizationService.dart';


//TO-DO need to download from https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_ml_vision/lib/src/barcode_detector.dart

class RecipeItemCamera extends StatefulWidget {
  RecipeItemCamera({Key? key}) : super(key: key);
  static const routeName = '/RecipeItemCamera';

  @override
  _RecipeItemCameraState createState() => _RecipeItemCameraState();
}

class _RecipeItemCameraState extends State<RecipeItemCamera> {
  final _formKey = GlobalKey<_RecipeItemCameraState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CoolStepper(
        onCompleted: _onStepperCompleted(),
        steps: <CoolStep>[
          CoolStep(
            title:LocalizationService().of("recipe_cam_step1_title")!,
            subtitle: LocalizationService().of("recipe_cam_step1_subtitle")!,
            content: Container(),
              validation: () {  }
          ),
          CoolStep(
              title:LocalizationService().of("recipe_cam_step2_title")!,
              subtitle: LocalizationService().of("recipe_cam_step2_subtitle")!,
              content: Container(),
              validation: () {  }
          ),
          CoolStep(
              title:LocalizationService().of("recipe_cam_step3_title")!,
              subtitle: LocalizationService().of("recipe_cam_step3_subtitle")!,
              content: Container(),
              validation: () {  }
          ),
        ]
      ),
    );
  }
  _onStepperCompleted()
  {

  }
}


