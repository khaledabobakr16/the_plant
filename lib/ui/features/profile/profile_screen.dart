// ignore_for_file: await_only_futures, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
// ignore: unnecessary_import
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/colors.dart';
import '../../../utils/image_util.dart';
import '../../helper/app_widgets.dart';
import '../home/weather_screen.dart';
import 'widget/formfield_edit.dart';
import 'widget/image_profile.dart';
import 'widget/loading_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _fullNameEnable=false;
  IconData _fullNameIcon=CupertinoIcons.pen;
  bool _passwordEnable=false;
  IconData _passwordIcon=CupertinoIcons.pen;
  String _fullName = "";
  String _email = "";
  String _password = "";
  String _profileImageUrl = "";
  bool isLoading=true;
  bool isObscure=true;
  File? _photo;
  bool imageLoading=true;
  bool isAbsorbPointer=false;
 final ImagePicker _picker = ImagePicker();
  FirebaseAuth auth = FirebaseAuth.instance;
   FirebaseFirestore fireStore = FirebaseFirestore.instance;
   FirebaseStorage fireStorage = FirebaseStorage.instance;
   @override
  void initState() {
    super.initState();
    _loadUserData();
  }
   Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
         _photo = File(pickedFile.path);
        uploadFile();
      } else {
        log('No image selected.');
      }
    });
  }
  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
         _photo = File(pickedFile.path);
        uploadFile();
      } else {
        log('No image selected.');
      }
    });
  }

  Future uploadFile() async {

    setState(() {
    isAbsorbPointer =true;
    });
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: cYellow,
                        duration: Duration(seconds:5),
                        content: Center(
                        child: Text("Please wait until the image is finished uploading",
                        style: TextStyle(color: Colors.white)),
                        ),
                        ));
    if (_photo == null) return;
    try {
      final ref = await fireStorage.ref().child('${auth.currentUser!.uid}.jpg');
      await ref.putFile(_photo!);
      final url = await ref.getDownloadURL();
       
       log(url);
          fireStore.collection('users').doc(auth.currentUser!.uid)
         .update({
               'image':url,
          });
         
    } catch (e) {
      log('error occured');
    }
    setState(() {
    isAbsorbPointer =false;
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: cBlue,
                        duration: Duration(milliseconds: 800),
                        content: Center(
                        child: Text("The image has been uploaded successfully",
                        style: TextStyle(color: Colors.white)),
                        ),
                        ));
    });
  }
Future deleteImage() async {

    setState(() {
    isAbsorbPointer =true;
    });
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: cYellow,
                        duration: Duration(seconds:5),
                        content: Center(
                        child: Text("Please wait until the image is finished deleteing",
                        style: TextStyle(color: Colors.white)),
                        ),
                        ));
    try {
      final ref = await fireStorage.ref().child('${auth.currentUser!.uid}.jpg');
      await ref.delete();
       log(ref.toString());
          await fireStore.collection('users').doc(auth.currentUser!.uid)
         .update({
               'image':"https://firebasestorage.googleapis.com/v0/b/graduation-project-560f4.appspot.com/o/Person.jpg?alt=media&token=b04f01b0-b5f2-4fe5-9f14-9edf2297c9fd",
          });
         
    } catch (e) {
      log('error occured');
    }
  
    setState(() {
    isAbsorbPointer =false;
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: cBlue,
                        duration: Duration(milliseconds: 800),
                        content: Center(
                        child: Text("The image has been deleted successfully",
                        style: TextStyle(color: Colors.white)),
                        ),
                        ));
    });
  }
   Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        _fullName = userData['fullname'] ?? "";
        _email = userData['email'] ?? "";
        _profileImageUrl = userData['image'] ?? "";
      });
      setState(() {
    isLoading=false;
    });
    }
  }
  @override
  Widget build(BuildContext context) {
   final height=MediaQuery.of(context).size.height;
   // ignore: unused_local_variable
   final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
           const Positioned(left: 0,child:  ImageAsset(imagePath: "assets/images/predict-bubble-2.png",)),
           const Positioned(left: 0,child: ImageAsset(imagePath: "assets/images/predict-bubble-1.png",)),
          SafeArea(
            child: AbsorbPointer(
              absorbing: isAbsorbPointer,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: isLoading==true?const LoadingProfile():Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShadowButton(color: cBlue,icon: Icons.arrow_back_ios_new, onTap: () { 
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const Home()),);
                         },),
                          Center(child: Text("Edit profile",style: GoogleFonts.openSans(color:Colors.black,fontSize:24),)),
                         SizedBox(height: height*.1,),
                         Center(child: isAbsorbPointer==true?const CircularProgressIndicator(color: cBlue,): ImageProfile(onpressed: () {
                         _showPicker(context);
                         },image: _profileImageUrl, radiusImage:60,)),
                        TextButton(onPressed: (){
                          deleteImage();
                        },child:Center(child: Text("Delete my photo",style: GoogleFonts.inter(color:Colors.red,fontSize:12),)),),
                         SizedBox(height: height*.1,),
                         Text("Full Name :",style: GoogleFonts.openSans(color:cBlack,fontWeight:FontWeight.bold,fontSize:15),),
                         FormFieldEditInfo(
                      
                          onChanged: (value){
                            _fullName = value;
                         },initialValue:_fullName ,hintText: "Full Name",colorIcon:_fullNameEnable==true?cBlue:Colors.black45 ,suffixIcon: _fullNameIcon,enabled: _fullNameEnable,onpressed: (){
                          setState(() {
                              _changeFullName();
                          });
                         },),
                         SizedBox(height: height*.01,),
                         Text("E-mail :",style: GoogleFonts.openSans(color:cBlack,fontWeight:FontWeight.bold,fontSize:15),),
                         FormFieldEditInfo(onChanged: (value){},initialValue: _email,hintText: "E-mail",suffixIcon: Icons.lock,),
                        SizedBox(height: height*.01,),
                        Text("Change Password :",style: GoogleFonts.openSans(color:cBlack,fontWeight:FontWeight.bold,fontSize:15),),
                         FormFieldEditInfo(
                          onChanged: (value){
                          _password=value;
                         },hintText:"Enter New Password",colorIcon:_passwordEnable==true?cBlue:Colors.black45 ,suffixIcon: _passwordIcon,enabled: _passwordEnable,obscure:isObscure,obscureIcon:isObscure==false?Icons.visibility_off:Icons.visibility_outlined,onpressedObscure: (){
                                 setState(() {
                                if(isObscure==true)
                                {
                                  isObscure=false;
                                }
                                else
                                {
                                  isObscure=true;
                                }
                              });
                         }, onpressed: (){
                             setState(() {
                            _changePassword();
                         });
                          
                        
                         },),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
     
    );
  }
  void _changeFullName(){
   
  setState(() {
    log("yes");
    if(_fullNameEnable==false)
    {
    _fullNameEnable=true;
    _fullNameIcon=Icons.done;
    }
    else{
      _updateFullName();
    _fullNameIcon=CupertinoIcons.pen;
    _fullNameEnable=false;
    }

  });
    
  }
  void _changePassword(){
  setState(() {
    log("yes");
    if(_passwordEnable==false)
    {
    _passwordEnable=true;
    _passwordIcon=Icons.done;
    }
    else{
     _updatePassword();
    _passwordIcon=CupertinoIcons.pen;
    _passwordEnable=false;
    }

  });
  }
  Future<void> _updateFullName() async {
  final nameRegex = RegExp(r'[0-9]');
  if(_fullName.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 223, 83, 83),
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("Please enter your full name",
                style: TextStyle(color: Colors.white)),
          ),
        ));
  }
 else if (nameRegex.hasMatch(_fullName)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 223, 83, 83),
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("Full name cannot contain numbers",
                style: TextStyle(color: Colors.white)),
          ),
        ));
}
else{
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'fullname': _fullName,
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: cBlue,
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("Full name updated successfully",
                style: TextStyle(color: Colors.white)),
          ),
        ));
        log("Full name updated successfully");
      } catch (e) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 223, 83, 83),
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("Error updating full name try again please",
                style: TextStyle(color: Colors.white)),
          ),
        ));
        log("Error updating full name: $e");
      }
    }
  }
  }
Future<void> _updatePassword() async {
 final passwordRegex = RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
  if(_password.isEmpty)
  {
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 223, 83, 83),
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("Please enter new password",
                style: TextStyle(color: Colors.white)),
          ),
        ));
  }
  else if (_password.length < 6) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 223, 83, 83),
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("Your password needs to be at least 6 characters",
                style: TextStyle(color: Colors.white)),
          ),
        ));
  }
  else if (!passwordRegex.hasMatch(_password)) {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 223, 83, 83),
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character",
                style: TextStyle(color: Colors.white)),
          ),
        ));
  }              
 else{
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
      try {
        user.updatePassword(_password);
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'password': _password,
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: cBlue,
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("Password updated successfully",
                style: TextStyle(color: Colors.white)),
          ),
        ));
        log("Password updated successfully");
      } catch (e) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 223, 83, 83),
          duration: Duration(milliseconds: 800),
          content: Center(
            child: Text("Error updating password try again please",
                style: TextStyle(color: Colors.white)),
          ),
        ));
        log("Error updating password: $e");
      }
      }
    }

 
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: SizedBox(
              child: Wrap(
                children: [
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {

                        imgFromGallery();
                        Navigator.of(context).pop();
                       

                        }
                      ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                     
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

}