- Unit tests
  - When a mock already exists for a protocol in another file prefer to use that Mock instead of create a new one.
  - All new Mocks should go in a file '$(direrctory_name)Mocks' so we have a single file for each group of tests
  - When Asserting against enums that don't conform to Equatable prefer to use a pattern like  'guard case '.case(.subcase)' = .result else { fail } instead of making the enum implement Equatable
  - When testing URLComponents, there is no guaranteed order for the URL Query params, test for the existence of the parameter and the value, not asserting against the whole string
  - Each unit test should instantiate an instance of the entity being tested, and name this variable `sut`