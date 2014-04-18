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
  METHOD countErrors()              INLINE  Len( ::aErrors )
  METHOD countFailures()            INLINE  Len( ::aFailures )
  METHOD addError( oError )         INLINE  AAdd( ::aErrors, oError )
  METHOD addFailure( oFailure )     INLINE  AAdd( ::aFailures, oFailure )
  METHOD incrementAssertCount()     INLINE  ::nAssertCount ++
  METHOD getErrors()                INLINE  ::aErrors
  METHOD getFailures()              INLINE  ::aFailures
  METHOD getTestCasesCount()        INLINE  ::nTestCases
  METHOD getAssertCount()           INLINE  ::nAssertCount
  METHOD run()
  
  PROTECTED:
    CLASSDATA aErrors       AS ARRAY    INIT {}
    CLASSDATA aFailures     AS ARRAY    INIT {}
    CLASSDATA nTestCases    AS NUMERIC  INIT 0
    CLASSDATA nAssertCount  AS NUMERIC  INIT 0
    
  HIDDEN:
    METHOD invokeTestMethod()
    METHOD getTestMethods()

    DATA aMethods as array init {}
ENDCLASS

METHOD run( oTest ) CLASS TTestResult
  LOCAL cMethod, i
  
  //setAssertResultObject( SELF )
  ::getTestMethods( oTest )
  ::nTestCases += Len( ::aMethods )

  FOR each cMethod in ::aMethods
    ::invokeTestMethod( oTest, "SETUP")
    ::invokeTestMethod( oTest, cMethod )
    ::invokeTestMethod( oTest, "TEARDOWN")
  NEXT

  IF ( ::countFailures() > 0 .or. ::countErrors() > 0)
    ErrorLevel ( 1 )
  ENDIF

  RETURN ( NIL )

METHOD GetTestMethods( oTest ) class TTestResult
  LOCAL aMethods := __objGetMethodList( oTest ),;
        cMethod
  
  ::aMethods := {}
  
  FOR each cMethod in aMethods
    IF ( left( cMethod, 4 ) == "TEST" )
      AAdd( ::aMethods, cMethod )
    ENDIF
  NEXT

  RETURN ( NIL )

METHOD InvokeTestMethod( oTest, cMethod ) class TTestResult
  LOCAL oError
  
  TRY
    __ObjSendMsg( oTest, cMethod )         // invoke the METHOD
    
  CATCH oError
    oError:Args := oTest:ClassName + ":" + cMethod
    ::AddError( oError )
  END
  RETURN ( NIL )