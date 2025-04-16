// import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       home: RatingPage(),
// //     );
// //   }
// // }

// class RatingPage extends StatefulWidget {
//   const RatingPage({super.key});

//   @override
//   _RatingPageState createState() => _RatingPageState();
// }

// class _RatingPageState extends State<RatingPage> {
//   // Variabel untuk menyimpan rating
//   double _rating = 0.0;

//   // Fungsi untuk mengubah rating
//   void _onRatingChanged(double value) {
//     setState(() {
//       _rating = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Rating System'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Widget Rating menggunakan bintang
//             RatingBar(
//               onRatingChanged: _onRatingChanged,
//             ),
//             const SizedBox(height: 20),
//             Text('Your Rating: ${_rating.toString()}',
//                 style: const TextStyle(fontSize: 24)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Widget untuk Rating Bar
// class RatingBar extends StatelessWidget {
//   final Function(double) onRatingChanged;
//   const RatingBar({required this.onRatingChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(5, (index) {
//         return IconButton(
//           icon: Icon(
//             index < 4 ? Icons.star : Icons.star_border,
//             color: Colors.amber,
//             size: 40,
//           ),
//           onPressed: () => onRatingChanged(index + 1.0),
//         );
//       }),
//     );
//   }
// }
