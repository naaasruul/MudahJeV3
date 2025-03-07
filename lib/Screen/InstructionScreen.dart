import 'package:flutter/material.dart';
import 'package:mudahjev3/Screen/QuizScreen.dart';
import 'package:mudahjev3/Utils/constant.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover, // Ensure the image covers the full screen
            ),
          ),
          height: MediaQuery.of(context).size.height, // Use full screen height
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(kBlackColor),
                                  fontSize: 32),
                            ),
                            Text(
                              'lorem ipsum loreyt tiamo',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Color(kBlackColor),
                                  fontSize: 25),
                            ),
                          ],
                        ),
                        SizedBox(height: 16,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(kPrimaryColor),
                          ),
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScreen(
                            //
                            // )));
                          },
                          child: Text(
                            'Lets GO!',
                            style: TextStyle(color: Color(kWhiteColor)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
