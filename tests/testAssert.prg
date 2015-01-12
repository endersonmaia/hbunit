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

CLASS TTestAssert INHERIT TTestCase
  METHOD testLogicals()
  METHOD testAssertEquals()
  METHOD testAssertNotEquals()
  METHOD testAssertNil()
  METHOD testAssertNotNil()

ENDCLASS

METHOD testAssertErrors()
  TRY
    a := 1/0
    ::fail( "division by zero not caught" )
  END

  TRY
    ::assert( a, "test variable not found" )
    ::fail( "unable to catch 'Variable not found'" )
  END
RETURN ( nil )

METHOD testLogicals()

  ::assertTrue( .t., "test AssertTrue with .t." )
  ::assertFalse( .f., "test AssertFalse with .f." )
  RETURN ( nil )

METHOD testAssertEquals()
  // test with nil
  ::assertEquals( , nil, "test ::assertEquals nil with nil" )
  
  // test with logicals
  ::assertEquals( .t., .t., "test ::assertEquals with logical .t." )
  ::assertEquals( .f., .f., "test ::assertEquals with logical .f." )
  
  // test with characters
  ::assertEquals( "", '', "test ::assertEquals with empty string" )
  ::assertEquals( " ", ' ', "test ::assertEquals with single space" )
  ::assertEquals( "a", 'a', "test ::assertEquals with single character" )
  
  // test with numerics
  ::assertEquals( 0, 0, "test ::assertEquals on small integers" )
  ::assertEquals( 1234567890, 1234567890.0, "test ::assertEquals on large integers" )
  ::assertEquals( -2, -2, "test ::assertEquals on small negative integers" )
  ::assertEquals( -2342342342342, -2342342342342.0, "test ::assertEquals on large negative integers" )
  ::assertEquals( 0.1, 0.1, "test ::assertEquals on single decimal float" )
  ::assertEquals( 0.12345678, 0.123456780, "test ::assertEquals on multiple decimal floats" )
  ::assertEquals( 0.01, 0.010000, "test ::assertEquals different decimal floats" )
  
  // test for other types
RETURN ( nil )

METHOD testAssertNotEquals()
  ::assertNotEquals( 0, 1, "test ::assertNotEquals on small integers" )
  ::assertNotEquals( 1234567890, 1234567891, "test ::assertNotEquals on large integers" )
  ::assertNotEquals( -2, -3, "test ::assertNotEquals on small negative integers" )
  ::assertNotEquals( -23452342342342, -23452342342343, "test ::assertNotEquals on large negative integers" )
  
  // test for other types
RETURN ( nil )

METHOD testAssertNil()
  ::assertNil( , "test ::assertNil with empty parameter" )
  ::assertNil( nil, "test ::assertNil with coded nil" )
RETURN ( nil )

METHOD testAssertNotNil()
  ::assertNotNil( 1, "test ::assertNotNil on numerics" )
  ::assertNotNil( 'a', "test ::assertNotNil with character" )
  ::assertNotNil( date(), "test ::assertNotNil with date" )
  ::assertNotNil( .f., "test ::assertNotNil with logical" )
  ::assertNotNil( array(3), "test ::assertNotNil with array" )
  ::assertNotNil( {||nil}, "test ::assertNotNil with codeblock" )
RETURN ( nil )