module Token where

data Token =   {- Reserved Words (http://www.ruby-doc.org/docs/keywords/1.9/) -} 
    TKeyword
  | TLocalIdent     {- local identifier -}
  | TGlobalIdent    {- global identifier -}
  | TClassIdent     {- class identifier -}
  | TInstanceIdent  {- instance identifier -}
  | TConstantIdent  {- constant identifier -}
  | TMethodIdent    {- method identifier -}
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
  | TEOL                {- '\n' -}
  | TLiteralInt         {- Integer literals - BEGIN Numeric Listerals -}
  | TLiteralStr         {- String literals - BEGIN String Literals -}
  | TBeginStr
  | TEndStr
  | TEOF       {- End of File -}
  deriving (Show, Eq, Ord)
