#include "hbclass.ch"

class TFileName
  method New() constructor
  method GetFileName()
  method GetFileRoot()        inline  ::FileRoot
  method GetFileExt()         inline  ::FileExt
  
  protected:
    data FileRoot as character init ""
    data FileExt  as character init ""
endclass

method New( AFileName )
  local DotPosition
  
  if ( ValType( AFileName ) == "C" )
    DotPosition := At( ".", AFileName )
    
    if ( DotPosition == 1 )
      ::FileExt := SubStr( AFileName, 2 )
    elseif ( DotPosition > 1 )
      ::FileRoot := Left( AFileName, DotPosition-1 )
      ::FileExt := Right( AFileName, DotPosition-1 )
    else
      ::FileRoot := AFileName
    endif
  endif
return ( nil )

method GetFileName()
  local AFileExt := ::GetFileExt(),;
        AFileName := ""
  
  AFileName := ::GetFileRoot() + If( !( Empty( AFileExt )), "." + AFileExt, "" )
return ( AFileName )
