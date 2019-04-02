import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/pages/doctor/doctor_page.dart';
import 'package:quela/pages/login/login_page.dart';
import 'package:quela/pages/patient/patient_page.dart';
import 'package:quela/pages/staff/staff_page.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp(auth: Auth()));
}

class MyApp extends StatefulWidget {
  final Auth auth;

  MyApp({Key key, @required this.auth}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthBloc authBloc;

  Auth get auth => widget.auth;

  @override
  void initState() {
    authBloc = AuthBloc(auth: auth);
    authBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      bloc: authBloc,
      child: MaterialApp(
        title: 'Quela',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthEvents, AuthStates>(
          bloc: authBloc,
          builder: (BuildContext context, AuthStates state) {
            /*if (state is BeforeAuth) {
              return SplashPage();
            }*/
            if (state is PatientAuthenticated) {
              return PatientPage();
            }
            if (state is StaffAuthenticated) {
              return StaffPage();
            }
            if (state is DoctorAuthenticated) {
              return DoctorPage();
            }
            if (state is Unauthenticated) {
              return LoginPage(auth: auth);
            }
            if (state is Loading) {
              // NOTE: We could use a better loading design here
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ),
    );
  }
}
