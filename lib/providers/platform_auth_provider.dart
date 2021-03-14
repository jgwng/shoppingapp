import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/all.dart' as KAKAO;
import 'package:shoppingapp/service/kakao_auth.dart';

class SignInViewModel with ChangeNotifier {
  SignInViewModel({@required this.auth});
  final FirebaseAuth auth;
  bool isLoading = false;
  dynamic error;

  Future<void> _signIn(String platform, dynamic token) async {
    try {
      isLoading = true;
      notifyListeners();
      switch(platform){
       case "google":
          auth.signInWithCredential(token);
          break;
        case "apple":
          auth.signInWithCredential(token);
          break;
      }
      error = null;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async{
    try{
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      if(googleSignInAccount != null){
        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        if(googleAuth.accessToken != null && googleAuth.idToken != null) {
          _signIn("google", GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
        }
      }
    }catch(e){
      print("error : $e");
    }
  }

  Future<void> signInWithPhone() async{


//https://www.youtube.com/watch?v=PEUUYOQ2Ixo&t=469s

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+82 010 4129 0741',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async{
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        // Handle other errors
      },
      codeSent: (String verificationId, int resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(phoneAuthCredential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signInWithKakao() async{
    try {
      KakaoLogin kakaoLogin = KakaoLogin();
      await kakaoLogin.initKakaoInstalled();
      KAKAO.AccessTokenResponse token;
      if (kakaoLogin.kakaoInstalled) {
        token = await kakaoLogin.loginWithTalk();
      } else {
        token = await kakaoLogin.loginWithKakao();
      }
      HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'asia-northeast3').httpsCallable("kakaoCustomAuth");
      HttpsCallableResult result =  await callable.call(<String,dynamic>{
          "userId" : token.accessToken,
          "provider" : 'KAKAO'});
      print("result : ${result.data}");
      await signInWithCustomToken(result.data);
    } catch(e){
      print("문제발생 : $e");
    }

  }

  signInWithCustomToken(token)async{
    return (await auth.signInWithCustomToken(token)).user;
  }
}