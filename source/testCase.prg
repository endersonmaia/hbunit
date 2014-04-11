#include "xhb.ch"
#include "hbclass.ch"

CLASS TTestCase inherit TTest
  METHOD countTestCases() INLINE  1
  METHOD run()
  METHOD setUp()          VIRTUAL
  METHOD tearDown()       VIRTUAL

  PROTECTED:
    DATA  oResult as object init TTestResult():New()
ENDCLASS

METHOD run() CLASS TTestCase
  ::oResult:run ( SELF )
  RETURN ( ::oResult )