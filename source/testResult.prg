#include "xhb.ch"
#include "hbclass.ch"

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
  
  setAssertResultObject( Self )
  ::getTestMethods( oTest )
  ::nTestCases += Len( ::aMethods )

  FOR each cMethod in ::aMethods
    ::invokeTestMethod( oTest, "SETUP")
    ::invokeTestMethod( oTest, cMethod )
    ::invokeTestMethod( oTest, "TEARDOWN")
  NEXT
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