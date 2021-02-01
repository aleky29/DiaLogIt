import 'package:flutter/material.dart';
import 'controller/form_controller.dart';
import 'model/form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiaLogIt',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'DiaLogIt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController fechaController = TextEditingController();
  TextEditingController mgdlController = TextEditingController();
  TextEditingController unidadesController = TextEditingController();
  TextEditingController alimentosController = TextEditingController();
  TextEditingController actividadPreviaController = TextEditingController();
  TextEditingController actividadPosteriorController = TextEditingController();
  TextEditingController notasController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      DiaForm feedbackForm = DiaForm(
          fechaController.text,
          mgdlController.text,
          unidadesController.text,
          alimentosController.text,
          actividadPreviaController.text,
          actividadPosteriorController.text,
          notasController.text);

      FormController formController = FormController();

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Feedback Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      });
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: fechaController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid date';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(labelText: 'Fecha y hora'),
                      ),
                      TextFormField(
                        controller: mgdlController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter mg/dl';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'mg/dL',
                        ),
                      ),
                      TextFormField(
                        controller: unidadesController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid amount';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(labelText: 'Unidades de insulina'),
                      ),
                      TextFormField(
                        controller: alimentosController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Escribe los alimentos que vas a consumir';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(labelText: 'Alimentos'),
                      ),
                      TextFormField(
                        controller: actividadPreviaController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Actividades en horas previas';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration:
                            InputDecoration(labelText: 'Actividades previas'),
                      ),
                      TextFormField(
                        controller: actividadPosteriorController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Actividades a realizar';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: 'Actividades Posteriores'),
                      ),
                      TextFormField(
                        controller: notasController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Síntomas u otros';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Notas'),
                      ),
                    ],
                  ),
                )),
            RaisedButton(
              color: Colors.pink,
              textColor: Colors.white,
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
