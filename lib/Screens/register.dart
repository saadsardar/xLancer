
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Screens/registerGoogle.dart';
import 'package:xlancer/Screens/registerdetail.dart';
import 'package:xlancer/Models/user.dart' as UserClass;

import 'main_screen.dart';
import 'splashScreen.dart';

// final GoogleSignIn googleSignIn = GoogleSignIn();

class RegisterPageUser extends StatefulWidget {
  static const routeName = '/register-page-user';

  @override
  _RegisterPageUserState createState() => _RegisterPageUserState();
}

class _RegisterPageUserState extends State<RegisterPageUser> {
  FocusNode emailFocusNode, passwordFocusNode, phoneFocusNode;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  bool _showpass = false;
  // ignore: unused_field
  String _email, _pass, _phone;
  bool _isLoading = false;
  bool isLogin = false;
  bool isAuth = false;

  @override
  initState() {
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    super.initState();
  }
  loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    print('Going In Provider');
    final msg = await Provider.of<UserClass.User>(context, listen: false)
        .signInWithGoogle();
    if (msg == '') {
      Navigator.of(context)
          .pushReplacementNamed(RegisterUserGoogleScreen.routeName);
    } else if (msg == 'Already logged in') {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainScreen.routeName, (route) => false);
    } else {
      _failSnackbar(msg);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  _displayImage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      child: Image.asset(
        'assets/1.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _showtitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        isLogin ? 'Login' : 'Register',
        // style: Theme.of(context).textTheme.headline1,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          //Theme.of(context).primaryColor,
          fontSize: 29,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _emailfield() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        onFieldSubmitted: (_) =>
            // isLogin ?
            passwordFocusNode.requestFocus(),
        // : phoneFocusNode.requestFocus(),
        onSaved: (val) => _email = val.trim(),
        validator: (val) => !val.contains('@') ? 'Invalid Email Address' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter Email Address',
            icon: Icon(Icons.mail)),
      ),
    );
  }

  Widget _phonefield() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        focusNode: phoneFocusNode,
        onFieldSubmitted: (_) => _submit(),
        onSaved: (val) => _phone = val.trim(),
        validator: (val) => val.length < 7 ? 'Enter Valid Phone Number' : null,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone Number',
            hintText: 'Enter Phone Number',
            icon: Icon(Icons.phone)),
      ),
    );
  }

  Widget _passwordfield() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        textInputAction: isLogin ? TextInputAction.done : TextInputAction.next,
        focusNode: passwordFocusNode,
        onSaved: (val) => _pass = val.trim(),
        validator: (val) => val.length < 6 ? 'Password Too Short' : null,
        obscureText: _showpass ? false : true,
        onFieldSubmitted: (a) =>
            isLogin ? _submit() : phoneFocusNode.requestFocus(),
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _showpass = !_showpass;
                  });
                },
                child:
                    Icon(_showpass ? Icons.visibility_off : Icons.visibility)),
            border: OutlineInputBorder(),
            labelText: 'Password',
            hintText: 'Enter password. Min Length 6',
            icon: Icon(Icons.lock)),
      ),
    );
  }

  Widget _formActionButton() {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: _isLoading
          ? CircularProgressIndicator()
          : Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 45,
                  child: RaisedButton(
                    onPressed: _submit,
                    child: Text(
                      'Submit',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white),
                    ),
                    elevation: 2.0,
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  child: Text(
                      isLogin ? 'New User? Register' : 'Existing User? Login'),
                  onPressed: () {
                    emailFocusNode.unfocus();
                    phoneFocusNode.unfocus();
                    passwordFocusNode.unfocus();
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                ),
              ],
            ),
    );
  }

  void _submit() async {
    emailFocusNode.unfocus();
    phoneFocusNode.unfocus();
    passwordFocusNode.unfocus();

    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();

      // print('$_email $_pass $_phone');
      var msg = await _registerUser();
      // .then((value) {
      if (msg == '') {
        if (!isLogin) {
          Navigator.of(context)
              .pushReplacementNamed(RegisterUserDetailScreen.routeName);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              NavigationScreen.routeName, (route) => false);
          
          // Navigator.popUntil(
          //     context, ModalRoute.withName(Navigator.defaultRouteName));
        }
        // });
      } else {
        print('Invalid Entry');
        _failSnackbar(msg);
      }
    }
  }

  // void _successSnackbar() {
  //   final snackBar = SnackBar(
  //       behavior: SnackBarBehavior.floating,
  //       content: Text(
  //         'Sign Up Sucessful!',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(),
  //       ));
  //   _scaffoldKey.currentState.showSnackBar(snackBar);
  // }

  void _failSnackbar(String e) {
    final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          e,
          textAlign: TextAlign.center,
          style: TextStyle(),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  // _redirectUser() {
  //   // Future.delayed(Duration(seconds: 5));
  //   print('Successfull');
  //   Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
  // }

  Future<String> _registerUser() async {
    var msg = '';
    setState(() {
      _isLoading = true;
    });
    if (isLogin) {
      msg = await Provider.of<UserClass.User>(context, listen: false)
          .signIn(_email, _pass);
    } else {
      msg = await Provider.of<UserClass.User>(context, listen: false)
          .registerUser(_email, _pass, _phone);
      // .then((value) => Navigator.of(context)
      //     .pushNamed(RegisterUserDetailScreen.routeName));
    }
    print('After SignIn SignUp Msg : $msg');
    // _successSnackbar();
    // if (FirebaseAuth.instance.currentUser == null) {
    //   _redirectUser();
    // } else {
    // print(responseData['message']);
    // _failSnackbar('Error Signing In');
    // }
    // } catch (e) {
    //   print(e);
    //   _failSnackbar(e);
    // }
    // }
    setState(() {
      _isLoading = false;
    });
    return msg;
    // Navigator.popUntil(
    //     context, ModalRoute.withName(Navigator.defaultRouteName));
  }

  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: Text("User"),
      // ),
      body: Center(
        child: ListView(
          children: [
            _displayImage(),
            _showtitle(),
            AnimatedContainer(
              duration: Duration(seconds: 2),
              height: isLogin ? 300 : 450,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _emailfield(),
                        _passwordfield(),
                        if (!isLogin) _phonefield(),
                        _formActionButton(),
                        if (!_isLoading)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: loginWithGoogle,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  width: 160.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/googlelogo.png",
                                          width: 25.0,
                                        ),
                                        Padding(
                                          child: Text(
                                            "Google",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          padding:
                                              new EdgeInsets.only(left: 5.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.blue),
                              //     borderRadius: BorderRadius.all(
                              //         Radius.circular(
                              //             20.0) //                 <--- border radius here
                              //         ),
                              //   ),
                              //   width: 160.0,
                              //   child: Center(
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       children: <Widget>[
                              //         Image.asset(
                              //           "assets/facebooklogo.png",
                              //           width: 25.0,
                              //         ),
                              //         Padding(
                              //           child: Text(
                              //             "Facebook",
                              //             style: TextStyle(
                              //               fontSize: 20,
                              //             ),
                              //           ),
                              //           padding:
                              //               new EdgeInsets.only(left: 15.0),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
