#include "hbclass.ch"

class TTestSuiteTest inherit TTestCase
  method testAddTest()
endclass

method TestAddTest()
  local oSuite := TTestSuite():New(),;
        oCase := TTestCase():New()
  
  AssertEquals( 0, oSuite:CountTestCases(), "test CountTestCases() after creation" )
  oSuite:AddTest( oCase )
  AssertEquals( 1, oSuite:CountTestCases(), "test CountTestCases() after adding a testcase" )
return ( nil )

