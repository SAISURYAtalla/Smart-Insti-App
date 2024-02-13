import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_insti_app/provider/broadcast_provider.dart';
import 'package:smart_insti_app/models/broadcast_schema.dart';

class BroadcastPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final broadcasts = ref.watch(broadcastProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Broadcasts'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue[50],
        child: broadcasts.when(
          data: (broadcasts) {
            return SingleChildScrollView(
              child: Column(
                children: broadcasts.map((broadcast) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  broadcast.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  '${broadcast.date.day}-${broadcast.date.month}-${broadcast.date.year}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              broadcast.body,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:smart_insti_app/provider/broadcast_provider.dart';
// // import 'package:smart_insti_app/models/broadcast_schema.dart';

// class BroadcastPage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final broadcasts = ref.watch(broadcastProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Broadcasts'),
//       ),
//       body: broadcasts.when(
//         data: (broadcasts) {
//           return SingleChildScrollView(
//             child: Column(
//               children: broadcasts.map((broadcast) {
//                 return Card(
//                   margin: const EdgeInsets.all(8.0),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               broadcast.title,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18.0,
//                               ),
//                             ),
//                             Text(
//                               '${broadcast.time.hour > 12 ? broadcast.time.hour - 12 : broadcast.time.hour}:${broadcast.time.minute} ${broadcast.time.hour >= 12 ? 'PM' : 'AM'}',
//                               style: const TextStyle(
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8.0),
//                         Text(
//                           broadcast.body,
//                           style: const TextStyle(
//                             fontSize: 16.0,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }
// }
// class BroadcastPage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final broadcasts = ref.watch(broadcastProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Broadcasts'),
//       ),
//       body: broadcasts.when(
//         data: (broadcasts) {
//           return ListView.builder(
//             itemCount: broadcasts.length,
//             itemBuilder: (context, index) {
//               final broadcast = broadcasts[index];
//               return ListTile(
//                 title: Text(broadcast.title),
//                 subtitle: Text(broadcast.body),
//                 trailing: Text(
//                   '${broadcast.time.hour}:${broadcast.time.minute}',
//                 ),
//               );
//             },
//           );
//         },
//         loading: () => Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }
// }