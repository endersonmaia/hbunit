#include "hbclass.ch"

class TTestList inherit TTestCase
  method testCreation()
endclass

method testCreation()
  local AList := TList():New()
  
  AssertEquals( 0, AList:Count(), "test empty list count" )
  
  try
    AssertEquals( 0, AList:Item( 1 ), "test getting an item on empty list" )
    Fail( "test getting an item beyond list did not raise an error" )
  end
  
  AList:Add( "a" )
  AssertEquals( 1, AList:Count(), "test count after adding an item" )
  AssertEquals( "a", AList:Item( 1 ), "test getting item after adding one" )

  AList:Add( "b" )
  AssertEquals( 2, AList:Count(), "test count after adding adding a 2nd item" )
  AssertEquals( "a", AList:Item( 1 ), "test getting 1st item after adding a 2nd item" )
  AssertEquals( "b", AList:Item( 2 ), "test getting 2nd item after adding a 2nd item" )
return ( nil )
