import 'package:fit_state/services/bmi_api.dart';
import 'package:flutter/material.dart';

class BmiCalculationScreen extends StatefulWidget {
  @override
  _BmiCalculationScreenState createState() => _BmiCalculationScreenState();
}

class _BmiCalculationScreenState extends State<BmiCalculationScreen> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  double? _bmiResult;
  bool _isLoading = false; // Track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculation'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Weight (kg)',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Height (m)',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : _calculateBmi, // Disable button while loading
                child: Text('Calculate BMI'),
              ),
              SizedBox(height: 16),
              _isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(), // Show loading indicator
                    )
                  : _bmiResult != null
                      ? Text(
                          'Your BMI: ${_bmiResult!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _calculateBmi() async {
    final weight = _weightController.text.trim();
    final height = _heightController.text.trim();

    if (weight.isNotEmpty && height.isNotEmpty) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      final bmiResult = await BmiApi.calculateBmi(weight, height);

      setState(() {
        _bmiResult = bmiResult;
        _isLoading = false; // Hide loading indicator
      });
    }
  }
}
