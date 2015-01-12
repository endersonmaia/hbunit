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
  METHOD countErrors()
  METHOD countFailures()
  METHOD addError( oError )
  METHOD addFailure( oFailure )
  METHOD incrementAssertCount()
  METHOD getErrors()
  METHOD getFailures()
  METHOD getTestCasesCount()
  METHOD getAssertCount()
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

METHOD countErrors() CLASS TTestResult
  RETURN ( Len( ::aErrors ) )

METHOD countFailures() CLASS TTestResult
  RETURN ( Len( ::aFailures ) )

METHOD addError( oError ) CLASS TTestResult
  RETURN ( AAdd( ::aErrors, oError ) )

METHOD addFailure( oFailure ) CLASS TTestResult
  RETURN ( AAdd( ::aFailures, oFailure ) )

METHOD incrementAssertCount() CLASS TTestResult
  RETURN ( ::nAssertCount++ )

METHOD getErrors() CLASS TTestResult
  RETURN ( ::aErrors )

METHOD getFailures() CLASS TTestResult
  RETURN ( ::aFailures )

METHOD getTestCasesCount() CLASS TTestResult
  RETURN ( ::nTestCases )

METHOD getAssertCount() CLASS TTestResult
  RETURN ( ::nAssertCount )