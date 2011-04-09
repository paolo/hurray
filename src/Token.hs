module Token where

data Token =   {- Reserved Words (http://www.ruby-doc.org/docs/keywords/1.9/) -} 
    TBEGIN     {- BEGIN -}
  | TEND       {- END -}
  | T_ENCODING {- __ENCODING__ -}
  | T_END      {- __END__ -}
  | T_FILE     {- __FILE__ -}
  | T_LINE     {- __LINE__ -}
  | TAlias     {- alias -}
  | TAnd       {- and -}
  | TBegin     {- begin -}
  | TBreak     {- break -}
  | TCase      {- case -}
  | TClass     {- class -}
  | TDef       {- def -}
  | TDefined   {- defined? -}
  | TDo        {- do -}
  | TElse      {- else -}
  | TElsif     {- elsif -}
  | TEnd       {- end -}
  | TEnsure    {- ensure -}
  | TFalse     {- false -}
  | TFor       {- for -}
  | TIf        {- if -}
  | TIn        {- in -}
  | TModule    {- module -}
  | TNext      {- next -}
  | TNil       {- nil -}
  | TNot       {- not -}
  | TOr        {- or -}
  | TRedo      {- redo -}
  | TRescue    {- rescure -}
  | TRetry     {- retry -}
  | TReturn    {- return -}
  | TSelf      {- self -}
  | TSuper     {- super -}
  | TThen      {- then -}
  | TTrue      {- true -}
  | TUndef     {- undef -}
  | TUnless    {- unless -}
  | TUntil     {- until -}
  | TWhen      {- when -}
  | TWhile     {- while -}
  | TYield     {- yield - END of Keyworkds -}
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
  | TNumber Int 
  | TEOF       {- End of File -}
  deriving (Show, Eq)

{-
  data Token = TLine {-- reserved words --}
             | TFile
             | TBeginCaps
             | TEndCaps
             | TAlias
             | TAnd
             | TBegin 
             | TBreak
             | TClass
             | TElsif
             | TElse
             | TEnd
             | TDef
             | TDefined 
             | TDo
             | TDoBlock
             | TDoCond
             | TEnsure
             | TFalse
             | TFor
             | TIf
             | TIfMod
             | TIn
             | TModule
             | TCase
             | TWhen
             | TNext
             | TNil
             | TNot
             | TOr
             | TRedo
             | TRescue
             | TRescueMod
             | TReturn
             | TRetry
             | TSelf
             | TSuper
             | TThen
             | TTrue
             | TUndef
             | TUnless
             | TUnlessMod
             | TUntil
             | TUntilMod
             | TYield
             | TWhile
             | TWhileMod
             {-- string constants  --}
             | TPlusRaw      -- '+'
             | TMinusRaw     -- '-'
             | TTimeRaw      -- '*'
             | TDivRaw       -- '/'
             | TModRaw       -- '%'
             | TAsgnRaw      -- '='
             | TColonRaw     -- ':'
             | TSemiColonRaw -- ';'
             | TDotRaw       -- '.'
             | TOrRaw        -- '|'
             | TAndRaw       -- '&'
             | TLFRaw        -- '\n'
             | TLParenRaw    -- '('
             | TRParenRaw    -- ')'
             | TLParen       -- '('
             | TLParenArg    -- '('
             | TLBrackRaw    -- '['
             | TRBrackRaw    -- ']'
             | TLBrack       -- '['
             | TLBraceRaw    -- '{'
             | TRBraceRaw    -- '}'
             | TLBraceArg    -- '{'
             | TLBrace       -- '{'
             | TCommaRaw     -- ','
             | TDollarRaw    -- '$'
             | TBangRaw      -- '!'
             | TNyoroRaw     -- '~'
             | TQuestionRaw  -- '?'
             | THatRaw       -- '^'
             | TLTRaw        -- '<'
             | TGTRaw        -- '>'
             | TLEQ          -- '<='
             | TGEQ          -- '>='
             | TNEQ          -- '!='
             | TEQ           -- '=='
             | TEQQ          -- '==='
             | TCMP          -- '<=>'
             | TColon2       -- '::'
             | TColon3       -- '::'
             | TPow          -- '**'
             | TMatch        -- '=~'
             | TNMatch       -- '!~'
             | TAssoc        -- '=>'
             | TLShift       -- '<<'
             | TRShift       -- '>>'
             | TAndOp        -- '&&'
             | TOrOp         -- '||'
             | TUPlus        -- '+@'
             | TUMinus       -- '-@'
             | TOpAsgn Int
             | TStringBeg
             | TStringEnd
             | TRegexpBeg
             | TRegexpEnd
             | TInteger Node -- NLIT
             | TStringContent Node -- NStr
             | TIdentifier ID
             | TConstant ID
             | TIVar ID
             | TGVar ID
             | TCVar ID
             | TBackRef Node
             | TNthRef Node
             | TASet
             | TARef
             | TEOF
               deriving Show
-}