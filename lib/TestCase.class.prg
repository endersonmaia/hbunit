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

CLASS TTestCase FROM TTest
  METHOD run()
  METHOD setUp()          VIRTUAL
  METHOD tearDown()       VIRTUAL
  
  PROTECTED:
    DATA assert AS OBJECT

ENDCLASS

METHOD run() CLASS TTestCase
  ::assert := TAssert():new( ::oResult )
  ::oResult:run ( SELF )
  RETURN ( ::oResult )