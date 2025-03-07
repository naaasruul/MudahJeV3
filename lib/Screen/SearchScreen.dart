import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mudahjev3/Screen/SearchResultScreen.dart';
import 'package:mudahjev3/Utils/constant.dart';
import 'package:quickalert/quickalert.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

final _firestore = FirebaseFirestore.instance;

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  List<Map<String, dynamic>> selectedItems = [];

  void _addToSelected(Map<String, dynamic> note) {
    setState(() {
      selectedItems.add(note);
    });
  }

  void _removeFromSelected(Map<String, dynamic> note) {
    setState(() {
      selectedItems.remove(note);
    });
  }



  @override
  Widget build(BuildContext context) {
    void goToResultPage() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResultScreen(content: selectedItems)));
    }
    void confirmSentence() {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          text: selectedItems.isNotEmpty
              ? 'Are you sure you want to proceed with: ${selectedItems.map((item) => '${item['title']}').join(" ")}?'
              : 'No items selected',
          confirmBtnText: 'Yes',
          cancelBtnText: 'No',
          confirmBtnColor: Color(kPrimaryColor),
          onConfirmBtnTap: (){
            Navigator.pop(context);
            goToResultPage();
          }
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search TextField
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(

                labelText: 'Make a sentence',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query; // Update search query
                });
              },
            ),

            // Display selected chips
            Wrap(
              spacing: 8.0,
              children: selectedItems
                  .map(
                    (item) => Chip(
                      label: Text(item['title']),
                      onDeleted: () => _removeFromSelected(item),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 20),

            // Firestore StreamBuilder
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('lessons').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'An error occurred: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No lessons available.'),
                    );
                  }

                  // Process Firestore documents
                  var documents = snapshot.data!.docs.map((doc) {
                    return doc.data() as Map<String, dynamic>;
                  }).toList();

                  // Filter the results based on the search query
                  var filteredResults = documents.where((doc) {
                    // Ensure 'notes' exists and is a list
                    if (doc['notes'] is! List) return false;

                    // Check if any 'title' in the 'notes' array matches the query
                    List notes = doc['notes'];
                    return notes.any((note) {
                      if (note is Map<String, dynamic>) {
                        String title = note['title'] ?? "";
                        return title
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase());
                      }
                      return false;
                    });
                  }).toList();

                  // No matching results
                  if (filteredResults.isEmpty) {
                    return const Center(
                      child: Text('No matching results found.'),
                    );
                  }

                  // Render the filtered results
                  return ListView.builder(
                    itemCount: filteredResults.length,
                    itemBuilder: (context, index) {
                      var result = filteredResults[index];
                      List notes = result['notes'];

                      // Extract relevant note fields safely
                      return ListView.builder(
                        shrinkWrap: true,
                        // Allows nested ListView inside another
                        physics: const NeverScrollableScrollPhysics(),
                        // Prevents scroll conflict
                        itemCount: notes.length,
                        itemBuilder: (context, noteIndex) {
                          var note = notes[noteIndex] as Map<String, dynamic>;
                          print('INI APA::: $note');
                          String title = note['title'] ?? "No Title";
                          String pronouns = note['pronouns'] ?? "No Pronouns";

                          return ListTile(
                            title: Text(title),
                            subtitle: Text(pronouns),
                            onTap: () {
                              if (!selectedItems.contains(title)) {
                                _addToSelected(note);
                              }
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your onPressed logic here
                      confirmSentence();
                      print(selectedItems);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                      backgroundColor: Color(kSecondaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      elevation: 8,
                      // Adds shadow effect
                      textStyle: const TextStyle(
                        fontSize: 20, // Larger font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );


}
}
