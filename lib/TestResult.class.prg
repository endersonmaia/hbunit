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

CLASS TTestResult
  METHOD new() CONSTRUCTOR
  METHOD ClassName()
  DATA cClassName

  METHOD run()

  DATA oData

HIDDEN:
    METHOD invokeTestMethod()
    METHOD getTestMethods()

ENDCLASS

METHOD new() CLASS TTestResult
  ::oData := TTestResultData():new()
  ::cClassName := "TTestResult"
  RETURN( SELF )

METHOD ClassName() CLASS TTestResult
  RETURN ( ::cClassName )

METHOD run( oTest ) CLASS TTestResult
  LOCAL aTestMethods := ::getTestMethods( oTest ),;
        nTestMethods := LEN ( aTestMethods ),;
        i

  ::oData:addTestCaseCount( nTestMethods )

  FOR i := 1 TO nTestMethods
    ::invokeTestMethod( oTest, "SETUP")
    ::invokeTestMethod( oTest, aTestMethods[i] )
    ::invokeTestMethod( oTest, "TEARDOWN")
  NEXT

  RETURN ( NIL )

METHOD getTestMethods( oTest ) CLASS TTestResult
  LOCAL aMethods := __objGetMethodList( oTest ),;
        aTestMethods := {},;
        i

  FOR i := 1 TO LEN( aMethods )
    IF ( LEFT( aMethods[i], 4 ) == "TEST" )
      AAdd( aTestMethods, aMethods[i] )
    ENDIF
  NEXT

  RETURN ( aTestMethods )

METHOD invokeTestMethod( oTest, cMethod ) CLASS TTestResult
  LOCAL oError

  TRY EXCEPTION
    __ObjSendMsg( oTest, cMethod )

  CATCH EXCEPTION oError
    oError:Args := oTest:ClassName() + ":" + cMethod
    ::addError( oError )
  END TRY

  RETURN ( NIL )
