#include "hbclass.ch"

CLASS TTest
  METHOD countTestCases()   virtual
  METHOD run()              virtual
  
  PROTECTED:
    DATA  oResult INIT TTestResult():New()
ENDCLASS