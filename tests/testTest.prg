function testTest()
  local oTestCase := TTestTestCase():New()
        oRunner := TTestRunner():New()
        
  oRunner:Run( oTest )

  inkey( 5 )
return ( nil )

