import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/epidemic_provider.dart';

class Informations extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<Informations> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAlert(context);
    });
  }

  void _showAlert(BuildContext context) {
    final diseases =
        Provider.of<EpidemicProvider>(context, listen: false).diseases;
    if (diseases != null && diseases.isNotEmpty) {
      final diseaseCount = diseases.length;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Epidemic Alert'),
          content:
              Text('There are $diseaseCount epidemic diseases in your region.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final diseases = Provider.of<EpidemicProvider>(context).diseases;

    return Scaffold(
        appBar: AppBar(
          title: Text('Epidemic Information'),
        ),
        body: Column(
          children: [
            Text(
              "Epidemic diseases",
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            diseases == null || diseases.isEmpty
                ? Center(child: Text('No epidemic diseases reported.'))
                : ListView.builder(
                    itemCount: diseases.length,
                    itemBuilder: (context, index) {
                      final disease = diseases[index];
                      return Card(
                        margin: EdgeInsets.all(10.0),
                        child: ListTile(
                          title: Text(disease.diseaseName,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Reported cases: ${disease.reported}'),
                        ),
                      );
                    },
                  ),
          ],
        ));
  }
}
