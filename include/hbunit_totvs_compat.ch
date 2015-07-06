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

#ifndef _HBUNIT_TOTVS_COMPAT_CH
#define _HBUNIT_TOTVS_COMPAT_CH

#include "tryexception.ch"

#xcommand ?  [<list,...>] => ConOut( [ <list> ] )
#xcommand ?? [<list,...>] => ConOut( [ <list> ] )


// BEGIN __objGetMethodList
#xtranslate __objGetMethodList( <OBJECT> ) => _ADVPL_OML( <OBJECT> )

STATIC FUNCTION _ADVPL_OML ( oObj )
  LOCAL aAux := ClassMethArr( oObj ), aMethods := {}
  FOR i := 1 TO LEN( aAux ); AAdd( aMethods, aAux[i][1] ); NEXT
RETURN ( aMethods )
// END __objGetMethodList

// BEGIN __objSendMsg
#xtranslate __objSendMsg( <OBJECT>, <METHOD> ) => _ADVPL_OSM( <OBJECT>, <METHOD> )

STATIC FUNCTION _ADVPL_OSM( oObj, cMethod )
  LOCAL xRet, bCall, aMethods

  aMethods := _ADVPL_OML( oObj )

  IF ( ASCAN( aMethods, cMethod ) > 0 )
  	bCall := &("{ |o| o:" + cMethod + "() }")
  	xRet := EVAL( bCall, oObj )
  ELSE
    xRet := .F.
  ENDIF
RETURN ( xRet )
// END __objSendMsg

#xtranslate HIDDEN:     =>
#xtranslate PROTECTED:  =>

#endif // _HBUNIT_TOTVS_COMPAT_CH
