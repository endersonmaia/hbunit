#include "hbclass.ch"

class TTestDBField inherit TTestCase
  method testCreation()
  method testInvalidParameter()
  method testInvalidWidth()
endclass

method testCreation()
  local ADBField

  ADBField := TDBField():New()
  AssertEquals( "", ADBField:GetName(),  "test field name on parameterless creation" )
  AssertEquals( "C", ADBField:GetType(),  "test field type on parameterless creation" )
  AssertEquals( 10, ADBField:GetWidth(), "test field width on parameterless creation" )
  AssertEquals( 0, ADBField:GetDecimal(), "test field decimals on parameterless creation" )
return

method testInvalidParameter()
  local ADBField

  try
    ADBField := TDBField():New( 0, "C", 2, 0 )
    Fail( "field name should be character type" )
  end
  
  try
    ADBField := TDBField():New( "abc", 0, 1, 0 )
    Fail( "field type check, invalid type did not raise an error" )
  end
  
  try
    ADBField := TDBField():New( "abc", "X", 1, 0 )
    Fail( "field type check, invalid specified type did not raise an error" )
  end
  
  try
    ADBField := TDBField():New( "abc", "CN", 1, 0 )
    Fail( "field type check, double character check did not raise an error" )
  end
  
  try
    ADBField := TDBField():New( "abc", "N", "2", 0 )
    Fail( "field width check, non-numeric width did not raise an error" )
  end
  
  try
    ADBField := TDBField():New( "abc", "N", 2, "0" )
    Fail( "field type check, non-numeric decimal did not raise an error" )
  end
return

method testInvalidWidth()
  local ADBField
  
  try
    ADBField := TDBField():New( "abc", "N", 2, 3 )
    Fail( "field type check, decimal larger than width did not raise an error" )
  end
  
  try
    ADBField := TDBField():New( "abc", "L", 2, 0 )
    Fail( "field type check, invalid logical width did not raise an error" )
  end
  
  try
    ADBField := TDBField():New( "abc", "D", 8, 0 )
    Fail( "field type check, invalid date width did not raise an error" )
  end
return

