function main() 
  local ATest := TTestdbfield():New(),; 
        ARunner := TTextRunner():New(),; 
        AnError 
 
  try 
    ARunner:Run( ATest ) 
  catch AnError 
    ? "Error: " + AnError:Description 
    ? "   at " + ProcName(0) + "(" + LTrim( Str( ProcLine(0))) + ")" 
  end 
return ( nil ) 
