import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housekeep/data/models/job_model.dart';

class JobService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> postJob(Job job) async {
    try {
      
      final jobData = job.toJson();
      // Remove id (Firestore generates it)
      jobData.remove('id');
      
      // Add to Firestore
      await _firestore.collection('jobs').add(jobData);
    } catch (e) {
      Get.snackbar('Error', 'Failed to post job: $e');
      rethrow;
    }
  }

  // 👀 GET AVAILABLE JOBS (for keepers)
  Stream<List<Job>> getAvailableJobs() {
    return _firestore
        .collection('jobs')
        .where('status', isEqualTo: 'open')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Job.fromJson(doc.data())).toList());
  }

  // ✋ APPLY FOR A JOB
  Future<void> applyForJob(String jobId, String keeperId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot =
            await transaction.get(_firestore.collection('jobs').doc(jobId));
        
        if (!snapshot.exists) throw Exception('Job not found');

        List<dynamic> applicants = List<dynamic>.from(snapshot['applicants'] ?? []);
        if (!applicants.contains(keeperId)) {
          applicants.add(keeperId);
          transaction.update(snapshot.reference, {'applicants': applicants});
        }
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to apply: $e');
      rethrow;
    }
  }

  Stream<List<Job>> getJobsBySeeker(String seekerId) {
    return _firestore
        .collection('jobs')
        .where('seekerId', isEqualTo: seekerId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Job.fromJson(doc.data())).toList());
  }
}