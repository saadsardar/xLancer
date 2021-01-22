import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User extends ChangeNotifier {
  bool _isLoggedin = false;

  String userId;
  String email;
  String name;
  String phoneNumber;
  String picture;
  DateTime dob;
  String bio;
  bool isSignedInWithGoogle;
  //String dpurl;
  User({
    this.userId,
    this.email,
    this.name,
    this.bio,
    this.phoneNumber,
    this.picture,
    this.dob,
    this.isSignedInWithGoogle,
  });
  User.fromJson(Map<String, dynamic> json)
      : this.userId = json['userId'],
        this.email = json['email'],
        this.name = json['name'],
        this.bio = json['bio'],
        this.phoneNumber = json['phoneNumber'],
        this.picture = json['picture'],
        this.dob = json['dob'],
        this.isSignedInWithGoogle = json['isSignedInWithGoogle'];

  //google logic
  Future<String> signInWithGoogle() async {
    String msg = '';
    try {
      final _auth = FirebaseUser.FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      // print('Google Signed In');
      final FirebaseUser.AuthCredential credential =
          FirebaseUser.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      isSignedInWithGoogle = true;
      final FirebaseUser.UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser.User user = authResult.user;
      // print('Credentials Signed In');
      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final FirebaseUser.User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);
        userId = currentUser.uid;
        name = googleSignInAccount.displayName;
        email = googleSignInAccount.email;
        picture = googleSignInAccount.photoUrl;
        // print(name);
        final userInstance = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        if (userInstance.data() != null) {
          msg = 'Already logged in';
          // print(userInstance.data());
        }
        //phonenum, dob, cnic
        // print('signInWithGoogle succeeded: $user');
        _isLoggedin = true;
      }
    } on PlatformException catch (e) {
      msg = e.toString();
      print(e);
    } on FirebaseUser.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        msg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        msg = 'Wrong password provided for that user.';
      }
      print(e);
    } catch (e) {
      print(e);
      msg = e.toString();
    }
    print(msg);
    return msg;

    //return null;
  }

  Future<String> addUserGoogleDetails(Map<String, dynamic> userInfo) async {
    var msg = '';
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'email': email,
          'name': name,
          'phoneNumber': userInfo['phone'],
          'picture': picture,
          'dob': userInfo['dob'],
          'bio': userInfo['bio'],
          'isSignedInWithGoogle': true,
        },
      );
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userId)
          .set(
        {
          'name': name,
          'picture': picture,
          'title': 'Add your Title',
          'phoneNumber': userInfo['phone'],
          'location': 'Add Location',
          'rate': '0.00',
          'summary': 'Add your summary',
        },
      );
    } catch (e) {
      print(e);
      msg = e.toString();
    }
    _isLoggedin = true;
    return msg;
  }

  Future<void> editpicture(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'picture': userInfo['picture'],
        },
      );
      picture = userInfo['picture'];
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }

  Future<void> editname(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'name': userInfo['name'],
        },
      );
      name = userInfo['name'];
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }

  Future<String> signIn(String email1, String pass1) async {
    var msg = '';
    FirebaseUser.UserCredential userCredential;
    try {
      userCredential = await FirebaseUser.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email1, password: pass1);
      userId = userCredential.user.uid;
      final userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userSnap.data().isEmpty) {
        msg = 'Not Authorized';
      } else {
            FirebaseUser.User user = FirebaseUser.FirebaseAuth.instance.currentUser;

        if (!user.emailVerified) {
          msg = 'Please verify email before login';
          signOut();
        }
        _isLoggedin = true;
        notifyListeners();
      }
    } on FirebaseUser.FirebaseAuthException catch (e) {
      // print('Firebase Auth Exception');
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        msg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        msg = 'Wrong password provided for that user.';
      }
      msg = e.code;
    } catch (e) {
      print('Exception');
      print(e);
      msg = e.toString();
    }
    return msg;
  }

  bool get loggedIn {
    var currentUser = FirebaseUser.FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _isLoggedin = true;
    }
    return _isLoggedin;
  }

  Future<String> setUser() async {
    String errormsg = '';
    // print('User ID Before: $userId');
    if (FirebaseUser.FirebaseAuth.instance.currentUser != null) {
      if (userId == null) {
        var currentUser = FirebaseUser.FirebaseAuth.instance.currentUser;
        final id = currentUser.uid;
        userId = id;
      }
      try {
        final userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        final userInfo = userSnap.data();
        name = userInfo['name'];
        email = userInfo['email'];
        phoneNumber = userInfo['phoneNumber'];
        picture = userInfo['picture'];
        dob = userInfo['dob'].toDate();
        isSignedInWithGoogle = userInfo['isSignedInWithGoogle'];
        bio = userInfo['bio'];
      } catch (e) {
        print(e);
        if (e != null) errormsg = e.toString();
      }
    }
    return errormsg;
  }

  Future<String> registerUser(
      String emailAdd, String pass, String phoneNum) async {
    // UserCredential userCredential;
    var msg = '';
    try {
      //final user =
      await FirebaseUser.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailAdd, password: pass)
          .then((value) {
        userId = value.user.uid;
        email = emailAdd;
        phoneNumber = phoneNum;

        // addUserDetailsDemo();
        // addUserDetails();
        // return;
      });

      // await user.sendEmailVerification();
    } on FirebaseUser.FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Email Already In Use');
        msg = 'Email Already In Use';
      } else if (e.code == 'weak-password') {
        print('Weak password');
        msg = 'Weak password';
      }
      msg = e.code;
    } catch (e) {
      msg = '${e.toString()}';
      print(e);
    }
    print('Register Function Finishing');
    return msg;
    // notifyListeners();
  }

  Future<String> addUserDetails(Map<String, dynamic> userInfo) async {
    var msg = '';
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'email': email,
          'name': userInfo['name'],
          'phoneNumber': phoneNumber,
          'picture': userInfo['picture'],
          'dob': userInfo['dob'],
          'bio': userInfo['bio'],
          'isSignedInWithGoogle': false,
        },
      );
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userId)
          .set(
        {
          'name': userInfo['name'],
          'picture': userInfo['picture'],
          'title': 'Enter Title',
          'location': 'Add Location',
          'rate': 'Enter Rate',
          'summary': 'Enter Summary',
          'portfolio': '',
          'skills': '',
          'certificates': '',
        },
      );
      FirebaseUser.User user = FirebaseUser.FirebaseAuth.instance.currentUser;

      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      signOut();
    } catch (e) {
      print(e);
      msg = e.toString();
    }
    _isLoggedin = true;
    return msg;
  }

  Future<void> signOut() async {
    try {
      await FirebaseUser.FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    } on FirebaseUser.FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    // userId = '';
    // name = '';
    _isLoggedin = false;

    notifyListeners();
    return;
  }

//   Future<String> changePassword(String password) async {
//     final user = FirebaseUser.FirebaseAuth.instance.currentUser;
//     var msg = '';
//     user.updatePassword(password).then((_) {
//       // print("Succesfull changed password");
//     }).catchError((error) {
//       print("Password can't be changed" + error.toString());
//       msg = 'Password can\'t be changed ${error.toString()}';
//       //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
//     });
//     return msg;
//   }

//   bool signInByGoogle() {
//     return isSignedInWithGoogle;
//   }
// }
}
