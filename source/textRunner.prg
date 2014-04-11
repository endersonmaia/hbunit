#include "xhb.ch"
#include "hbclass.ch"

CLASS TTextRunner inherit TTestRunner
  METHOD showResults()
ENDCLASS

METHOD showResults() CLASS TTextRunner
  LOCAL aErrors := ::oResult:getErrors(),;
        aFailures := ::oResult:getFailures(),;
        nTestCases := ::oResult:getTestCasesCount(),;
        nAsserts := ::oResult:getAssertCount(),;
        nErrors := LEN( aErrors ),;
        nFailures := LEN( aFailures ),;
        oError, oFailure,;
        i

  ? "Testcases: " + LTRIM( STR( nTestCases ))
  ? "Asserts:   " + LTRIM( STR( nAsserts ))
  ? "Errors:    " + LTRIM( STR( nErrors ))
  ? "Failures:  " + LTRIM( STR( nFailures ))

  IF( nErrors + nFailures == 0 )
    ?
    ? "Ok."
  ELSE
    IF( nErrors > 0 )
      ?
      ? "Errors:"

      FOR i := 1 to nErrors
        oError := aErrors[i]
        ? PADL( i, 4 ), oError:description, oError:operation, IF( !( Empty( oError:args )), toStr( oError:args ), "" )
      NEXT
    ENDIF

    IF( nFailures > 0 )
      ?
      ? "Failures:"

      FOR i := 1 to nFailures
        oFailure := aFailures[i]
        ? PADL( i, 4), oFailure:description, IF( !( Empty( oFailure:args )), toStr( oFailure:args ), "" )
      NEXT
    ENDIF
  ENDIF
RETURN ( nil )