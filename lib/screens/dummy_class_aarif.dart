import 'package:aaspas/constant_and_api/aaspas_constant.dart';
import 'package:flutter/material.dart';
import '../functions/location/LocationSetterAaspas.dart';

class DummyClassAarif extends StatefulWidget {
  const DummyClassAarif({super.key});

  @override
  State<DummyClassAarif> createState() => _DummyClassAarifState();
}

class _DummyClassAarifState extends State<DummyClassAarif> {
  @override
  void initState() {
    super.initState();
    freshLocation();
  }

  Future<void> freshLocation() async {
    await LocationSetterAaspas.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Lat : ${AaspasLocator.lat}"),
            Text("Long : ${AaspasLocator.long}"),
            Text("Location Service : ${AaspasLocator.locationService}"),
            ElevatedButton(
              onPressed: freshLocation,
              child: Text("Get Latest Location"),
            ),
          ],
        ),
      ),
    );
  }
}
