import 'package:blagajna/data/login_repo.dart';
import 'package:blagajna/styles/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController(text: "janez");
  final _passwordController = TextEditingController(text: "mavrica");
  var error = false;
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backeground,
      body: SafeArea(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Center(
            child: Text(
              "BLAGAJNA",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    label:
                        Text("Username", style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    label:
                        Text("Password", style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => loading = true);
                    var loginRepo = LoginRepo();
                    loginRepo
                        .loginUser(
                            _usernameController.text, _passwordController.text)
                        .then((value) => value
                            ? Navigator.pushNamed(context, "/events")
                            : setState(() {
                                error = true;
                                loading = false;
                              }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColors.orange),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: !loading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                              ],
                            )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white,),
                            ],
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                if (error)
                  Text(
                    "User credentials are invalid",
                    style: TextStyle(color: Colors.white),
                  )
              ],
            ),
          ),
          Container(),
        ]),
      ),
    );
  }
}
