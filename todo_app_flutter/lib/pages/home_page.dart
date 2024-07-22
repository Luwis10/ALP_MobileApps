import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final Map<DateTime, List> _tasks = {};
  DateTime _selectedDay = DateTime.now();

  void _addTask(String task) {
    if (_tasks[_selectedDay] != null) {
      _tasks[_selectedDay]?.add([task, false]);
    } else {
      _tasks[_selectedDay] = [[task, false]];
    }
    _controller.clear();
    setState(() {});
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks[_selectedDay]?.removeAt(index);
      if (_tasks[_selectedDay]?.isEmpty ?? true) {
        _tasks.remove(_selectedDay);
      }
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[_selectedDay]?[index][1] = !(_tasks[_selectedDay]?[index][1] as bool);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB4E380), // #B4E380
      appBar: AppBar(
        title: const Text('To Do List'),
        backgroundColor: const Color(0xFF88D66C), // #88D66C
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime.utc(2000, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            eventLoader: (day) {
              return _tasks[day] ?? [];
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks[_selectedDay]?.length ?? 0,
              itemBuilder: (context, index) {
                return TodoList(
                  taskName: _tasks[_selectedDay]?[index][0] as String,
                  taskCompleted: _tasks[_selectedDay]?[index][1] as bool,
                  onChanged: (value) => _toggleTaskCompletion(index),
                  deleteFunction: (context) => _deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add a new todo item',
                    filled: true,
                    fillColor: const Color(0xFFB4E380), // #B4E380
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF88D66C), // #88D66C
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF73BBA3), // #73BBA3
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _addTask(_controller.text);
                }
              },
              backgroundColor: const Color(0xFF73BBA3), // #73BBA3
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
