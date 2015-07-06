//-- copyright
// hbunit is a unit-testing framework for the Harbour language.
//
// Copyright (C) 2014 Enderson maia <endersonmaia _at_ gmail _dot_ com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// See COPYRIGHT for more details.
//++

#include "hbunit.ch"

STATIC STaErrors
STATIC STaFailures
STATIC STnTestCases
STATIC STnAssertCount

CLASS TTestResultData

  METHOD new() CONSTRUCTOR

  METHOD ClassName()
  DATA cClassName

  METHOD countErrors()
  METHOD countFailures()
  METHOD addError( oError )
  METHOD addFailure( oFailure )
  METHOD incrementAssertCount()
  METHOD addTestCaseCount( nCount )
  METHOD getErrors()
  METHOD getFailures()
  METHOD getTestCasesCount()
  METHOD getAssertCount()

ENDCLASS

METHOD new() CLASS TTestResultData

  ::cClassName := "TTestResultData"

  IIF ( STaErrors == nil, STaErrors := {}, )
  IIF ( STaFailures == nil, STaFailures := {}, )
  IIF ( STnTestCases == nil, STnTestCases := 0, )
  IIF ( STnAssertCount == nil, STnAssertCount := 0, )

  RETURN ( SELF )

METHOD countErrors() CLASS TTestResultData
  RETURN ( Len( STaErrors ) )

METHOD countFailures() CLASS TTestResultData
  RETURN ( Len( STaFailures ) )

METHOD addError( oError ) CLASS TTestResultData
  RETURN ( AAdd( STaErrors, oError ) )

METHOD addFailure( oFailure ) CLASS TTestResultData
  RETURN ( AAdd( STaFailures, oFailure ) )

METHOD incrementAssertCount() CLASS TTestResultData
  RETURN ( STnAssertCount++ )

METHOD addTestCaseCount( nCount ) CLASS TTestResultData
  RETURN ( STnTestCases += nCount )

METHOD getErrors() CLASS TTestResultData
  RETURN ( STaErrors )

METHOD getFailures() CLASS TTestResultData
  RETURN ( STaFailures )

METHOD getTestCasesCount() CLASS TTestResultData
  RETURN ( STnTestCases )

METHOD getAssertCount() CLASS TTestResultData
  RETURN ( STnAssertCount )

METHOD ClassName() CLASS TTestResultData
  RETURN ( ::cClassName )
