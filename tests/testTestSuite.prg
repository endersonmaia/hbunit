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

#include "hbclass.ch"

class TTestTestSuite inherit TTestCase
  method testAddTest()
endclass

method TestAddTest()
  local oSuite := TTestSuite():New(),;
        oCase := TTestCase():New()
  
  AssertEquals( 0, oSuite:CountTestCases(), "test CountTestCases() after creation" )
  oSuite:AddTest( oCase )
  AssertEquals( 1, oSuite:CountTestCases(), "test CountTestCases() after adding a testcase" )
return ( nil )

