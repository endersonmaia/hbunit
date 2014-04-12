//-- copyright
// hbunit is a unit-testing framework for the Harbour language.
//
// Copyright (C) 2014 Enderson maia <endersonmaia _at_ gmail _dot_ com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// See COPYRIGHT for more details.
//++

#include "hbunit.ch"

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