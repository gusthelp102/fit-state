import 'package:flutter/material.dart';
import 'package:fit_state/services/exercise_api.dart';

class ExercisesScreen extends StatefulWidget {
  @override
  _ExercisesScreenState createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  String _selectedMuscle = '';
  List<String> _bodyMuscles = ['Biceps', 'Triceps', 'Chest', 'Shoulders'];

  @override
  void initState() {
    super.initState();
    // Set the initial selected muscle to the first muscle in the list
    _selectedMuscle = _bodyMuscles.isNotEmpty ? _bodyMuscles.first : '';
    _fetchExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
        backgroundColor: Colors.lightGreen,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.lightGreen.withOpacity(0.8)],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            DropdownButton(
              value: _selectedMuscle,
              onChanged: (newValue) {
                setState(() {
                  _selectedMuscle = newValue.toString();
                  _fetchExercises();
                });
              },
              items: _bodyMuscles.map((muscle) {
                return DropdownMenuItem(
                  value: muscle,
                  child: Text(
                    muscle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _selectedMuscle == muscle
                          ? Colors.lightGreen
                          : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _fetchExercises(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Failed to fetch exercises.',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  } else {
                    List<dynamic> exercises = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = exercises[index];
                        return _buildExerciseCard(exercise);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> _fetchExercises() async {
    if (_selectedMuscle.isEmpty) {
      return [];
    }

    return await ExerciseApi.fetchExercises(_selectedMuscle);
  }

  Widget _buildExerciseCard(dynamic exercise) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise['name'] ?? '',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.fitness_center, color: Colors.lightGreen),
                SizedBox(width: 8),
                Text(
                  'Type: ${exercise['type'] ?? ''}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.accessibility, color: Colors.lightGreen),
                SizedBox(width: 8),
                Text(
                  'Equipment: ${exercise['equipment'] ?? ''}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              exercise['instructions'] ?? '',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
