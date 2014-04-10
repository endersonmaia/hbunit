/*
  assert.prg
    main assertion code to be used by the testing framework.  due to
    some difference with the Java coding, exact port from JUnit may
    not be possible while maintaining PRG level coding only.
    
  by: dionisio olo
*/
static oResultObject

function Fail( cMsg )
return ( Assert( .f.,, "Failure: " + cMsg, "" ))

function AssertEquals( xExp, xAct, cMsg )
return ( Assert( xExp, xAct, cMsg,;
                 "Exp: " + ToStr( xExp, .t. ) + ", Act: " + ToStr( xAct, .t. )))

function AssertNotEquals( xExp, xAct, cMsg )
return ( Assert( xExp, xAct, cMsg,;
                 "Exp: not " + ToStr( xExp, .t. ) + ", Act: " + ToStr( xAct ),;
                 .t. ))

function AssertTrue( xAct, cMsg )
return ( Assert( .t., xAct , cMsg, "Exp: .t., Act: " + ToStr( xAct, .t. )))

function AssertFalse( xAct, cMsg )
return ( Assert( .f., xAct , cMsg, "Exp: .f., Act: " + ToStr( xAct, .t. )))

function AssertNil( xAct, cMsg )
return ( Assert( nil, xAct , cMsg, "Exp: nil, Act: " + ToStr( xAct, .t. )))

function AssertNotNil( xAct, cMsg )
return ( Assert( nil, xAct , cMsg, "Exp: not nil, Act: " + ToStr( xAct, .t. ), .t. ))


function SetAssertResultObject( oResult )
return ( oResultObject := oResult )

function Assert( xExp, xAct, cMsg, aArgs, lInvert )
  local oError
  
  if( lInvert == nil, lInvert := .f., )
  
  try
    oResultObject:IncrementAssertCount()
    
    if (( lInvert .and. IsEqual( xExp, xAct )) .or.;
        ( !( lInvert ) .and. ( !( IsEqual( xExp, xAct  )))))

      oResultObject:AddFailure( ErrorNew( "EAssertFailure",,, cMsg, aArgs ))
    endif

  catch oError
    oResultObject:AddError( oError )
  end
return ( nil )

static function IsEqual( xExp, xAct )
  local lResult := .f.
  
  do case
    case ValType( xExp ) != ValType( xAct )
    case ( !( xExp == xAct ))
    otherwise
      lResult := .t.
  endcase
return ( lResult )

function ToStr( xVal, lUseQuote )
  local cStr, i
  
  if( lUseQuote == nil, lUseQuote := .f., )
  
  switch ValType( xVal )
    case "C";     cStr := xVal; exit
    case "M";     cStr := xVal; exit
    case "L";     cStr := if( xVal, ".t.", ".f." ); exit
    case "D";     cStr := DToC( xVal ); exit
    case "N";     cStr := LTrim( Str( xVal )); exit
    case "A";     cStr := "arr"; exit
    case "O";     cStr := "obj"; exit
    case "B";     cStr := "blk"; exit
    default;      cStr := "nil"
  end

  if ( lUseQuote .and. ValType( xVal ) == "C" )
    cStr := "'" + cStr+ "'"
  endif
return ( cStr )




/*
 *      Throw( ErrorNew( "MySys", 1001, "MyOperation", "My Description", { "MyArg" } ) )
 *
 *      ? "Success"
 *      CATCH e
 *      ? "Caught", e:SubSystem, e:SubCode, e:Operation, e:Description, ValToPrg( e:Args )
 */

