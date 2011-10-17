module Token where

data Token =   {- Reserved Words (http://www.ruby-doc.org/docs/keywords/1.9/) -} 
    TKeyword
  | TLocalIdent     {- local identifier       -}
  | TGlobalIdent    {- global identifier      -}
  | TClassIdent     {- class identifier       -}
  | TInstanceIdent  {- instance identifier    -}
  | TConstantIdent  {- constant identifier    -}
  | TMethodIdent    {- method identifier      -}
  | TPunctuator     {- Punctuators            -}
  | TOperator       {- Operators              -}
  | TEOL            {- '\n'                   -}
  | TLiteralInt     {- Integer literals       -}
  | TLiteralStr     {- String literals        -}
  | TEOF            {- End of File            -}

  | TLBrack             {- '[' BEGIN Punctuators -}
  | TRBrack             {- ']' -}
  | TLParen             {- '(' -}
  | TRParen             {- ')' -}
  | TLBrace             {- '{' -}
  | TRBrace             {- '}' -}
  | TColon2             {- '::' -}
  | TComma              {- ',' -}
  | TSemiColon          {- ';' -}
  | TDot                {- '.' -}
  | TDot2               {- '..' -}
  | TDot3               {- '...' -}
  | TQuestion           {- '?' -}
  | TColon              {- ':' -}
  | TAssoc              {- '=>' END Punctuators -}
  | TPlus               {- '+' BEGIN Operators - Arithmetic -}
  | TMinus              {- '-' -}
  | TTimes              {- '*' -}
  | TDiv                {- '/' -}
  | TMod                {- '%' -}
  | TPow                {- '**' -}
  | TEQ                 {- '==' Comparison -}
  | TNEQ                {- '!=' -}
  | TGT                 {- '>' -}
  | TGEQ                {- '>=' -}
  | TLT                 {- '<' -}
  | TLEQ                {- '<=' -}
  | TCMP                {- '<=>' -}
  | TEQQ                {- '===' -}
  | TAsignment          {- '=' Assignment -}
  | TCaret              {- '^' Bitwise-}
  | TAndBit             {- '&' -}
  | TOrBit              {- '|' -}
  | TLShift             {- '<<' -}
  | TRShift             {- '>>' -}
  | TAndOp              {- '&&' Logical -}
  | TOrOp               {- '||' -}
  | TNotRaw             {- '!' Unary -}
  | TNyoro              {- '~' -}
  | TNMatch             {- '!~' Pattern Match -}
  | TMatch              {- '=~' END Operators -}
  deriving (Show, Eq, Ord)
