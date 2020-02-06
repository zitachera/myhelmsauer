import 'package:customer_portal_app/model/types.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:time_machine/time_machine.dart';

class MeldenPage extends StatefulWidget {
  MeldenPage({Key key}) : super(key: key);

  @override
  _MeldenState createState() => _MeldenState();
}

class _MeldenState extends State<MeldenPage> {
  String titel;
  LocalDateTime get zeitpunkt => LocalDateTime(
      datum.year, datum.month, datum.day, zeit.hour, zeit.minute, 0);
  set zeitpunkt(LocalDateTime ldt) {
    datum = DateTime(ldt.year, ldt.monthOfYear, ldt.dayOfMonth);
    zeit = TimeOfDay(hour: ldt.hourOfDay, minute: ldt.minuteOfHour);
  }

  String description;
  String ort;
  Position gps;
  List<String> fotos;
  BearbeitungsStatus status;

  DateTime datum;
  TimeOfDay zeit;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vorfall Melden'),
        bottom: PreferredSize(
          child: Container(
            color: Colors.red,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(2.0),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _Line(
              caption: "Vetrag",
              child: Text(
                "Vertrag XY",
                textScaleFactor: 1.3,
              ),
            ),
            _Line(
              caption: 'Titel',
              child: TextFormField(
                initialValue: titel,
                onChanged: (s) => titel = s,
              ),
            ),
            _Line(
              caption: 'Datum',
              child: FlatButton(
                child: Text(
                  zeitpunkt.toString('dd.MM.yyyy'),
                  textScaleFactor: 1.3,
                ),
                onPressed: () => _selectDate(context),
              ),
            ),
            _Line(
              caption: 'Uhrzeit',
              child: FlatButton(
                child: Text(
                  zeitpunkt.toString('HH:mm'),
                  textScaleFactor: 1.3,
                ),
                onPressed: () => _selectTime(context),
              ),
            ),
            _Line(
              caption: 'Ort',
              child: FlatButton(
                child: Text(
                    "Coronastr 12, Nürnberg",
                  textScaleFactor: 1.3,
                ),
                onPressed: () => null,
              ),
            ),
            Text(
              "Beschreibung",
              textScaleFactor: 1.3,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: TextEditingController(
                  text:
                      "Lorem ipsum dolor sit amet, conempor invidunt ut laboret, sed diam voluptua. At vero eos eet jusea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset(
                    "images/crash 2.png",
                    width: 150,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset(
                    "images/crash 4.png",
                    width: 150,
                    height: 150,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset(
                    "images/crash 3.png",
                    width: 150,
                    height: 150,
                    //color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset(
                    "images/crash 5.png",
                    width: 150,
                    height: 150,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: datum,
      firstDate: null,
      lastDate: datum,
    );
    if (picked != null && picked != datum) {
      setState(() {
        datum = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: zeit);
    if (picked != null && picked != zeit) {
      setState(() {
        zeit = picked;
      });
    }
  }
}

class _Line extends StatelessWidget {
  const _Line({
    Key key,
    this.caption,
    this.child,
  }) : super(key: key);

  final String caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              caption + ":",
              textScaleFactor: 1.3,
            ),
            flex: 1,
          ),
          Expanded(
            child: child,
            flex: 2,
          ),
        ],
      ),
    );
  }
}
