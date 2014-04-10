/*
  test.prg
    main parent class for the testing framework, just to provide
    an interface.
    
  by: dionisio olo
*/

#include "hbclass.ch"

class TTest
  method CountTestCases()   virtual
  method Run()              virtual
  
  //protected:
    data  oResult init TTestResult():New()
endclass





