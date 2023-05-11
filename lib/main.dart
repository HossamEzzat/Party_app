import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wedding/pages/onboarding_screen.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    
  runApp(const  MaterialApp(
    debugShowCheckedModeBanner: false,
      home:  OnboardingScreen(),
    ));


}

var pinkColor = Colors.blueGrey[900];

class customButton extends StatelessWidget {
 final String text;
  final Function()? onPressed;

  customButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      child: ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
              backgroundColor: MaterialStatePropertyAll(Colors.blueGrey[900]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            // ignore: sort_child_properties_last
            child:  Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                     fontWeight: FontWeight.bold,
                      fontSize: 25),
              ),
            onPressed: onPressed,
         ),
    );
  }
}

