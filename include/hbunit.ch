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

#ifdef __HARBOUR__
  #include "hbclass.ch"
#else
  #ifdef TOTVS
    #include "totvs.ch"
    #include "hbunit_totvs_compat.ch"
  #else
    #include "protheus.ch"
    #include "hbunit_totvs_compat.ch"
  #endif    
#endif

#XTRANSLATE TRY             => TRYEXCEPTION
#XTRANSLATE TRY EXCEPTION   => TRYEXCEPTION
#XTRANSLATE CATCH           => CATCHEXCEPTION
#XTRANSLATE CATCH EXCEPTION => CATCHEXCEPTION

#xcommand TRYEXCEPTION       => bError := errorBlock( {|oErr| break( oErr ) } ) ;;
                                BEGIN SEQUENCE
#xcommand CATCHEXCEPTION [<!oErr!>]  => errorBlock( bError ) ;;
                                        RECOVER [USING <oErr>] <-oErr-> ;;
                                        errorBlock( bError )

#endif // _HBUNIT_CH