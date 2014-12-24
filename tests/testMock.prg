#include "xhb.ch"
#include "hbclass.ch"

CLASS TTestMock INHERIT TTestCase

  METHOD testMockConstruction()
  METHOD testInvalidCharacterMockConstrution()
  METHOD testWhenCalling()
  METHOD testWithArgs()
  METHOD testShouldReturn()

ENDCLASS

METHOD testMockConstruction() CLASS TTestMock
  
  mock = TMock():new("MyClass")

  ::assertEquals(mock:cClassName, "MyClass", "cClassName should be 'MyClass'")

  RETURN ( nil )

METHOD testInvalidCharacterMockConstrution() CLASS TTestMock

  mock = TMock():new(123)
  ::assertFalse(mock, "TMock():new(123) should return false")

  mock = TMock():new(.T.)
  ::assertFalse(mock, "TMock():new(.T.) should return false")

  RETURN ( nil )

METHOD testWhenCalling() CLASS TTestMock
  
  mock = TMock():new("MyClass")  
  mock:whenCalling("method()")

  ::assertEquals(mock:cCalledMethod, "method()", "cCalledMethod should be 'method()'") 

  RETURN ( nil )

METHOD testWithArgs() CLASS TTestMock

  mock = TMock():new("MyClass")  
  mock:whenCalling("method()"):withArgs("arg1", 2)

  ::assertEquals(mock:aArgs[1], "arg1", "mock:aArgs[1] should be 'arg1'")
  ::assertEquals(mock:aArgs[2], 2, "mock:aArgs[1] should be 2")
  RETURN ( nil )

METHOD testShouldReturn() CLASS TTestMock
  
  mock = TMock():new("MyClass")  
  mock:whenCalling("method()"):withArgs("arg1"):shouldReturn(.T.)

  ::assertEquals(mock:returnValue, .T., "mock:returnValue should be .T.")

  RETURN ( nil )