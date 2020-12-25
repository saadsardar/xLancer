import 'package:flutter/material.dart';

import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/freelancer.dart';

class EditSkills extends StatefulWidget {
  static const routeName = '/edit-skills-screen';

  @override
  _EditSkillsState createState() => _EditSkillsState();
}

class _EditSkillsState extends State<EditSkills> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //List<String> tags = [];
  String tag = '';
  bool _isLoading = false;
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    //List tags = Provider.of<Freelancer>(context, listen: false).skills;
    // void _failSnackbar(String e) {
    //   final snackBar = SnackBar(
    //       behavior: SnackBarBehavior.floating,
    //       content: Text(
    //         e,
    //         textAlign: TextAlign.center,
    //         style: TextStyle(),
    //       ));
    //   _scaffoldKey.currentState.showSnackBar(snackBar);
    // }

    void _submit() async {
      setState(() {
        _isLoading = true;
      });
      tag=(myController.text).toString();
      // if (tags.isEmpty) {
      //print('$tags ');
      Map<String, dynamic> userInfo = {
        'tag': tag,
      };
      await Provider.of<Freelancer>(context, listen: false).addSkills(userInfo);
      //    }
      // else {
      //   print('Invalid Entry');
      //   _failSnackbar('Invalid Entry');
      // }
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    }
    clearTextInput(){
      myController.clear();
    }
    Widget _nameTextfield() {
      return Padding(
        padding: EdgeInsets.only(top: 20),
        child: ListTile(
            title: TextField(
            controller: myController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Add your skill',
              hintText: 'What do you do?',
              icon: Icon(Icons.work),
            ),
          ),
          trailing: IconButton(icon: Icon(Icons.cancel),onPressed: clearTextInput,),
        ),
      );
    }

    // Widget _formActionButton() {
    //   return Padding(
    //     padding: EdgeInsets.only(top: 20),
    //     child: _isLoading
    //         ? CircularProgressIndicator()
    //         : Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               SizedBox(
    //                 width: MediaQuery.of(context).size.width * 0.4,
    //                 height: 50,
    //                 child: RaisedButton(
    //                   onPressed: _submit,
    //                   child: Text(
    //                     'Submit',
    //                     style: Theme.of(context)
    //                         .textTheme
    //                         .bodyText1
    //                         .copyWith(color: Colors.white),
    //                   ),
    //                   elevation: 2.0,
    //                   color: Theme.of(context).primaryColor,
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.all(
    //                       Radius.circular(10.0),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //   );
    // }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Skills'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Column(
        children: [
          _nameTextfield(),
          Padding(
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
                            'Add Skill',
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
          ),

          //_formActionButton(),
        ],
      ),
    );
  }
}
