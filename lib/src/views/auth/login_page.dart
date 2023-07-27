import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:nafcassete/src/controller/auth_controller.dart";
import "package:nafcassete/src/helpers/styles.dart";
import "package:nafcassete/src/helpers/validators.dart";
import "package:nafcassete/src/widgets/custom_button.dart";
import "package:nafcassete/src/widgets/custom_textformfield.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthController authCon = Get.put(AuthController());

  //TextControllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final organizationController = TextEditingController();

  //Obscure password
  bool obscurePassword = true;
  bool rememberMe = false;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    organizationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: white,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    logo(),
                    // Welcome Text
                    welcomeText(),
                    SizedBox(height: 25.0.h),
                    // Login Form
                    loginForm(),
                    SizedBox(height: 25.0.h),
                    // Login Button
                    loginButton(),
                    SizedBox(height: 50.0.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Logo
  logo() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: Image.asset(
        'assets/images/logo.png',
        height: 166.0.h,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  //Welcome Text


  welcomeText() {
    return Image.asset(
      'assets/images/png/logo_showroom.png',
      height: 50.5.h,
      fit: BoxFit.fitWidth,
    );
  }

  //LoginForm
  loginForm() {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              //Email
              CustomTextFormField(
                controller: emailController, 
                hintText: "emailHint".tr,
                hintStyle: const TextStyle(
                  color: lightGreyCol
                ),
                validator: (email) => validateIsEmpty(string: email!),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                filled: true,
                enableSuggestions: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: lightGreyCol, 
                    width: 0.5
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              //Password
              SizedBox(
                child: CustomTextFormField(
                  controller: passwordController, 
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  maxLines: 1,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) => validatePassword(string: password!),
                  hintText: "passwordHint".tr,
                  hintStyle: const TextStyle(
                    color: lightGreyCol
                  ),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    child: Icon(
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                      size: 20.0.sp,
                      color: lightGreyCol,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: lightGreyCol, 
                      width: 0.5
                    ),
                  ),
                  filled: true,
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ],
    );
  }

  //Login Button
  loginButton() {
    return CustomButton(
      height: 48.h,
      width: double.infinity,
      text: "loginText".tr,
      prefixIcon: const SizedBox(),
      suffixIcon: const SizedBox(),
      buttonRadius: 30.0.r,
      ontap: () async{
        final isValid = formKey.currentState!.validate();
        if (!isValid) return;
        await authCon.login1(emailController.text.trim(),passwordController.text.trim());
      }
    );
  }

  
}