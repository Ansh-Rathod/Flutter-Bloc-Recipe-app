import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racipi/screens/nav/bottom_nav.dart';
import 'package:racipi/theme/colors.dart';

import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";
  static Route route() {
    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, _, __) => BlocProvider(
              create: (context) => LoginCubit(),
              child: LoginScreen(),
            ),
        settings: RouteSettings(name: routeName));
  }

  final _formkey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://source.unsplash.com/1600x900/?food,cake"))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: athens_gray,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formkey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 8),
                                  child: Text(
                                    "Spoonacular",
                                    style: GoogleFonts.lobster(
                                        textStyle: TextStyle(
                                            color: Colors.green, fontSize: 26)),
                                  ),
                                ),
                              ),
                              state.status == LoginStatus.error
                                  ? Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Container(
                                        // color: Colors.red,
                                        decoration: ShapeDecoration(
                                            color: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16)),
                                            )),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            state.error.message,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: TextFormField(
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isEmpty || !value.contains('@')) {
                                      return "Email is not valid.";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.7),
                                      ),
                                      contentPadding: EdgeInsets.all(16),
                                      focusColor: athen_gray,
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Icon(Icons.account_box_outlined),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty || value.length <= 6) {
                                      return "Please Enter valid password.";
                                    }
                                    return null;
                                  },
                                  controller: pass,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.7),
                                      ),
                                      contentPadding: EdgeInsets.all(16),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Icon(Icons.password_outlined),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: ButtonTheme(
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: RaisedButton(
                                    padding:
                                        MediaQuery.of(context).size.width > 600
                                            ? EdgeInsets.all(25)
                                            : EdgeInsets.all(16),
                                    color: Colors.black,
                                    onPressed: state.status ==
                                            LoginStatus.loading
                                        ? null
                                        : () async {
                                            final isvalid = _formkey
                                                .currentState
                                                .validate();
                                            FocusScope.of(context).unfocus();
                                            if (isvalid) {
                                              _formkey.currentState.save();
                                              final isNotError =
                                                  await BlocProvider.of<
                                                          LoginCubit>(context)
                                                      .login(email.text.trim(),
                                                          pass.text.trim());
                                              if (isNotError) {
                                                Navigator.of(context).pushNamed(
                                                    NavScreen.routeName);
                                              }
                                            }
                                          },
                                    textColor: Colors.white,
                                    child: Text(
                                      "Login >",
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(16.0)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(fontSize: 14)),
                                        children: [
                                          TextSpan(
                                            text: "You are new? ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          TextSpan(
                                            text: "create a new",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
