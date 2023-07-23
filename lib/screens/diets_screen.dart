import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DietsScreen extends StatefulWidget {
  @override
  _DietsScreenState createState() => _DietsScreenState();
}

class _DietsScreenState extends State<DietsScreen> {
  List<Map<String, dynamic>> _diets = [];

  @override
  void initState() {
    super.initState();
    _fetchDiets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diets'),
        backgroundColor: Colors.lightGreen,
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
            Expanded(
              child: ListView.builder(
                itemCount: _diets.length,
                itemBuilder: (context, index) {
                  final diet = _diets[index];
                  return _buildDietCard(diet);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchDiets() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('diets').get();
    final List<Map<String, dynamic>> diets =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    setState(() {
      _diets = diets;
    });
  }

  Widget _buildDietCard(Map<String, dynamic> diet) {
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
              diet['name'] ?? '',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen),
            ),
            SizedBox(height: 8),
            Text(
              'Type: ${diet['type'] ?? ''}',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 16),
            Text(
              diet['description'] ?? '',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
