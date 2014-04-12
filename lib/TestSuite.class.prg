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

CLASS TTestSuite INHERIT TTest
  METHOD run()
  METHOD countTestCases()  INLINE  LEN( ::aTests )
  METHOD addTest( oTest )  INLINE  AADD( ::aTests, oTest )
  
  PROTECTED:
    DATA aTests AS ARRAY INIT {}
ENDCLASS

METHOD run() CLASS TTestSuite
  LOCAL i
  
  FOR i := 1 TO ::countTestCases()
    ::aTests[i]:run()
  NEXT
RETURN ( ::oResult )