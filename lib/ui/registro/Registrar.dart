import 'package:flutter/material.dart';
import '../../model/Usuario.dart';
import '../home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/registro/registro_bloc.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class Registro extends StatefulWidget {
  static const String routeName = '/registro';
  const Registro({Key? key}) : super(key: key);

  @override
  State<Registro> createState() => _pantallaRegistroState();
}

// ignore: camel_case_types
class _pantallaRegistroState extends State<Registro> {

  TextEditingController controllerRut = TextEditingController();
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerDigVer = TextEditingController();
  TextEditingController controllerMail = TextEditingController();
  TextEditingController controllerNombres = TextEditingController();
  TextEditingController controllerApellidos = TextEditingController();
  TextEditingController controllerTelefono = TextEditingController();
  TextEditingController controllerClaveAcceso = TextEditingController();
  TextEditingController controllerClaveAccesoConf = TextEditingController();
  TextEditingController controllerCiudad = TextEditingController();
  TextEditingController controllerEstado = TextEditingController();

  Future registrar() async {
    Usuario usuario = Usuario.secundario(
      rut: controllerRut.text,
      digVer: controllerDigVer.text,
      mail: controllerMail.text,
      nombres: controllerNombres.text,
      apellidos: controllerApellidos.text,
      telefono: controllerTelefono.text,
      claveAcceso: controllerClaveAcceso.text,
      ciudad: controllerCiudad.text,
      estado: controllerEstado.text,
      imeiCelular: "000000",
      serieCelular: "000000",
    );
    BlocProvider.of<RegistroBloc>(context).add(Registrar(usuario));
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    StylishDialog dialog = StylishDialog(
      context: context,
      alertType: StylishDialogType.PROGRESS,
      title: Text('Registrando...'),
    );

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text(
          "Registrar",
          style: TextStyle(
            color: Color.fromARGB(255, 17, 70, 151),
            fontFamily: 'Raleway',
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 17, 70, 151), size: 50),
      ),
      backgroundColor: Colors.cyan,
      body: BlocListener<RegistroBloc, RegistroState>(
        listener: (context, state) {
          // do stuff here based on BlocA's state
          if (state is ErrorRegistro) {
            dialog.dismiss();
            SnackBar snackBarMensaje = SnackBar(
              content: Text(state.mensajeError),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBarMensaje);
          } else if (state is Registrado) {
            dialog.dismiss();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Home()));
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 16.0,
                      shadowColor: Colors.deepPurple,
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            formItemsDesign(
                              Icons.person,
                              TextFormField(
                                controller: controllerRut,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, digite el rut';
                                  }
                                },
                                decoration:
                                    const InputDecoration(hintText: "Rut"),
                              ),
                            ),
                            formItemsDesign(
                              Icons.numbers,
                              TextFormField(
                                controller: controllerDigVer,
                                maxLength: 1,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, digite el DigVer';
                                  }
                                },
                                decoration:
                                    const InputDecoration(hintText: "DigVer"),
                              ),
                            ),
                            formItemsDesign(
                              Icons.email,
                              TextFormField(
                                controller: controllerMail,
                                keyboardType: TextInputType.emailAddress,
                                maxLength: 32,
                                validator: (value) {
                                  String validate =
                                      validateEmail(value!, "email");
                                  if (validate.isNotEmpty) {
                                    return validate;
                                  }
                                },
                                decoration:
                                    const InputDecoration(hintText: "email"),
                              ),
                            ),
                            formItemsDesign(
                              Icons.person,
                              TextFormField(
                                controller: controllerNombres,
                                maxLength: 20,
                                validator: (value) {
                                  String validate =
                                      validateSoloLetras(value!, "nombre");
                                  if (validate.isNotEmpty) {
                                    return validate;
                                  }
                                },
                                decoration:
                                   const InputDecoration(hintText: "Nombres"),
                              ),
                            ),
                            formItemsDesign(
                              Icons.person,
                              TextFormField(
                                controller: controllerApellidos,
                                maxLength: 20,
                                validator: (value) {
                                  String validate =
                                      validateSoloLetras(value!, "apellidos");
                                  if (validate.isNotEmpty) {
                                    return validate;
                                  }
                                },
                                decoration:
                                    const InputDecoration(hintText: "Apellido"),
                              ),
                            ),
                            formItemsDesign(
                              Icons.phone,
                              TextFormField(
                                controller: controllerTelefono,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                validator: (value) {
                                  String validate =
                                      validateNumerico(value!, "numero");
                                  if (validate.isNotEmpty) {
                                    return validate;
                                  }
                                },
                                decoration:
                                    const InputDecoration(hintText: "Telefono"),
                              ),
                            ),
                            formItemsDesign(
                              Icons.password,
                              TextFormField(
                                controller: controllerClaveAcceso,
                                obscureText: true,
                                maxLength: 20,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, digite la contraseña';
                                  } else if (value.length < 8) {
                                    return 'Formato invalido';
                                  }
                                },
                                decoration:
                                    const InputDecoration(hintText: "Contraseña"),
                              ),
                            ),
                            formItemsDesign(
                              Icons.password,
                              TextFormField(
                                controller: controllerClaveAccesoConf,
                                obscureText: true,
                                maxLength: 20,
                                validator: (value) {
                                  String validate = validatePassword(value!);
                                  if (validate.isNotEmpty) {
                                    return validate;
                                  }
                                },
                                decoration: const InputDecoration(
                                    hintText: "Comfirmar contraseña"),
                              ),
                            ),
                            formItemsDesign(
                              Icons.person,
                              TextFormField(
                                controller: controllerCiudad,
                                maxLength: 20,
                                validator: (value) {
                                  String validate =
                                      validateSoloLetras(value!, "campo");
                                  if (validate.isNotEmpty) {
                                    return validate;
                                  }
                                },
                                decoration:
                                    const InputDecoration(hintText: "Ciudad"),
                              ),
                            ),
                            formItemsDesign(
                              Icons.person,
                              TextFormField(
                                controller: controllerEstado,
                                maxLength: 20,
                                validator: (value) {
                                  String validate =
                                      validateSoloLetras(value!, "estado");
                                  if (validate.isNotEmpty) {
                                    return validate;
                                  }
                                },
                                decoration:
                                    const InputDecoration(hintText: "Estado"),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 16)),
                            ElevatedButton(
                              onPressed: () {
                                // If the form is true (valid), or false.
                                if (_formKey.currentState!.validate()) {
                                  dialog.show();
                                  registrar();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                  ),
                                ), 
                                backgroundColor: const Color.fromARGB(255, 17, 70, 151),
                              ),
                              child: const Text(
                                "REGISTRAR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  String validateSoloLetras(String value, String text) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Por favor, digite su $text';
    } else if (!regExp.hasMatch(value)) {
      return "El $text debe de ser a-z y A-Z";
    }
    return "";
  }

  String validateNumerico(String value, String text) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return 'Por favor, digite su $text';
    } else if (value.length != 10) {
      return "El numero debe tener 10 digitos";
    } else if (!regExp.hasMatch(value)) {
      return "El numero es invalido";
    }
    return "";
  }

  String validateEmail(String value, String text) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Por favor, digite su $text';
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    }
    return "";
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Por favor, digite su contraseña';
    } else if (value.length < 8) {
      return 'Formato invalido';
    } else if (value != controllerClaveAcceso.text) {
      return "Las contraseñas no coinciden";
    }
    return "";
  }
}
