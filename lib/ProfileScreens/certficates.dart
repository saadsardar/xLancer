import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/freelancer.dart';
import 'package:xlancer/Models/user.dart';
import 'package:uuid/uuid.dart';


class AddCertificate extends StatefulWidget {
  static const routeName = '/edit-cerificate';
  @override
  _AddCertificateState createState() => _AddCertificateState();
}

class _AddCertificateState extends State<AddCertificate> {
  String postId = Uuid().v4();
        String dpurl = '';

  File _pickedimage;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    //final userDetails = Provider.of<Freelancer>(context, listen: false);
    Future _getImage() async {
      var pickedimagefile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 250,
      );
      // print(pickedimagefile);
      setState(() {
        _pickedimage = File(pickedimagefile.path);
      });
    }


    void _submit() async {
      setState(() {
        _isLoading = true;
      });
      final userid = Provider.of<User>(context, listen: false).userId;
      if (_pickedimage != null) {
        final ref = FirebaseStorage.instance.ref().child('Certificates/$userid/$postId');
        await ref.putFile(_pickedimage).onComplete;
        dpurl = await ref.getDownloadURL();
      }
      Map<String, dynamic> userInfo = {
        'link': dpurl,
      };
      await Provider.of<Freelancer>(context, listen: false).addcertificate(userInfo);
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
      // Navigator.popUntil(
      //     context, ModalRoute.withName(Navigator.defaultRouteName));
    }
    
    Widget _imageField() {
      return Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            backgroundImage: 
           _pickedimage != null
               ? 
                FileImage(_pickedimage,)
                : 
                AssetImage('assets/logo.png',),
                // : userDetails.certifications[0] == ''
                //     ? Icon(Icons.person)
                //     ?AssetImage('assets/logo.jpg',)
                //     : 
                    //:NetworkImage(dpurl),
            radius: 60,
          ),
          Positioned(
            right: 0.0,
            bottom: 0.0,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 35.0,
                width: 35.0,
                child: Icon(
                  Icons.person_add_alt,
                  color: Theme.of(context).primaryColor,
                  size: 25,
                ),
              ),
              onTap: () async {
                await _getImage();
                print('pressed');
              },
            ),
          ),
        ],
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

    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Certificate'),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _imageField(),
                      _formActionButton(),
                    ],
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
