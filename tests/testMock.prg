//-- copyright
// hbunit is a unit-testing framework for the Harbour language.
//
// Copyright (C) 2014 Enderson maia <endersonmaia _at_ gmail _dot_ com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// See COPYRIGHT for more details.
//++

#include "hbunit.ch"

CLASS TTestMock FROM TTestCase

  METHOD testMockConstruction()
  METHOD testInvalidCharacterMockConstrution()
  METHOD testWhenCalling()
  METHOD testWithArgs()
  METHOD testShouldReturn()

ENDCLASS

METHOD testMockConstruction() CLASS TTestMock
  
  mock = TMock():new("MyClass")

  ::assert:equals(mock:cClassName, "MyClass", "cClassName should be 'MyClass'")

  RETURN ( nil )

METHOD testInvalidCharacterMockConstrution() CLASS TTestMock

  mock = TMock():new(123)
  ::assert:false(mock, "TMock():new(123) should return false")

  mock = TMock():new(.T.)
  ::assert:false(mock, "TMock():new(.T.) should return false")

  RETURN ( nil )

METHOD testWhenCalling() CLASS TTestMock
  
  mock = TMock():new("MyClass")  
  mock:whenCalling("method()")

  ::assert:equals(mock:cCalledMethod, "method()", "cCalledMethod should be 'method()'") 

  RETURN ( nil )

METHOD testWithArgs() CLASS TTestMock

  mock = TMock():new("MyClass")  
  mock:whenCalling("method()"):withArgs("arg1", 2)

  ::assert:equals(mock:aArgs[1], "arg1", "mock:aArgs[1] should be 'arg1'")
  ::assert:equals(mock:aArgs[2], 2, "mock:aArgs[1] should be 2")
  RETURN ( nil )

METHOD testShouldReturn() CLASS TTestMock
  
  mock = TMock():new("MyClass")  
  mock:whenCalling("method()"):withArgs("arg1"):shouldReturn(.T.)

  ::assert:equals(mock:returnValue, .T., "mock:returnValue should be .T.")

  RETURN ( nil )