/*
  textRunner.prg
    console output class.
  
  dionisio olo
*/

#include "hbclass.ch"

class TTextRunner inherit TTestRunner
  method ShowResults()
endclass

method ShowResults()
  local aErrors := ::oResult:GetErrors(),;
        aFailures := ::oResult:GetFailures(),;
        nTestCases := ::oResult:GetTestCasesCount(),;
        nAsserts := ::oResult:GetAssertCount(),;
        nErrors := Len( aErrors ),;
        nFailures := Len( aFailures ),;
        oError, oFailure,;
        i

  ? "Testcases: " + LTrim( Str( nTestCases ))
  ? "Asserts:   " + LTrim( Str( nAsserts ))
  ? "Errors:    " + LTrim( Str( nErrors ))
  ? "Failures:  " + LTrim( Str( nFailures ))

  if ( nErrors + nFailures == 0 )
    ?
    ? "Ok."
  else
    if ( nErrors > 0 )
      ?
      ? "Errors:"

      for i := 1 to nErrors
        oError := aErrors[i]
        ? PadL( i, 4 ), oError:Description, oError:Operation, ToAssertStr( oError:Args )
      next
    endif

    if ( nFailures > 0 )
      ?
      ? "Failures:"

      for i := 1 to nFailures
        oFailure := aFailures[i]
        ? PadL( i, 4), oFailure:Description, if( !( Empty( oFailure:Args )), ToAssertStr( oFailure:Args), "" )
      next
    endif
  endif
return ( nil )

static function ToAssertStr( cArgs )
return ( "[" + cArgs + "]" )
