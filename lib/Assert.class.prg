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

CLASS TAssert
  METHOD fail( cMsg )
  METHOD assertEquals( xExp, xAct, cMsg )
  METHOD assertNotEquals( xExp, xAct, cMsg )
  METHOD assertTrue( xAct, cMsg )
  METHOD assertFalse( xAct, cMsg )
  METHOD assertNil( xAct, cMsg )
  METHOD assertNotNil( xAct, cMsg )
  METHOD assert( xExp, xAct, cMsg, lInvert )

ENDCLASS

METHOD fail( cMsg ) CLASS TAssert
  RETURN ( ::assert( .f.,, "Failure: " + cMsg ) )

METHOD assertEquals( xExp, xAct, cMsg ) CLASS TAssert
  LOCAL cErrMsg := ""

  cErrMsg += "Exp: " + ToStr( xExp, .t. )
  cErrMsg += ", Act: " + ToStr( xAct, .t. )
  cErrMsg += "( " + cMsg + " )"

  RETURN ( ::assert( xExp, xAct, cErrMsg ) )

METHOD assertNotEquals( xExp, xAct, cMsg ) CLASS TAssert
  LOCAL cErrMsg := ""

  cErrMsg += "Exp: not " + ToStr( xExp, .t. )
  cErrMsg += ", Act: " + ToStr( xAct )
  cErrMsg += "( " + cMsg + " )"

  RETURN ( ::assert( xExp, xAct, cErrMsg, .t. ) )

METHOD assertTrue( xAct, cMsg ) CLASS TAssert
  LOCAL cErrMsg := ""

  cErrMsg += "Exp: .t., Act: "
  cErrMsg += ToStr( xAct, .t. )
  cErrMsg += "( " + cMsg + " )"

  RETURN ( ::assert( .t., xAct , cErrMsg ) )

METHOD assertFalse( xAct, cMsg ) CLASS TAssert
  LOCAL cErrMsg := ""

  cErrMsg += "Exp: .f., Act: "
  cErrMsg += ToStr( xAct, .t. )
  cErrMsg += "( " + cMsg + " )"

  RETURN ( ::assert( .f., xAct , cErrMsg ) )

METHOD assertNil( xAct, cMsg ) CLASS TAssert
  LOCAL cErrMsg := ""

  cErrMsg += "Exp: nil, Act: "
  cErrMsg += ToStr( xAct, .t. )
  cErrMsg += "( " + cMsg + " )"

  RETURN ( ::assert( nil, xAct , cErrMsg ) )

METHOD assertNotNil( xAct, cMsg ) CLASS TAssert
  LOCAL cErrMsg := ""

  cErrMsg += "Exp: not nil, Act: "
  cErrMsg += ToStr( xAct, .t. )
  cErrMsg += "( " + cMsg + " )"

  RETURN ( ::assert( nil, xAct , cErrMsg, .t. ) )

METHOD assert( xExp, xAct, cMsg, lInvert ) CLASS TAssert
  LOCAL oError

  cMsg := ProcName(2) + ":" + LTRIM(STR(ProcLine(2))) + " => " + cMsg

  IF( lInvert == nil, lInvert := .f., )

  TRY
    ::oResult:IncrementAssertCount()

    IF (( lInvert .and. IsEqual( xExp, xAct )) .or.;
        ( !( lInvert ) .and. ( !( IsEqual( xExp, xAct  )))))
      ::oResult:AddFailure( xhb_ErrorNew( "EAssertFailure",,,, cMsg ) )
    ENDIF

  CATCH oError
    ::oResult:AddError( oError )
  END
return ( nil )

//METHOD IsEqual( xExp, xAct ) CLASS TAssert
FUNCTION isEqual( xExp, xAct)
  LOCAL lResult := .F.
  
  DO CASE
    CASE ValType( xExp ) != ValType( xAct )
    CASE ( !( xExp == xAct ))
    OTHERWISE
      lResult := .T.
  ENDCASE
RETURN ( lResult )

// #TODO - see where to put these util methods

FUNCTION toStr (xVal, lUseQuote )
  local cStr, i
  
  if( lUseQuote == nil, lUseQuote := .f., )
  
  switch ValType( xVal )
    case "C";     cStr := xVal; exit
    case "M";     cStr := xVal; exit
    case "L";     cStr := if( xVal, ".t.", ".f." ); exit
    case "D";     cStr := DToC( xVal ); exit
    case "N";     cStr := LTrim( Str( xVal )); exit
    case "A";     cStr := arrToStr( xVal ); exit
    case "O";     cStr := "obj"; exit
    case "B";     cStr := "blk"; exit
    default;      cStr := "nil"
  end

  if ( lUseQuote .and. ValType( xVal ) == "C" )
    cStr := "'" + cStr+ "'"
  endif

  RETURN ( cStr )

FUNCTION arrToStr( aArr )
  LOCAL cStr := "", nArrLen := 0, i

  nArrLen = LEN( aArr )

  cStr += " ARRAY => { "
  FOR i := 1 TO nArrLen
    cStr += toStr( aArr[i] )
    IIF( i < nArrLen , cStr += "," , )
  NEXT
  cStr += " }"

  RETURN ( cStr )