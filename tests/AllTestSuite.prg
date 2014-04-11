FUNCTION main()

  LOCAL oRunner := TTextRunner():New()
  LOCAL oSuite := TTestSuite():New()

  oSuite:AddTest( TTestAssert():New() )
  oSuite:AddTest( TTestTestSuite():New() )

  oRunner:Run( oSuite )

  inkey( 5 )

  RETURN ( nil )