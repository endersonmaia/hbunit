#include "hbclass.ch"

class TTestCase inherit TTest
  method CountTestCases()         inline  1
  method Run()
  method SetUp()    virtual
  method TearDown() virtual

  protected:
    data oResult as object init TTestResult():New()
endclass

method Run()
  ::oResult:Run ( self )
return ( ::oResult )

