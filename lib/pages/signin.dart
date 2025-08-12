import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'animation_enum.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Artboard? riveArtboard;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerFail;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerLookIdle;
  late RiveAnimationController controllerLookLeft;
  late RiveAnimationController controllerLookRight;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String testEmail = "Fa5R2004@gmail.com";
  String testPassword = "11223344";
  final passwordFocusNode = FocusNode();
  String? savedEmail;
  String? savedPassword;

  bool isLookingLeft = false;
  bool isLookingRight = false;
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();


  void removeAllControllers() {
    riveArtboard?.artboard.removeController(controllerLookIdle);
    riveArtboard?.artboard.removeController(controllerHandsUp);
    riveArtboard?.artboard.removeController(controllerHandsDown);
    riveArtboard?.artboard.removeController(controllerLookLeft);
    riveArtboard?.artboard.removeController(controllerLookRight);
    riveArtboard?.artboard.removeController(controllerSuccess);
    riveArtboard?.artboard.removeController(controllerFail);
    isLookingLeft = false;
    isLookingRight = false;
  }

  void addSpecifcAnimationAction(
      RiveAnimationController<dynamic> neededAnimationAction) {
    removeAllControllers();
    riveArtboard?.artboard.addController(neededAnimationAction);
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void checkForPasswordFocusNodeToChangeAnimationState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        addSpecifcAnimationAction(controllerHandsUp);
      } else {
        addSpecifcAnimationAction(controllerHandsDown);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllerLookIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.hands_up.name);
    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);
    controllerLookRight = SimpleAnimation(AnimationEnum.Look_down_right.name);
    controllerLookLeft = SimpleAnimation(AnimationEnum.Look_down_left.name);
    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);
    controllerFail = SimpleAnimation(AnimationEnum.fail.name);

    loadRiveFileWithItsStates();
    checkForPasswordFocusNodeToChangeAnimationState();
    loadSavedUserData();
  }

  Future<void> loadSavedUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedEmail = prefs.getString('email');
    savedPassword = prefs.getString('password');
  }

  void loadRiveFileWithItsStates() {
    rootBundle.load('assets/teste_para_login.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controllerLookIdle);
      setState(() {
        riveArtboard = artboard;
      });
    });
  }

  void validateEmailAndPassword() {
    Future.delayed(const Duration(seconds: 1), () {
      if (formKey.currentState!.validate()) {
        addSpecifcAnimationAction(controllerSuccess);
      } else {
        addSpecifcAnimationAction(controllerFail);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Sign in'.tr(),
          style: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .width * 0.09,
            color: const Color(0xFF0A2152),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isKeyboardVisible =
                  MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom > 0;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery
                      .of(context)
                      .size
                      .width / 20,
                  vertical: MediaQuery
                      .of(context)
                      .size
                      .height / 40,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        if (!isKeyboardVisible)
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 3,
                            child: riveArtboard == null
                                ? const SizedBox.shrink()
                                : Rive(
                              artboard: riveArtboard!,
                            ),
                          ),
                        //const SizedBox(height: 20),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Email".tr(),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF0A2152))
                                  ),

                                ),
                                validator: (value) =>
                                value != testEmail ? "Wrong email".tr() : null,
                                onChanged: (value) {
                                  if (value.isNotEmpty &&
                                      value.length < 16 &&
                                      !isLookingLeft) {
                                    addSpecifcAnimationAction(
                                        controllerLookLeft);
                                    isLookingLeft = true;
                                    isLookingRight = false;
                                  } else if (value.isNotEmpty &&
                                      value.length > 16 &&
                                      !isLookingRight) {
                                    addSpecifcAnimationAction(
                                        controllerLookRight);
                                    isLookingRight = true;
                                    isLookingLeft = false;
                                  }
                                },
                              ),
                              SizedBox(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height / 25,
                              ),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password".tr(),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF0A2152))
                                  ),
                                ),
                                focusNode: passwordFocusNode,
                                validator: (value) =>
                                value != testPassword
                                    ? "Wrong password".tr()
                                    : null,
                              ),
                              SizedBox(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height / 20,
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 8,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      addSpecifcAnimationAction(
                                          controllerSuccess);
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pushNamed(
                                            context, "/Sign in");
                                      });
                                    } else {
                                      addSpecifcAnimationAction(controllerFail);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign in'.tr(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),

                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}