import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ViewFeedback extends StatefulWidget {
  const ViewFeedback({super.key});

  @override
  State<ViewFeedback> createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
  @override
  void initState() {
    super.initState();
    // fetchFeedbacks();
  }

  // Future<List<Feedback>>
  // Future<bool>
  Future<List<dynamic>> fetchFeedbacks() async {
    String url = "http://192.168.0.113/doc_wizard/index.php/view_feedback";
    // String url = "http://192.168.52.78/doc_wizard/index.php/view_feedback";
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print(jsonData['feedback']);
      return jsonData['feedback'];
    } else {
      throw Exception('Failed to load feedbacks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Feedbacks'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchFeedbacks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Loading spinner
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No feedback available'));
          } else {
            // If the data is available, display it
            final feedbackList = snapshot.data!;
            return ListView.builder(
              itemCount: feedbackList.length,
              itemBuilder: (context, index) {
                final feedback = feedbackList[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email: ${feedback['email']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),

                        // Display rating using RatingBar
                        Row(
                          children: [
                            Text(
                              'Rating: ',
                              style: TextStyle(fontSize: 16),
                            ),
                            RatingBarIndicator(
                              rating: double.parse(
                                  feedback['no_of_star'].toString()),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),

                        // Display date
                        Text(
                          'Date: ${feedback['date']}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 10),

                        // Display message
                        Text(
                          'Feedback: ${feedback['msg']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// class FeedbackCard extends StatelessWidget {
//   final Feedback feedback;

//   const FeedbackCard({Key? key, required this.feedback}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       feedback.name,
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       feedback.email,
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 // Display star rating using flutter_rating_bar
//                 RatingBarIndicator(
//                   rating: feedback.stars,
//                   itemBuilder: (context, index) => const Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                   ),
//                   itemCount: 5,
//                   itemSize: 20.0,
//                   unratedColor: Colors.grey,
//                   direction: Axis.horizontal,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Text(
//               feedback.description,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
