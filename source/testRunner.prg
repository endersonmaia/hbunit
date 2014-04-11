/*
  testRunner.prg
    base test runner class.  console and gui output classes are to
    inherit from this class and provide console/gui functionality
  
  by: dionisio olo
*/

#include "hbclass.ch"

class TTestRunner
  method Run( oResult )

  protected:
    method ShowResults()        virtual
    data    oResult as object
endclass

method Run ( oTest ) class TTestRunner
  ::oResult := oTest:Run()
  ::ShowResults()
  return ( NIL )