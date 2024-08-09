import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _notes = [];
  
  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notes = prefs.getStringList('notes') ?? [];
    setState(() {
      _notes.addAll(notes.map((note) {
        final parts = note.split('|');
        return {
          'text': parts[0],
          'completed': parts[1] == 'true',
        };
      }).toList());
    });
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notes = _notes.map((note) {
      return '${note['text']}|${note['completed']}';
    }).toList();
    await prefs.setStringList('notes', notes);
  }

  void _addNote() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _notes.add({
          'text': _controller.text,
          'completed': false,
        });
        _controller.clear();
        _saveNotes();
      });
    }
  }

  void _toggleCompletion(int index) {
    setState(() {
      _notes[index]['completed'] = !_notes[index]['completed'];
      _saveNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter note'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addNote,
              child: Text('Add Note'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  return ListTile(
                    title: Text(
                      note['text'],
                      style: TextStyle(
                        decoration: note['completed']
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: Checkbox(
                      value: note['completed'],
                      onChanged: (bool? value) {
                        _toggleCompletion(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
