/*
  testMultiSuite.prg  - to show how a test suite can contain a
    combination of test cases and test suites.
    
    by: dionisio c. olo
*/

#include "hbclass.ch"

function main()
  local oRunner := TTextRunner():New(),;
        oSuite := TTestSuite():New(),;
        oSuite2 := TTestSuite():New()

  oSuite:AddTest( TTest1():New())
  oSuite:AddTest( TTest2():New())

  oSuite2:AddTest( TTest3():New())
  oSuite2:AddTest( TTest4():New())

  oSuite:AddTest( oSuite2 )
  oRunner:Run( oSuite )
  inkey( 5 )
return ( nil )


class TTest1 inherit TTestCase
  method TestOne()    inline Fail( "1 one" )
  method TestTwo()    inline Fail( "1 two" )
endclass

class TTest2 inherit TTestCase
  method TestOne()    inline Fail( "2 one" )
  method TestTwo()    inline Fail( "2 two" )
endclass

class TTest3 inherit TTestCase
  method TestOne()    inline Fail( "3 one" )
  method TestTwo()    inline Fail( "3 two" )
endclass

class TTest4 inherit TTestCase
  method TestOne()    inline Fail( "4 one" )
  method TestTwo()    inline Fail( "4 two" )
endclass

