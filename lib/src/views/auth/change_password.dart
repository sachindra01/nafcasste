import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:nafcassete/src/helpers/styles.dart";
import "package:nafcassete/src/helpers/validators.dart";
import "package:nafcassete/src/widgets/custom_button.dart";
import "package:nafcassete/src/widgets/custom_textformfield.dart";

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  //TextControllers
  final oldPasswordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  //Obscure password
  bool oldObscurePassword = true;
  bool reObscurePassword = true;
  bool newObscurePassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    oldPasswordController.dispose();
    rePasswordController.dispose();
    newPasswordController.dispose();
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
              SizedBox(height: 100.0.h),
              // Logo
              logo(),
              // Text
              text(),
              SizedBox(height: 30.0.h),
              // Form
              form(),
              SizedBox(height: 30.0.h),
              // Login Button
              changePassowrdButton(),
              SizedBox(height: 50.0.h),
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
  Text text() {
    return Text(
      "Change Password",
      style: w6f15(black)
    );
  }

  //LoginForm
  form() {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              //Old Password
              CustomTextFormField(
                controller: oldPasswordController, 
                obscureText: oldObscurePassword,
                keyboardType: TextInputType.visiblePassword,
                maxLines: 1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => validatePassword(string: password!),
                hintText: "Password",
                hintStyle: const TextStyle(
                  color: textGrey
                ),
                suffixIcon: GestureDetector(
                  onTap: (){
                    setState(() {
                      oldObscurePassword = !oldObscurePassword;
                    });
                  },
                  child: Icon(
                    oldObscurePassword ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: true,
              ),
              SizedBox(height: 10.h),
              //New Passowrd
              CustomTextFormField(
                controller: newPasswordController, 
                obscureText: newObscurePassword,
                keyboardType: TextInputType.visiblePassword,
                maxLines: 1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (newPw) => validatePassword(string: newPw!),
                hintText: "New Password",
                hintStyle: const TextStyle(
                  color: textGrey
                ),
                suffixIcon: GestureDetector(
                  onTap: (){
                    setState(() {
                      newObscurePassword = !newObscurePassword;
                    });
                  },
                  child: Icon(
                    oldObscurePassword ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: true,
              ),
              SizedBox(height: 10.h),
              //Re Passowrd
              CustomTextFormField(
                controller: rePasswordController, 
                obscureText: reObscurePassword,
                keyboardType: TextInputType.visiblePassword,
                maxLines: 1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (rePw) => validatePassword(string: rePw!),
                hintText: "Re-Password",
                hintStyle: const TextStyle(
                  color: textGrey
                ),
                suffixIcon: GestureDetector(
                  onTap: (){
                    setState(() {
                      reObscurePassword = !reObscurePassword;
                    });
                  },
                  child: Icon(
                    oldObscurePassword ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: true,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ],
    );
  }


  //Chnage Password Button
  changePassowrdButton() {
    return CustomButton(
      height: 45.h,
      width: double.infinity,
      text: "Change Passowrd",
      prefixIcon: const SizedBox(),
      suffixIcon: const SizedBox(),
      ontap: () {
        final isValid = formKey.currentState!.validate();
        if (!isValid) return;
      }
    );
  }

  
}