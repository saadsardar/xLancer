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
  List tags = List();
  bool _isLoading = false;

  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    List tags = Provider.of<Freelancer>(context, listen: false).skills;
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
      // if (tags.isEmpty) {
      print('$tags ');
      Map<String, dynamic> userInfo = {
        'tags': tags,
      };
      await Provider.of<Freelancer>(context, listen: false)
          .editskills(userInfo);
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
        title: Text('Edit Skills'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.center,
            child: Tags(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.start,
              key: _globalKey,
              itemCount: tags.length,
              columns: 4,
              textField: TagsTextField(
                  textStyle: TextStyle(fontSize: 20),
                  onSubmitted: (string) {
                    setState(
                      () {
                        tags.add(
                          Item(
                            title: string,
                          ),
                        );
                      },
                    );
                  }),
              itemBuilder: (i) {
                final Item currentItem = tags[i];
                return ItemTags(
                  textStyle: TextStyle(fontSize: 18),
                  index: i,
                  title: currentItem.title,
                  customData: currentItem.customData,
                  combine: ItemTagsCombine.withTextBefore,
                  onPressed: (ind) => print(ind),
                  removeButton: ItemTagsRemoveButton(onRemoved: () {
                    setState(() {
                      tags.removeAt(i);
                    });
                    return true;
                  }),
                );
              },
            ),
          ),
          _formActionButton(),
        ],
      ),
    );
  }
}
