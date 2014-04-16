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
  METHOD run( oTest )
ENDCLASS

METHOD run( oTest ) CLASS TTextRunner
  OutStd( "." )
  ::super:run( oTest )
  RETURN ( NIL )

METHOD showResults() CLASS TTextRunner
  LOCAL aErrors := ::oResult:getErrors(),;
        aFailures := ::oResult:getFailures(),;
        nTestCases := ::oResult:getTestCasesCount(),;
        nAsserts := ::oResult:getAssertCount(),;
        nErrors := LEN( aErrors ),;
        nFailures := LEN( aFailures ),;
        oError, oFailure,;
        i

  OutStd( hb_EOL() )
  OutStd( "Testcases: ", LTRIM( STR( nTestCases ) ), hb_EOL() )
  OutStd( "Asserts:   ", LTRIM( STR( nAsserts   ) ), hb_EOL() )
  OutStd( "Errors:    ", LTRIM( STR( nErrors    ) ), hb_EOL() )
  OutStd( "Failures:  ", LTRIM( STR( nFailures  ) ), hb_EOL() )

  IF( nErrors + nFailures == 0 )
    OutStd( hb_EOL(), "Ok." )
  ELSE
    IF( nErrors > 0 )
      ?
      ? "Errors:"

      FOR i := 1 to nErrors
        oError := aErrors[i]

        OutErr( PADL( i, 4 ), ;
                ", Desc: "      , oError:description,   ;
                ", Operation: " , oError:operation,     ;
                " Args: "       , toStr( oError:args )  ;
              )
      NEXT
    ENDIF

    IF( nFailures > 0 )
      ?
      ? "Failures:"

      FOR i := 1 to nFailures
        oFailure := aFailures[i]
        OutErr( PADL( i, 4 ), ;
                ", Desc: "      , oFailure:description, ;
                " Args: "       , IIF( !( EMPTY( oFailure:args ) ), toStr( oError:args ), ) ;
              )
      NEXT
    ENDIF
  ENDIF
RETURN ( nil )