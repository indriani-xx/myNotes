import 'package:flutter/material.dart';
import 'package:coba/widgets/box_note.dart';

void main() => runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: MyNotesPage()));

class MyNotesPage extends StatefulWidget {
  const MyNotesPage({super.key});

  @override
  State<MyNotesPage> createState() => _MyNotesPageState();
}

class _MyNotesPageState extends State<MyNotesPage> {
  // 1. Simpan data catatan dalam List
  List<Map<String, dynamic>> notes = [
    {
      "id": DateTime.now().toString(),
      "title": "My First Note",
      "content": "Konten pertama...",
      "createAt": DateTime.now()
    }
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

  void _showAddNoteDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Catatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  notes.add({
                    "id": DateTime.now().toString(),
                    "title": titleController.text,
                    "content": contentController.text,
                    "createAt": DateTime.now()
                  });
                });
              },
            )
          ],
        );
      },
    );
  }

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
                  id: data['id']!, // pastikan id ada untuk setiap catatan
                  title: data['title']!,
                  content: data['content']!,
                  createAt: data['createAt']!,
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
