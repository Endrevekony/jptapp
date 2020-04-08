import 'package:dartz/dartz.dart';
import 'package:jptapp/features/login_validation/domain/entities/login_validation.dart';
import 'package:jptapp/features/login_validation/domain/repositories/login_validation_repository.dart';
import 'package:jptapp/features/login_validation/domain/use_cases/get_login_validation.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLoginValidationRepository extends Mock
    implements LoginValidationRepository {}

void main() {
  GetLoginValidation usecase;
  MockLoginValidationRepository mockLoginValidationRepository;

  setUp(() {
    mockLoginValidationRepository = MockLoginValidationRepository();
    usecase = GetLoginValidation(mockLoginValidationRepository);
  });

  final tEmail = 'valami@valami.com';
  final tPassword = 'password123';
  final tLoginValidation = LoginValidation(email: tEmail, password: tPassword);

  test(
    'should get string from login validation repository',
    () async {
      when(mockLoginValidationRepository.getLoginValidation(any, any))
          .thenAnswer((_) async => Right(tLoginValidation));

      final result = await usecase(Params(email: tEmail,password: tPassword));

      expect(result, Right(tLoginValidation));
      verify(
          mockLoginValidationRepository.getLoginValidation(tEmail, tPassword));
      verifyNoMoreInteractions(mockLoginValidationRepository);
    },
  );
}
