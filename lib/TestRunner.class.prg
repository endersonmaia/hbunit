#include "hbclass.ch"

CLASS TTestRunner
  METHOD run( oResult )

  PROTECTED:
    METHOD  showResults() VIRTUAL
    DATA    oResult       AS OBJECT
ENDCLASS

METHOD run ( oTest ) CLASS TTestRunner
  ::oResult := oTest:run()
  ::showResults()
  RETURN ( NIL )