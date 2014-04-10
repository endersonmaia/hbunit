#include "hbclass.ch"

class TDBField
  method New() constructor
  method GetName()      inline  ::Name
  method GetType()      inline  ::Type
  method GetWidth()     inline  ::Width
  method GetDecimal()   inline  ::Decimal
  
  protected:
    method SetName()
    method SetType()
    method SetWidth()
    method SetDecimal()
    data Name      as character    init ""
    data Type      as character    init ""
    data Width     as numeric      init 0
    data Decimal   as numeric      init 0
endclass

method New( AName, AType, AWidth, aDecimal )
  ::SetName( AName )
  ::SetType( AType )
  ::SetWidth( AWidth )
  ::SetDecimal( ADecimal )
return ( Self )

method SetName( AName )
  if ( AName == nil )
    ::Type := "C"
  elseif ( ValType( AName ) == "C" )
    ::Name := Upper( AName )
  else
    Throw( ErrorNew( "EInvalidFieldName" ))
  endif
return

method SetType( AType )
  if ( AType == nil )
    ::Type := "C"

  else
    if ( ValType( AType ) != "C" .or. ( !( CheckFieldType( AType ))) .or. Len( AType ) > 1 )
        Throw( ErrorNew( "EInvalidFieldType" ))
    else
      ::Type := Upper( AType )
    endif
  endif
return

method SetWidth( AWidth )
  local IsError := .t.
  
  do case
    case ( AWidth == nil .and. ::GetType() == "C" )
      ::Width := 10
      IsError := .f.
    case ( ValType( AWidth ) != "N" .or. AWidth <= 0 )
    case ( ::GetType() == "L" .and. AWidth != 1 )
    case ( ::GetType() == "D" .and. AWidth != 10 )
    otherwise
      ::Width := AWidth
      IsError := .f.
  endcase

  if ( IsError )
    Throw( ErrorNew( "EInvalidFieldWidth" ))
  endif
return

method SetDecimal( ADecimal )
  if ( ADecimal == nil )
    ::Decimal := 0
  elseif ( ValType( ADecimal ) != "N" .or. ADecimal < 0 .or. ADecimal > ::GetWidth())
    Throw( ErrorNew( "EInvalidFieldWidth" ))
  else
    ::Decimal := ADecimal
  endif
return

static function CheckFieldType( AType )
return ( Upper( AType ) $'CNLDM' )

