import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:nafcassete/src/helpers/styles.dart";
import "package:nafcassete/src/helpers/validators.dart";
import "package:nafcassete/src/widgets/custom_button.dart";
import "package:nafcassete/src/widgets/custom_textformfield.dart";

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  //TextControllers
  final emailController = TextEditingController();

  
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60.0.h,),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: (){
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back)
                ),
              ),
              SizedBox(height: 160.0.h),
              // Logo
              logo(),
              // Reset Text
              resetPasswordText(),
              SizedBox(height: 30.0.h),
              // email Form
              emailForm(),
              SizedBox(height: 50.0.h),
              // Reset Button
              resetButton(),
            ],
          ),
        ),
      ),
    );
  }

  //Logo
  logo() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0.h),
      child: SizedBox(
        child: Image.asset(
          'assets/images/logo.png',
          height: 60.0.h, width: 60.0.h,
          fit: BoxFit.fitWidth,
        ),
      )
    );
  }

  //Welcome Text
  Text resetPasswordText() {
    return Text(
      "Enter your email to reset ypur password",
      style: w6f15(black)
    );
  }

  //LoginForm
  emailForm() {
    return Form(
      key: formKey,
      child:  CustomTextFormField(
        controller: emailController, 
        hintText: "E-mail",
        hintStyle: const TextStyle(
          color: textGrey
        ),
        validator: (email) => validateEmail(string: email!),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        filled: true,
        enableSuggestions: true,
      ),
    );
  }


  //Login Button
  resetButton() {
    return CustomButton(
      height: 45.h,
      width: double.infinity,
      text: "Reset Password",
      prefixIcon: const SizedBox(),
      suffixIcon: const SizedBox(),
      ontap: () {
        Get.back();
        final isValid = formKey.currentState!.validate();
        if (!isValid) return;
      }
    );
  }

  
}