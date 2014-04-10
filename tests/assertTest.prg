#include "hbclass.ch"

class TTestAssert inherit TTestCase
  method TestAssertErrors()
  method TestLogicals()
  method TestAssertEquals()
  method TestAssertNotEquals()
  method TestAssertNil()
  method TestAssertNotNil()
endclass

method TestAssertErrors()
  try
    a := 1/0
    Fail( "division by zero not caught" )
  end

  try
    Assert( a, "test variable not found" )
    Fail( "unable to catch 'Variable not found'" )
  end
return ( nil )

method TestLogicals()
  AssertTrue( .t., "test AssertTrue with .t." )
  AssertFalse( .f., "test AssertFalse with .f." )
return ( nil )

method TestAssertEquals()
  // test with nil
  AssertEquals( , nil, "test AssertEquals nil with nil" )
  
  // test with logicals
  AssertEquals( .t., .t., "test AssertEquals with logical .t." )
  AssertEquals( .f., .f., "test AssertEquals with logical .f." )
  
  // test with characters
  AssertEquals( "", '', "test AssertEquals with empty string" )
  AssertEquals( " ", ' ', "test AssertEquals with single space" )
  AssertEquals( "a", 'a', "test AssertEquals with single character" )
  
  // test with numerics
  AssertEquals( 0, 0, "test AssertEquals on small integers" )
  AssertEquals( 1234567890, 1234567890.0, "test AssertEquals on large integers" )
  AssertEquals( -2, -2, "test AssertEquals on small negative integers" )
  AssertEquals( -2342342342342, -2342342342342.0, "test AssertEquals on large negative integers" )
  AssertEquals( 0.1, 0.1, "test AssertEquals on single decimal float" )
  AssertEquals( 0.12345678, 0.123456780, "test AssertEquals on multiple decimal floats" )
  AssertEquals( 0.01, 0.010000, "test AssertEquals different decimal floats" )
  
  // test for other types
return ( nil )

method TestAssertNotEquals()
  AssertNotEquals( 0, 1, "test AssertNotEquals on small integers" )
  AssertNotEquals( 1234567890, 1234567891, "test AssertNotEquals on large integers" )
  AssertNotEquals( -2, -3, "test AssertNotEquals on small negative integers" )
  AssertNotEquals( -23452342342342, -23452342342343, "test AssertNotEquals on large negative integers" )
  
  // test for other types
return ( nil )

method TestAssertNil()
  AssertNil( , "test AssertNil with empty parameter" )
  AssertNil( nil, "test AssertNil with coded nil" )
return ( nil )

method TestAssertNotNil()
  AssertNotNil( 1, "test AssertNotNil on numerics" )
  AssertNotNil( 'a', "test AssertNotNil with character" )
  AssertNotNil( date(), "test AssertNotNil with date" )
  AssertNotNil( .f., "test AssertNotNil with logical" )
  AssertNotNil( array(3), "test AssertNotNil with array" )
  AssertNotNil( {||nil}, "test AssertNotNil with codeblock" )
return ( nil )
