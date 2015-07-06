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

CLASS TTestSuite FROM TTest
  METHOD new() CONSTRUCTOR
  METHOD className()
  DATA cClassName

  METHOD run()
  METHOD countTestCases()
  METHOD addTest( oTest )

  PROTECTED:
    DATA aTests
ENDCLASS

METHOD new() CLASS TTestSuite
  _Super:new()
  ::cClassName := "TTestSuite"
  ::aTests := {}
  RETURN ( SELF )

METHOD className() CLASS TTestSuite
  RETURN( ::cClassName )

METHOD run() CLASS TTestSuite
  LOCAL i

  FOR i := 1 TO ::countTestCases()
    ::aTests[i]:run()
  NEXT
RETURN ( ::oResult )

METHOD countTestCases() CLASS TTestSuite
  RETURN ( LEN( ::aTests ) )

METHOD addTest( oTest ) CLASS TTestSuite
  RETURN ( AADD( ::aTests, oTest ) )
