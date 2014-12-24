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

FUNCTION main()

  LOCAL oRunner := TTextRunner():new()
  LOCAL oSuite := TTestSuite():new()

  oSuite:AddTest( TTestAssert():new() )
  oSuite:AddTest( TTestTestSuite():new() )
  oSuite:AddTest( TTestMock():new() )

  oRunner:Run( oSuite )

  inkey( 5 )

  RETURN ( nil )