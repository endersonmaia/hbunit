function main()
  local oRunner := TTextRunner():New()
  
  oRunner:Run( TTestAssert():New())
  inkey( 5 )
return ( nil )
