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

#ifndef _HBUNIT_CH
#define _HBUNIT_CH

#define _HBUNIT_VERSION 0.0.5-alpha

#ifdef __HARBOUR__
  #include "hbclass.ch"
  
  #define CRLF ( CHR(13) + CHR(10) )

  #XTRANSLATE _Super          => ::super
  #XTRANSLATE USER FUNCTION   => FUNCTION
  #XTRANSLATE TRY             => TRYEXCEPTION
  #XTRANSLATE TRY EXCEPTION   => TRYEXCEPTION
  #XTRANSLATE CATCH           => CATCHEXCEPTION
  #XTRANSLATE CATCH EXCEPTION => CATCHEXCEPTION

  #xcommand TRYEXCEPTION       => bError := errorBlock( {|oErr| break( oErr ) } ) ;;
                                  BEGIN SEQUENCE
  #xcommand CATCHEXCEPTION [<!oErr!>]  => errorBlock( bError ) ;;
                                          RECOVER [USING <oErr>] <-oErr-> ;;
                                          errorBlock( bError )

#else
  #include "hbunit_totvs_compat.ch"
  #ifdef TOTVS
    #include "totvs.ch"
  #else
    #include "protheus.ch"
  #endif
#endif

#endif // _HBUNIT_CH
