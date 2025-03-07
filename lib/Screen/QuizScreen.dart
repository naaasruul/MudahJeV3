import 'package:flutter/material.dart';
import 'package:mudahjev3/Screen/HomeScreen.dart';
import 'package:mudahjev3/Screen/NoteScreen.dart';
import 'package:mudahjev3/Widgets/MyAppBar.dart';
import 'package:mudahjev3/Widgets/MyContainer.dart';
import 'package:quickalert/quickalert.dart';
import 'package:mudahjev3/Utils/constant.dart';
import 'package:video_player/video_player.dart';

class QuizScreen extends StatefulWidget {
  final List<dynamic> content;

  QuizScreen({required this.content});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0; // Track the current question index
  int? selectedAnswer; // Track the selected answer for the current question
  late VideoPlayerController _videoController; // Controller for the video player

  @override
  void initState() {
    super.initState();
    // Initialize video player controller with the URL from quiz data
    _initializeVideoPlayer();
  }

  // Initialize video player controller
  void _initializeVideoPlayer() {
    final videoUrl = widget.content[currentIndex]['video_url'];  // Get video URL from quiz data
    _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {
          _videoController.play();
          _videoController.setLooping(true);
        }); // Rebuild to display the video once it's loaded
      });
  }

  @override
  void dispose() {
    _videoController.dispose();  // Dispose of the video controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void backHome() {
      Navigator.pop(context);
    }
    final quiz = widget.content[currentIndex]; // Get current quiz data
    return Scaffold(
      appBar: MyAppBar(
        title: 'Exercise',
        backButton: false,
      ),
      body: SingleChildScrollView(
        child: MyContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Player
              Container(
                width: double.infinity,
                height: 400,
                color: Colors.grey[300],
                child: _videoController.value.isInitialized
                    ? VideoPlayer(_videoController)  // Show video if initialized
                    : const Center(
                  child: CircularProgressIndicator(),  // Show loading spinner if video not initialized
                ),
              ),
              const SizedBox(height: 20),
          
              // Quiz Question
              Center(
                child: Text(
                  'Question ${currentIndex + 1}', // Display question number
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
          
              // Options
              Column(
                children: List.generate(
                  quiz['options'].length, // Generate options dynamically
                      (optionIndex) {
                    return RadioListTile<int>(
                      title: Text(
                          'Option ${optionIndex + 1}: ${quiz['options'][optionIndex]}'),
                      value: optionIndex + 1, // Option value (1, 2, 3, ...)
                      groupValue: selectedAnswer,
                      onChanged: (value) {
                        setState(() {
                          selectedAnswer = value; // Update the selected answer
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
          
              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedAnswer != null) {
                      // Check if the selected answer is correct
                      print(selectedAnswer);
                      print(quiz['answer']);
                      if (selectedAnswer.toString() == quiz['answer'].toString()) {
                        // Show success alert if answer is correct
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Correct!',
                          showConfirmBtn: false,
                          onConfirmBtnTap: (){
                            backHome();
                          },
                          backgroundColor: Color(kWhiteColor),
                          confirmBtnColor: Color(kPrimaryColor),
                        );
                      } else {
                        // Show error alert if answer is incorrect
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: 'Incorrect. Try again!',
                          autoCloseDuration: const Duration(seconds: 2),
                          showConfirmBtn: false,
                          backgroundColor: Color(kWhiteColor),
                          confirmBtnColor: Color(kPrimaryColor),
                        );
                      }
          
                      // Move to the next question after a short delay
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          if (currentIndex < widget.content.length - 1) {
                            currentIndex++; // Move to next question
                            selectedAnswer = null; // Reset the selected answer
                            _initializeVideoPlayer(); // Reinitialize video player for the next question
                          } else {
                            // All questions completed
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              text: 'Quiz Completed!',
                              autoCloseDuration: const Duration(seconds: 2),
                              showConfirmBtn: true,
                              backgroundColor: Color(kWhiteColor),
                              confirmBtnColor: Color(kPrimaryColor),
                              onConfirmBtnTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
                              }
                            );
          
                          }
                        });
          
          
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(kPrimaryColor),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
