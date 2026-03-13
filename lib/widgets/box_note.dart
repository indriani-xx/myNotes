import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  final String id; // id unik untuk setiap catatan
  final String title;
  final String content;
  final DateTime createAt; // waktu di buat
  final int? maxline;
  final VoidCallback? onDelete; // callback untuk fungsi hapus catatan

  //Constructor
  const Note({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.createAt,
    this.maxline,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
//Method untuk membuat catatan baru dengan ID otomatis
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(114, 47, 56, 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
            width: 15,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
            width: 15,
          ),
          Text(
            content,
            style: const TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 218, 214, 214)),
            maxLines: maxline,
            overflow:
                maxline != null ? TextOverflow.ellipsis : TextOverflow.visible,
          ),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.delete, size: 20),
                onPressed: onDelete,
                color: Colors.white,
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "${createAt.year}-${createAt.month}-${createAt.day}", // createAt.toLocal().toString().split(' ')[0],
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )),
        ],
      ),
    );
  }
}
