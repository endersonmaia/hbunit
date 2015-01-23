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

CLASS TTestTestSuite FROM TTestCase
  METHOD new() CONSTRUCTOR

  METHOD testAddTest()
ENDCLASS

METHOD new() CLASS TTestTestSuite
  _Super:new()
  RETURN ( SELF )

METHOD testAddTest() CLASS TTestTestSuite
  LOCAL oSuite	:= TTestSuite():new(),;
  		  oCase 	:= TTestCase():new()

  ::assert:equals( 0, oSuite:countTestCases(), "countTestCases() should be 0 after creation" )

  oSuite:addTest( oCase )
  ::assert:equals( 1, oSuite:countTestCases(), "countTestCases() should be 1 after adding one testcase" )

  RETURN ( nil )