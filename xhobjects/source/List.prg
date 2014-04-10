#include "hbclass.ch"

class TList
  method Count()
  method Item()
  method Add()
  
  protected:
    data ItemCount as numeric init 0
    data List as array init {}
  
endclass

method Count()
return ( ::ItemCount )

method Item( AnItemIndex )
  local Item
  
  try
    Item := ::List[ AnItemIndex]
  catch
    Throw( ErrorNew( "EListIndexOutOfBounds" ))
  end
return ( Item )

method Add( AnItem )
  AAdd( ::List, AnItem )
  ::ItemCount++
return ( nil )
