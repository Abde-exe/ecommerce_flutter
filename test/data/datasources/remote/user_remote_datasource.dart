import 'dart:convert';

import 'package:ecommerce_flutter/core/constants/strings.dart';
import 'package:ecommerce_flutter/core/errors/exceptions.dart';
import 'package:ecommerce_flutter/core/errors/failures.dart';
import 'package:ecommerce_flutter/data/datasources/remote/user_remote_datasource.dart';
import 'package:ecommerce_flutter/data/models/user/authentication_response_model.dart';
import 'package:ecommerce_flutter/domain/usecases/user/sign_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'user_remote_datasource.mocks.dart';

//class MockHttpClient extends Mock implements http.Client {}
void main() {
  late MockClient mockHttpClient;
  late UserRemoteDatasourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = UserRemoteDatasourceImpl(client: mockHttpClient);
  });

  group('signIn', () {
    test('should perform a POST request to correct URL withe given parameters',
        () async {
      //arrange
      final fakeParams =
          SignInParams(username: 'user1', password: 'password1');
      const expectedUrl = '$baseUrl/auth/login';
      final fakeResponse = fixture('user/authentication_response.json');
      when(mockHttpClient.post(
        Uri.parse(expectedUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'username': fakeParams.username, 'password': fakeParams.password}),
      )).thenAnswer((_) async => http.Response(fakeResponse, 200));
      //act
      final result = await dataSource.signIn(fakeParams);
      //assert
      verify(mockHttpClient.post(Uri.parse(expectedUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': fakeParams.username,
            'password': fakeParams.password
          })));
      expect(result, isA<AuthenticationResponseModel>());
    });
    test('should throw a CredentialFailure on 400 or 401 status code',
        () async {
      //arrange
      final fakeParams =
          SignInParams(username: 'username', password: 'password');
      const expectedUrl = '$baseUrl/auth/login';
      when(mockHttpClient.post(
            Uri.parse(expectedUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': fakeParams.username,
              'password': fakeParams.password
            }),
          )).thenAnswer((_) async => http.Response('Error message', 400));
      //act
          final result = dataSource.signIn(fakeParams);
      //assert
      expect(result, throwsA(isA<CredentialsFailure>()));
    });
  });

  test('should throw a ServerException on non-200 status code other than 400 or 401',
      ()async{
    final fakeParams = SignInParams(username: 'username', password: 'password');
    const expectedUrl = '$baseUrl/auth/login';
    when(mockHttpClient.post(Uri.parse(expectedUrl),
    headers: {
      'Content-Type':'application/json'
    },
    body: json.encode({
      'username':fakeParams.username,
      'password':fakeParams.password
    }))).thenAnswer((_) async=> http.Response('Error message', 404));

    final result = dataSource.signIn(fakeParams);
    expect(result, throwsA(isA<ServerException>()));
      });
}
