#include "xhb.ch"

/*
  testResult.prg
    test result gatherer class for the framework.
  
  by: dionisio olo
*/

#include "hbclass.ch"

class TTestResult
  method CountErrors()              inline  Len( ::aErrors )
  method CountFailures()            inline  Len( ::aFailures )
  method AddError( oError )         inline  AAdd( ::aErrors, oError )
  method AddFailure( oFailure )     inline  AAdd( ::aFailures, oFailure )
  method IncrementAssertCount()     inline  ::nAssertCount ++
  method GetErrors()                inline  ::aErrors
  method GetFailures()              inline  ::aFailures
  method GetTestCasesCount()        inline  ::nTestCases
  method GetAssertCount()           inline  ::nAssertCount
  method Run()
  
  protected:
    classdata aErrors as array init {}
    classdata aFailures as array init {}
    classdata nTestCases as numeric init 0
    classdata nAssertCount as numeric init 0
    
  hidden:
    method InvokeTestMethod()
    method GetTestMethods()

    data aMethods as array init {}
endclass

method Run( oTest )
  local cMethod, i
  
  // ::StartTest()
  SetAssertResultObject( Self )
  ::GetTestMethods( oTest )
  ::nTestCases += Len( ::aMethods )

  for each cMethod in ::aMethods
    ::InvokeTestMethod( oTest, "SETUP")
    ::InvokeTestMethod( oTest, cMethod )
    ::InvokeTestMethod( oTest, "TEARDOWN")
  next

// ::EndTest()
return ( nil )

method GetTestMethods( oTest )
  local aMethods := __objGetMethodList( oTest ),;
        cMethod
  
  ::aMethods := {}
  
  for each cMethod in aMethods
    if ( left( cMethod, 4 ) == "TEST" )
      AAdd( ::aMethods, cMethod )
    endif
  next
return ( nil )

method InvokeTestMethod( oTest, cMethod )
  local oError
  
  try
    __ObjSendMsg( oTest, cMethod )         // invoke the method
    
  catch oError
    oError:Args := oTest:ClassName + ":" + cMethod
    ::AddError( oError )
  end
return ( nil )
