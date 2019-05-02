import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:quela/bloc/blocs.dart';

class MockAuth extends Mock implements Auth {}

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  LoginBloc loginBloc;
  MockAuthBloc authBloc;
  MockAuth auth;

  setUp(() {
    auth = MockAuth();
    authBloc = MockAuthBloc();
    loginBloc = LoginBloc(
      auth: auth,
      authBloc: authBloc,
    );
  });

  test('initial state is correct', () {
    expect(BeforeLogin(), loginBloc.initialState);
  });

  test('dispose does not emit new states', () {
    expectLater(
      loginBloc.state,
      emitsInOrder([]),
    );
    loginBloc.dispose();
  });

  group('LoginButtonPressed', () {
    test('emits token on success as patient', () {
      final expectedResponse = [
        BeforeLogin(),
        LoginLoading(),
        BeforeLogin(),
      ];

      when(auth.signIn(
        email: 'p@p.com',
        password: '123456',
      )).thenAnswer((_) => Future.value('N06b7ifreWfD8zuJRLTmyGFISgA2'));

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verify(authBloc
                .dispatch(LoggedIn(token: 'N06b7ifreWfD8zuJRLTmyGFISgA2')))
            .called(1);
      });

      loginBloc.dispatch(ButtonPressed(
        email: 'p@p.com',
        password: '123456',
      ));
    });

    test('emits token on success as doctor', () {
      final expectedResponse = [
        BeforeLogin(),
        LoginLoading(),
        BeforeLogin(),
      ];

      when(auth.signIn(
        email: 'd@d.com',
        password: '123456',
      )).thenAnswer((_) => Future.value('a3sL8ZCdZ3fVTnsObi7RVC33VYz1'));

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verify(authBloc
                .dispatch(LoggedIn(token: 'a3sL8ZCdZ3fVTnsObi7RVC33VYz1')))
            .called(1);
      });

      loginBloc.dispatch(ButtonPressed(
        email: 'd@d.com',
        password: '123456',
      ));
    });

    test('emits token on success as staff', () {
      final expectedResponse = [
        BeforeLogin(),
        LoginLoading(),
        BeforeLogin(),
      ];

      when(auth.signIn(
        email: 's@s.com',
        password: '123456',
      )).thenAnswer((_) => Future.value('0HvatwZd9UXMrUSckd6nUfRYZOh1'));

      expectLater(
        loginBloc.state,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verify(authBloc
                .dispatch(LoggedIn(token: '0HvatwZd9UXMrUSckd6nUfRYZOh1')))
            .called(1);
      });

      loginBloc.dispatch(ButtonPressed(
        email: 's@s.com',
        password: '123456',
      ));
    });
  });
}
