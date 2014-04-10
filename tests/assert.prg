function Assert( lCondition, cMsg )
  local oError
  
  try
    if ( !( lCondition ))
      Throw( ErrorNew( "EAssertionFailed" ))
    endif
  catch oError
    Throw( oError )
  end
return ( nil )

function AssertEquals( xExpected, xActual, cMsg )
return ( Assert( xExpected == xActual, cMsg ))
