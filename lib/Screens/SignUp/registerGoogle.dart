import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/user.dart';

import '../main_screen.dart';

class RegisterUserGoogleScreen extends StatefulWidget {
  static const routeName = '/register-usergoogle-screen';
  @override
  _RegisterUserGoogleScreenState createState() =>
      _RegisterUserGoogleScreenState();
}

class _RegisterUserGoogleScreenState extends State<RegisterUserGoogleScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();

  FocusNode phoneFocusNode, cnicFocusNode;

  String _phone, _bio;
  DateTime _dob = DateTime.now();
  bool _isLoading = false;

  @override
  initState() {
    phoneFocusNode = FocusNode();
    cnicFocusNode = FocusNode();
    super.initState();
  }

  @override
  dispose() {
    phoneFocusNode.dispose();
    cnicFocusNode.dispose();
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

  Widget _showtitle(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Text(
        name,
        // textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
      ),
    );
  }

  // File _pickedimage;

  // final ImagePicker _picker = ImagePicker();

  // Future _getImage() async {
  //   var pickedimagefile = await _picker.getImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 50,
  //     maxWidth: 250,
  //   );
  //   // print(pickedimagefile);
  //   setState(() {
  //     _pickedimage = File(pickedimagefile.path);
  //   });
  // }

  // Widget _pickimage() {
  //   return Column(
  //     children: <Widget>[
  //       CircleAvatar(
  //         radius: 60,
  //         backgroundColor: Colors.grey,

  //       ),
  //       FlatButton.icon(
  //         textColor: Theme.of(context).primaryColor,
  //         onPressed: _getImage,
  //         icon: Icon(Icons.image),
  //         label: Text('Add Image'),
  //       ),
  //     ],
  //   );
  // }

  Widget _imageField(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        backgroundImage:
            url != '' ? NetworkImage(url) : Image.asset('/assets/userIcon.png'),
        radius: 60,
        // child: InkWell(
        //   child: Icon(
        //     Icons.person_add_alt,
        //     color: Theme.of(context).primaryColor,
        //     size: 30,
        //   ),
        //   // onTap: () async {
        //   //   await _getImage();
        //   //   print('pressed');
        //   // },
        // ),
      ),
    );
  }

  Widget _phoneTextfield() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: phoneFocusNode,
        keyboardType: TextInputType.number,
        onFieldSubmitted: (_) => cnicFocusNode.requestFocus(),
        onSaved: (val) => _phone = val.trim(),
        validator: (val) =>
            val.length < 7 ? 'Field Can not be left Empty' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone Number',
            hintText: 'Enter Phone Number',
            icon: Icon(Icons.phone)),
      ),
    );
  }

  Widget _cnicfield() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: cnicFocusNode,
        onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
        onSaved: (val) => _bio = val.trim(),
        validator: (val) =>
            val.length == 0 ? 'Enter something about yourself' : null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Short Introduction',
            hintText: 'Enter Bio',
            icon: Icon(Icons.school)),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (picked != null && picked != _dob)
      setState(() {
        _dob = picked;
      });
  }

  Widget _dobWidget(context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: ListTile(
        leading: Icon(
          Icons.calendar_today_outlined,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Date Of Birth'),
        subtitle: Text(
          '${DateFormat.yMMMd().format(_dob)}',
          style: TextStyle(fontSize: 15),
        ),
        trailing: RaisedButton(
          onPressed: () => _selectDate(context),
          child: Text('Select Date'),
        ),
      ),
    );
  }

  Widget _formActionButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: _isLoading
          ? CircularProgressIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
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
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
    });
    phoneFocusNode.unfocus();
    cnicFocusNode.unfocus();
    // String dpurl = '';

    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      print('$_phone $_bio');
      // final userid = Provider.of<User>(context, listen: false).userId;
      // if (_pickedimage != null) {
      //   // String fileName = Provider.of<User>(context, listen: false).userId.toString();
      //   final ref = FirebaseStorage.instance.ref().child('ProfilePic/$userid');
      //   // child('user_dp');
      //   await ref.putFile(_pickedimage).onComplete;
      //   dpurl = await ref.getDownloadURL();
      // }
      Map<String, dynamic> userInfo = {
        'phone': _phone,
        'bio': _bio,
        'dob': _dob,
        //'picture': dpurl,
      };
      var msg = await Provider.of<User>(context, listen: false)
          .addUserGoogleDetails(userInfo);
      if (msg == '') {
        Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
        // Navigator.popUntil(
        //     context, ModalRoute.withName(Navigator.defaultRouteName));
      } else {
        _failSnackbar(msg);
      }
    } else {
      print('Invalid Entry');
      _failSnackbar('Invalid Entry');
    }
    setState(() {
      _isLoading = false;
    });
    // Navigator.popUntil(
    //     context, ModalRoute.withName(Navigator.defaultRouteName));
  }

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //     // title: Text("Login"),
      //     ),
      body: Center(
        child: ListView(
          children: [
            _displayImage(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _showtitle(user.name),
                        _imageField(user.picture),
                        _phoneTextfield(),
                        _cnicfield(),
                        _dobWidget(context),
                        // _passwordfield(),
                        _formActionButton(),
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
