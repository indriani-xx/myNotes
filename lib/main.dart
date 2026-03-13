import 'package:flutter/material.dart';
import 'package:coba/models/box_note.dart';

void main() => runApp(const MaterialApp(home: MyNotesPage()));

class MyNotesPage extends StatefulWidget {
  const MyNotesPage({super.key});

  @override
  State<MyNotesPage> createState() => _MyNotesPageState();
}

class _MyNotesPageState extends State<MyNotesPage> {
  // 1. Simpan data catatan dalam List
  List<Map<String, String>> notes = [
    {"title": "My First Note", "content": "Konten pertama..."}
  ];

  // 2. Fungsi untuk menambah catatan
  void _addNote() {
    setState(() {
      notes.add({
        "title": "Catatan Baru ${notes.length + 1}",
        "content": "Ini isi catatan yang baru dibuat."
      });
    });
  }

  void _deleteNote(String id) {
    setState(() {
      notes.removeWhere((note) => note['id'] == id);
    });
  } // Fungsi untuk menghapus catatan berdasarkan id

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => print(item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Pengaturan')),
              PopupMenuItem<int>(value: 1, child: Text('Keluar')),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Loop data dari list 'notes'
            ...notes.map((data) => Note(
                  id: DateTime.now().toString(),
                  title: data['title']!,
                  content: data['content']!,
                  createAt: DateTime.now(),
                  maxline: 2,
                  onDelete: () =>
                      _deleteNote(data['id']!), // memanggil fungsi hapus
                )),
          ],
        ),
      ),
      // 3. Gunakan FloatingActionButton bawaan agar lebih rapi
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote, // Panggil fungsi tambah saat diklik
        backgroundColor: const Color.fromARGB(255, 74, 30, 36),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
