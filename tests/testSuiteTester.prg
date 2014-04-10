#include "hbclass.ch"

function main()
  local oRunner := TTextRunner():New(),;
        oTest := TTestSuiteTest():New()

  oRunner:Run( oTest )
  inkey( 5 )
return ( nil )

