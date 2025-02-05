import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/user.dart';

class EditName extends StatefulWidget {
  static const routeName = '/edit-name-screen';
  @override
  EditNameState createState() => EditNameState();
}

class EditNameState extends State<EditName> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();

  FocusNode titleFocusNode;

  String _summary;
  bool _isLoading = false;

  @override
  initState() {
    titleFocusNode = FocusNode();
    super.initState();
  }

  @override
  dispose() {
    titleFocusNode.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final userDetails = Provider.of<User>(context);

    Widget _nameTextfield() {
      return Padding(
        padding: EdgeInsets.only(top: 20),
        child: TextFormField(
          initialValue: userDetails.name,
          textInputAction: TextInputAction.next,
          focusNode: titleFocusNode,
          keyboardType: TextInputType.text,
          onFieldSubmitted: (_) => titleFocusNode.requestFocus(),
          onSaved: (val) => _summary = val.trim(),
          validator: (val) =>
              val.length == 0 ? 'Field Can not be left Empty' : null,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
              hintText: 'Enter your name',
              icon: Icon(Icons.person)),
        
        ),
        
      );
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

    void _submit() async {
      setState(() {
        _isLoading = true;
      });
      titleFocusNode.unfocus();

      final form = _formkey.currentState;
      if (form.validate()) {
        form.save();
        print('$_summary ');
        Map<String, dynamic> userInfo = {
          'name': _summary,
        };
        await Provider.of<User>(context, listen: false)
            .editname(userInfo);
      } else {
        print('Invalid Entry');
        _failSnackbar('Invalid Entry');
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit title'),
      ),
      body: Center(
        child: ListView(
          children: [
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
                        _nameTextfield(),
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
