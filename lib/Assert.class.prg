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
  METHOD fail()
  METHOD assertEquals()
  METHOD assertNotEquals()
  METHOD assertTrue()
  METHOD assertFalse()
  METHOD assertNil()
  METHOD assertNotNil()
  //METHOD toStr()
  //METHOD isEqual()

ENDCLASS

METHOD fail( cMsg ) CLASS TAssert
return ( ::assert( .f.,, "Failure: " + cMsg, "" ))

METHOD assertEquals( xExp, xAct, cMsg ) CLASS TAssert
return ( ::assert( xExp, xAct, cMsg,;
                 "Exp: " + ToStr( xExp, .t. ) + ", Act: " + ToStr( xAct, .t. )))

METHOD assertNotEquals( xExp, xAct, cMsg ) CLASS TAssert
return ( ::assert( xExp, xAct, cMsg,;
                 "Exp: not " + ToStr( xExp, .t. ) + ", Act: " + ToStr( xAct ),;
                 .t. ))

METHOD assertTrue( xAct, cMsg ) CLASS TAssert
return ( ::assert( .t., xAct , cMsg, "Exp: .t., Act: " + ToStr( xAct, .t. )))

METHOD assertFalse( xAct, cMsg ) CLASS TAssert
return ( ::assert( .f., xAct , cMsg, "Exp: .f., Act: " + ToStr( xAct, .t. )))

METHOD assertNil( xAct, cMsg ) CLASS TAssert
return ( ::assert( nil, xAct , cMsg, "Exp: nil, Act: " + ToStr( xAct, .t. )))

METHOD assertNotNil( xAct, cMsg ) CLASS TAssert
return ( ::assert( nil, xAct , cMsg, "Exp: not nil, Act: " + ToStr( xAct, .t. ), .t. ))


//METHOD SetAssertResultObject( oResult )
//return ( oResultObject := oResult )

METHOD assert( xExp, xAct, cMsg, aArgs, lInvert ) CLASS TAssert
  LOCAL oError
  
  IF( lInvert == nil, lInvert := .f., )
  
  TRY
    ::oResult:IncrementAssertCount()
    
    IF (( lInvert .and. IsEqual( xExp, xAct )) .or.;
        ( !( lInvert ) .and. ( !( IsEqual( xExp, xAct  )))))
      ::oResult:AddFailure( ErrorNew( "EAssertFailure",,, cMsg, aArgs ))
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

//METHOD toStr( xVal, lUseQuote ) CLASS TAssert
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