import 'package:sqflite/sqflite.dart';
import '../screens/model.dart';

late Database _db;

Future<void> initializeDatabase() async {
  _db = await openDatabase(
    "student.db",
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE student (id INTEGER PRIMARY KEY, rollno INTEGER, name TEXT, phoneno REAL, imageurl,age INTEGER);",
      );
    },
  );
}

Future<void> addStudent(StudentModel value) async {
  await _db.rawInsert(
    "INSERT INTO student (id, rollno, name, phoneno, imageurl,age) VALUES (?, ?, ?, ?, ?, ?)",
    [
      value.id,
      value.rollno,
      value.name,
      value.phoneno,
      value.imageurl,
      value.age
    ],
  );
}

Future<List<Map<String, dynamic>>> getAllStudents() async {
  final values1 = await _db.rawQuery("SELECT * FROM student");
  return values1;
}

Future<void> deleteStudent(int id) async {
  await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
}

Future<void> updateStudent(StudentModel updatedStudent) async {
  await _db.update(
    'student',
    {
      'rollno': updatedStudent.rollno,
      'name': updatedStudent.name,
      'phoneno': updatedStudent.phoneno,
      'age': updatedStudent.age
    },
    where: 'id = ?',
    whereArgs: [updatedStudent.id],
  );
}
