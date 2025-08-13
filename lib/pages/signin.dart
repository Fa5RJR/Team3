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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0A2152)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Sign in'.tr(),
          style: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .width * 0.07,
            color: const Color(0xFF0A2152),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isKeyboardVisible =
                MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom > 0;

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Animation Section
                      if (!isKeyboardVisible)
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          margin: const EdgeInsets.only(bottom: 32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: riveArtboard == null
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.teal,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Rive(artboard: riveArtboard!),
                                ),
                        ),
                      
                      // Form Section
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0A2152),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Sign in to continue to Sanad',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 32),
                              
                              // Email Field
                              Text(
                                "Email".tr(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0A2152),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Enter your email",
                                    hintStyle: TextStyle(color: Colors.grey.shade500),
                                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey.shade500),
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(color: Colors.teal, width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(color: Colors.red, width: 2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
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
                              ),
                              
                              const SizedBox(height: 24),
                              
                              // Password Field
                              Text(
                                "Password".tr(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0A2152),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  focusNode: passwordFocusNode,
                                  decoration: InputDecoration(
                                    hintText: "Enter your password",
                                    hintStyle: TextStyle(color: Colors.grey.shade500),
                                    prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade500),
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(color: Colors.teal, width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(color: Colors.red, width: 2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                  validator: (value) =>
                                  value != testPassword
                                      ? "Wrong password".tr()
                                      : null,
                                ),
                              ),
                              
                              const SizedBox(height: 32),
                              
                              // Sign In Button
                              Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.teal.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      addSpecifcAnimationAction(
                                          controllerSuccess);
                                      Future.delayed(const Duration(seconds: 2), () {
                                        Navigator.pushNamed(
                                            context, "/Sign in");
                                      });
                                    } else {
                                      addSpecifcAnimationAction(controllerFail);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign in'.tr(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}