#include "xhUnit.ch"

function GetAssertFailures()                                  // returns array of failure exceptions
return ( aFailures )


function Failure( cMsg )                                      // asserts failure always
return ( Assert( ,, cMsg, ASSERT_FAILURE ))

function AssertEquals( xExpected, xActual, cMsg )             // asserts exact equality
return ( Assert( xExpected, xActual, cMsg, ASSERT_EQUALS ))


function AssertNotEquals( xExpected, xActual, cMsg )          // asserts exact inequality
return ( Assert( xExpected, xActual, cMsg, ASSERT_NOTEQUALS ))


function AssertTrue( xActual, cMsg )                          // asserts logical truth
return ( Assert( .t., xActual, cMsg, ASSERT_TRUE ))


function AssertFalse( xActual, cMsg )
return ( Assert( .f., xActual, cMsg, ASSERT_FALSE ))          // asserts logical false


static function Assert( xExpected, xActual, cMsg, nAssertion )
  /* main assertion function:
      if an error occurs, throws an error exception
      if a failure occurs, throws a failure exception
  */
  local lSuccess := .t.,;
        oError

  nAsserts ++
  
  try
    switch nAssertion
      case ASSERT_FAILURE;          lSuccess := .f.;                          exit
      case ASSERT_EQUALS;           lSuccess := ( xExpected == xActual );     exit
      case ASSERT_NOTEQUALS;        lSuccess := ( !( xExpected == xActual )); exit
      case ASSERT_TRUE;             lSuccess := ( xExpected == xActual );     exit
      case ASSERT_FALSE;            lSuccess := ( xExpected == xActual );     exit
      default;                      AddAssertError( ERROR_UNKNOWNASSERTION )
    end

    if ( !( lSuccess ))
      AddAssertFailure( xExpected, xActual, cMsg, nAssertion )
    endif

  catch oError
    AddAssertError( ERROR_ASSERTION, oError )
  end
return ( nil )


static function AddAssertError( nError, oError )
  /*  records an assertion error exception */
  local cMsg,;
        oAddError
        
  if ( nError == ERROR_UNKNOWNASSERTION )
    cMsg := "Unknown Assertion Error"
  else
    cMsg := oError:Description + "@" + ProcName( ERROR_PROCEDUREDEPTH ) + ToStr( ProcLine( ERROR_PROCEDUREDEPTH ))
  endif
  
  switch nError
    case ERROR_ASSERTION; oAddError := ErrorNew( ASSERTTEXT_SUBSYS, nError, ASSERTTEXT_ERROR, cMsg )
    default;              oAddError := ErrorNew( ASSERTTEXT_SUBSYS, nError, ASSERTTEXT_ERROR, cMsg )
  end
  
  AAdd( aErrors, oAddError )
return ( nil )


static function AddAssertFailure( xExpected, xActual, cMsg, nAssertion )
  /* records an assertion failure exception */

  if ( nAssertion == ASSERT_FAILURE )
    cMsg := "Failure: " + cMsg
  else
    cMsg += " (exp. " + ToStr( xExpected ) + ", was " + ToStr( xActual ) + ")"
  endif
  
  AAdd( aFailures, ErrorNew( ASSERTTEXT_SUBSYS, nAssertion, GetAssertText( nAssertion ), cMsg ))
return ( nil )


function AddExecutionError( oError )
  AAdd( aErrors, oError )
 return ( nil )


/*
 *      Throw( ErrorNew( "MySys", 1001, "MyOperation", "My Description", { "MyArg" } ) )
 *
 *      ? "Success"
 *      CATCH e
 *      ? "Caught", e:SubSystem, e:SubCode, e:Operation, e:Description, ValToPrg( e:Args )
 */
 
 
static function GetAssertText( nAssertion )
  /* returns an assertion descriptive text */
  
  switch nAssertion
    case ASSERT_EQUALS;     return ( ASSERTTEXT_EQUALS )
    case ASSERT_NOTEQUALS;  return ( ASSERTTEXT_NOTEQUALS )
    case ASSERT_TRUE;       return ( ASSERTTEXT_TRUE )
    case ASSERT_FALSE;      return ( ASSERTTEXT_FALSE )
  end
return ( nil )


static function GetAssertSymbol( nAssertion )
  /* returns a symbol of assertion */
  
  switch nAssertion
    case ASSERT_EQUALS;     return ( "==" )
    case ASSERT_NOTEQUALS;  return ( "<>" )
    case ASSERT_TRUE;       return ( " is " )
    case ASSERT_FALSE;      return ( " is " )
  end
return ( nil )


static function ToStr( xValue )
  /*  converts supported value types to string */
  local cValue := ""
  
  switch ValType( xValue )
    case "C";       return ( xValue )
    case "M";       return ( xValue )
    case "U";       return ( "nil" )
    case "D";       return ( DToC( xValue ))
    case "L";       return ( if( xValue, ".t.", ".f." ))
    case "N";       return ( LTrim( Str( xValue )))
    case "A";       return ( ArrayToStr( xValue ))
    default;        return ( "not yet supported" )
  end
return ( cValue )

 
static function ArrayToStr( aValue )
  /*  converts an array to a string */
  local cReturn := "",;
          i
          
  for i := 1 to len( aValue )
    cReturn += ToStr( aValue[ i ])
  next
return ( cReturn )
