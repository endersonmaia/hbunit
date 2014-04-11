#include "hbclass.ch"

CLASS TTestSuite INHERIT TTest
  METHOD run()
  METHOD countTestCases()  INLINE  LEN( ::aTests )
  METHOD addTest( oTest )  INLINE  AADD( ::aTests, oTest )
  
  PROTECTED:
    DATA aTests AS ARRAY INIT {}
ENDCLASS

METHOD run() CLASS TTestSuite
  LOCAL i
  
  FOR i := 1 TO ::countTestCases()
    ::aTests[i]:run()
  NEXT
RETURN ( ::oResult )