
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';







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
  Map<stepID, String> images = new Map();
  //late bool _complete=false;
  int _currentStep = 0;


  @override
  void dispose() {
    super.dispose();
  } //late io.File _file;



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
                  title: Text(LocaleService.of("recipe_cam_step1_title")!),
                  content: Column(
                    children: [
                      Text(LocaleService.of("recipe_cam_step1_subtitle")!),

                    ],
                  )),
              Step(
                  title: Text(LocaleService.of("recipe_cam_step2_title")!),
                  content: Column(
                    children: [
                      Text(LocaleService.of("recipe_cam_step2_subtitle")!),

                    ],
                  )),
              Step(
                  title:Text( LocaleService.of("recipe_cam_step3_title")!),
                  content: Column(
                    children: [
                      Text(LocaleService.of("recipe_cam_step3_subtitle")!),

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
      final XFile? file =
          await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 35);
      String recognized=await IOService.parse(fromFile:true,file: file,free: true);
      print(recognized);
      images.putIfAbsent(step,()=> recognized);
    } catch (e) {
      print("Error:"+e.toString());
      return null;
    }
  }
  _finishRecipe()
  {

  }
}
