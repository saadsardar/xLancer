import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/project.dart';
import 'package:xlancer/Models/user.dart';

import '../main_screen.dart';


class NewProjectScreen extends StatefulWidget {
  static const routeName = '/newproject-screen';
  @override
  _NewProjectScreenState createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {
  FocusNode titleFocusNode,
      descriptionFocusNode,
      priceFocusNode,
      deadlineFocusNode;
  final _formkey = GlobalKey<FormState>();
  // var _isInit = true;
  String _title = '', _description = '', _price = '';
  DateTime _deadline = DateTime.now();
  bool _isLoading = false;
  bool isCase = true;
  // String _error = 'No Error Dectected';
  String _currentItemSelected;
  var _experienceLevel = [
    'entry level',
    'intermediate level',
    'hard level',
  ];

  @override
  void initState() {
    super.initState();
    titleFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    priceFocusNode = FocusNode();
    deadlineFocusNode = FocusNode();
  }

  @override
  void dispose() {
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    priceFocusNode.dispose();
    deadlineFocusNode.dispose();
    super.dispose();
  }

  Widget _showtitle() {
    return Text(
      'Add New Project',
      style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _deadline)
      setState(() {
        _deadline = picked;
      });
  }

  Widget _deadlineWidget(context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: ListTile(
        leading: Icon(
          Icons.calendar_today_outlined,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Deadline'),
        subtitle: Text(
          '${DateFormat.yMMMd().format(_deadline)}',
          style: TextStyle(fontSize: 15),
        ),
        trailing: RaisedButton(
          onPressed: () => _selectDate(context),
          child: Text('Select date'),
        ),
      ),
    );
  }

  Widget descriptionWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.newline,
        focusNode: descriptionFocusNode,
        keyboardType: TextInputType.multiline,
        // initialValue: _initvalues['Description'],
        maxLines: 4,
        validator: (val) =>
            val.length > 0 ? null : 'Field Cannot Be Left Empty',
        onSaved: (val) => _description = val,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Description',
          hintText: 'Enter Description',
          icon: Icon(Icons.description),
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.newline,
        focusNode: titleFocusNode,
        keyboardType: TextInputType.name,
        validator: (val) =>
            val.length > 0 ? null : 'Field Cannot Be Left Empty',
        onSaved: (val) => _title = val,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Title',
          hintText: 'Enter title of project',
          icon: Icon(Icons.title),
        ),
      ),
    );
  }

  Widget priceWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        textInputAction: TextInputAction.newline,
        focusNode: priceFocusNode,
        keyboardType: TextInputType.number,
        validator: (val) =>
            val.length > 0 ? null : 'Field Cannot Be Left Empty',
        onSaved: (val) => _price = val,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Budget',
          hintText: 'Enter budget of project',
          icon: Icon(Icons.money),
        ),
      ),
    );
  }

  _submit() async {
    setState(() {
      _isLoading = true;
    });
    var user = Provider.of<User>(context, listen: false);
    // await uploadImages();
    // print('Back from upload printing list');
    // print(imageUrls);

    Map<String, dynamic> newProject = {
      'title': _title,
      'price': _price,
      'description': _description,
      'deadline': _deadline,
      'ownerId': user.userId,
      'level': _currentItemSelected,
    };
    print('In Screen $newProject');
    await Provider.of<Projects>(context, listen: false)
        .addNewProject(newProject);

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: _isLoading
          ? CircularProgressIndicator()
          : FlatButton(
              minWidth: MediaQuery.of(context).size.width * 0.95,
              height: 45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if (_formkey.currentState.validate() == false) {
                  return;
                }
                _formkey.currentState.save();
                print(_title);
                _submit();
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final isOrg = Provider.of<User>(context, listen: false).isOrganization;
    return
        // Center(
        //   child:
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
                _showtitle(),
                titleWidget(),
                priceWidget(),
                descriptionWidget(),
                _deadlineWidget(context),
                Container(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 20,
                    top: 50,
                    bottom: 10,
                  ),
                  child: Text(
                    'Enter the experience level of your job post',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    elevation: 8,
                    style: TextStyle(color: Colors.black),
                    items: _experienceLevel.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      'Choose from below',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (String newValueSelected) {
                      setState(() {
                        _currentItemSelected = newValueSelected;
                      });
                    },
                    value: _currentItemSelected,
                  ),
                ),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
