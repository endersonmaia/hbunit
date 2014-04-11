#include "xhb.ch"

/*
  testcase.prg
    to use the testing framework, one needs to inherit from this class
    and define the tests as methods with name starting with "test"
    
  by: dionisio olo
*/

#include "hbclass.ch"

class TTestCase inherit TTest
  method CountTestCases()         inline  1
  method Run()
  method SetUp()    virtual
  method TearDown() virtual

  protected:
    data  oResult as object init TTestResult():New()
endclass

method Run() CLASS TTestCase
  ::oResult:Run ( self )
return ( ::oResult )

