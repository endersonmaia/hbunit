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
    CLASSDATA aErrors       INIT {}
    CLASSDATA aFailures     INIT {}
    CLASSDATA nTestCases    INIT 0
    CLASSDATA nAssertCount  INIT 0
    
  HIDDEN:
    METHOD invokeTestMethod()
    METHOD getTestMethods()

    DATA aMethods
ENDCLASS

METHOD new() CLASS TTestResult
  ::aMethods := {}
  ::cClassName := "TTestResult"
  RETURN( SELF )

METHOD ClassName() CLASS TTestResult
  RETURN ( ::cClassName )


METHOD run( oTest ) CLASS TTestResult
  LOCAL i
  
  ::getTestMethods( oTest )
  ::nTestCases += Len( ::aMethods )

  FOR i := 1 TO LEN( ::aMethods )
    ::invokeTestMethod( oTest, "SETUP")
    ::invokeTestMethod( oTest, ::aMethods[i] )
    ::invokeTestMethod( oTest, "TEARDOWN")
  NEXT

  IF ( ::countFailures() > 0 .or. ::countErrors() > 0)
    ErrorLevel ( 1 )
  ENDIF

  RETURN ( NIL )

METHOD GetTestMethods( oTest ) class TTestResult
  LOCAL aMethods := __objGetMethodList( oTest ),;
        i
  
  ::aMethods := {}
  
  FOR i := 1 TO LEN( aMethods )
    IF ( LEFT( aMethods[i], 4 ) == "TEST" )
      AAdd( ::aMethods, aMethods[i] )
    ENDIF
  NEXT

  RETURN ( NIL )

METHOD invokeTestMethod( oTest, cMethod ) class TTestResult
  LOCAL oError
  
  TRY EXCEPTION
    __ObjSendMsg( oTest, cMethod )         // invoke the METHOD
    
  CATCH EXCEPTION oError
    oError:Args := oTest:ClassName + ":" + cMethod
    ::addError( oError )
  END TRY
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