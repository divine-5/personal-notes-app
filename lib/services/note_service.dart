import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class NoteService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> notesCollection(String uid) {
    return db.collection('users').doc(uid).collection('notes');
  }

  Stream<List<Note>> getNotes(String uid) {
    return notesCollection(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Note.fromDoc(doc)).toList();
    });
  }

  Future<void> addNote(String uid, String title, String content) async {
    await notesCollection(uid).add({
      'title': title,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateNote(
      String uid,
      String id,
      String title,
      String content,
      ) async {
    await notesCollection(uid).doc(id).update({
      'title': title,
      'content': content,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String uid, String id) async {
    await notesCollection(uid).doc(id).delete();
  }
}