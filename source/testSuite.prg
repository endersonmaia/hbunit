#include "hbclass.ch"

class TTestSuite inherit TTest
  method Run()
  method CountTestCases()         inline  Len( ::aTests )
  method AddTest( oTest )         inline  AAdd( ::aTests, oTest )
  
  protected:
    data aTests as array init {}
endclass

method Run()
  local i
  
  for i := 1 to ::CountTestCases()
    ::aTests[i]:Run()
  next
return ( ::oResult )

