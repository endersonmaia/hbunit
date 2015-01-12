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

CLASS TTestTestSuite inherit TTestCase
  METHOD testAddTest()
ENDCLASS

METHOD testAddTest()
  LOCAL oSuite	:= TTestSuite():New(),;
  		oCase 	:= TTestCase():New(), a

  ::assertEquals( 0, oSuite:countTestCases(), "test CountTestCases() after creation" )

  oSuite:AddTest( oCase )
  ::assertEquals( 1, oSuite:CountTestCases(), "test CountTestCases() after adding a testcase" )

  RETURN ( nil )