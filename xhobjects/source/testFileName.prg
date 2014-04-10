#include "hbclass.ch"

class TTestFileName inherit TTestCase
  method testCreation()
  method testFilename()
  method testFileRootOnly()
  method testFileExtOnly()
endclass

method testCreation()
  local AFileName

  AFileName := TFileName():New()
  AssertEquals( "", AFileName:GetFileName(), "test creation with empty filename" )
  AssertEquals( "", AFileName:GetFileRoot(), "test getting file root with empty filename" )
  AssertEquals( "", AFileName:GetFileExt(),  "test getting file extension with empty filename" )

  AFileName := TFileName():New(0)
  AssertEquals( "", AFilename:GetFilename(), "test creation with numeric parameter" )

  AFileName := TFileName():New(Date())
  AssertEquals( "", AFileName:GetFileName(), "test creation with date parameter" )
  
  AFileName := TFileName():New( "abc.def" )
  AssertEquals( "abc.def", AFileName:GetFileName(), "test with full filename" )
return nil

method testFilename()
  local AFilename := TFilename():New( "abc.def" )

  AssertEquals( "abc.def", AFileName:GetFilename(), "test getting filename for abc.def" )
  AssertEquals( "abc", AFileName:GetFileRoot(), "test getting root for abc.def" )
  AssertEquals( "def", AFileName:GetFileExt(), "test getting extesion for abc.def" )
return nil

method testFileRootOnly()
  local AFileName := TFileName():New( "abc" )

  AssertEquals( "abc", AFileName:GetFilename(), "test getting filename for abc" )
  AssertEquals( "abc", AFileName:GetFileRoot(), "test getting file root for abc" )
  AssertEquals( "", AFileName:GetFileExt(), "test getting file extension for abc" )
return nil

method testFileExtOnly()
  local AFileName := TFileName():New( ".def" )
  
  AssertEquals( ".def", AFileName:GetFileName(), "test getting filename for .def" )
  AssertEquals( "", AFileName:GetFileRoot(), "test getting file root for .def" )
  AssertEquals( "def", AFileName:GetFileExt(), "test getting file extension for .def" )
return nil


