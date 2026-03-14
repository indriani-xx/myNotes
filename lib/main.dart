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

  void _showAddNoteDialog() {
    // Fungsi untuk menampilkan dialog tambah catatan
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Note'),
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
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void _deleteNote(String id) {
    setState(() {
      notes.removeWhere((note) => note['id'] == id);
    });
  } // Fungsi untuk menghapus catatan berdasarkan id

  void _editNote(String id, String newTitle, String newContent) {
    setState(() {
      final index = notes.indexWhere((note) => note['id'] == id);
      if (index != -1) {
        notes[index]['title'] = newTitle;
        notes[index]['content'] = newContent;
      }
    });
  }

  void _showEditDialog(String id, String title, String content) {
    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController contentController =
        TextEditingController(text: content);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Note'),
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
                _editNote(id, titleController.text, contentController.text);
                Navigator.pop(context);
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
            onSelected: (item) => (item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 0, child: Text('Pengaturan')),
              const PopupMenuItem<int>(value: 1, child: Text('Keluar')),
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
                  onEdit: () => _showEditDialog(data['id']!, data['title']!,
                      data['content']!), // memanggil fungsi edit
                )),
          ],
        ),
      ),
      // 3. Gunakan FloatingActionButton bawaan agar lebih rapi
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog, // Panggil fungsi tambah saat diklik
        backgroundColor: const Color.fromARGB(255, 74, 30, 36),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
