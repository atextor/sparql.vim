" Vim syntax file 
" Language: SPARQL 
" Maintainer: Jeroen Pulles <jeroen.pulles@redslider.net>
" Last Change: 2006 Dec 26
" Remark: This syntax file only supports the query language, 
" not the protocol or result. See reference at 
" http://www.w3.org/TR/rdf-sparql-query/#grammar 

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" A.3 Keywords are matched in a case-insensitive manner. (only keywords)
syntax case ignore
syntax keyword rqKeyword BASE PREFIX SELECT DISTINCT CONSTRUCT DESCRIBE ASK FROM NAMED WHERE ORDER BY ASC DESC LIMIT OFFSET OPTIONAL GRAPH FILTER UNION
syntax keyword rqBuiltinCall str lang REGEX sameTERM langMatches datatype bound isIRI isURI isBlank isLiteral
syntax keyword rqKeyword1_1 MINUS DISTINCT GROUP BY HAVING NOT EXISTS SERVICE AS BINDINGS IF IN BIND COALESCE
" The following list should also contain the CONTAINS keyword. But this trips
" vim up as it's a keyword, and I have no idea how to escape it.
syntax keyword rqBuiltinCall1_1 REPLACE isNumeric IRI BNODE STRDT STRLANG UUID STRUUID STRLEN SUBSTR UCASE LCASE STRSTARTS STRENDS STRBEFORE STRAFTER ENCODE_FOR_URI CONCAT abs round ceil floor RAND now year month day hours minutes seconds timezone tz MD5 SHA1 SHA256 SHA384 SHA512
syntax keyword rqBuiltinAggregate1_1 COUNT MIN MAX SUM AVG GROUP_CONCAT SAMPLE 
syntax case match
" case sensitive: 
syntax keyword rqRdfType a
syntax keyword rqBoolean true false 
syntax keyword Todo TODO FIXME XXX 
" A.4 Comments 
syntax match rqComment /\#.*$/ contains=Todo,rqCodepointEscape 

" A.5 & A.6 Escape sequences  
syntax match rqCodepointEscape /\(\\U\x\{8\}\|\\u\x\{4\}\)/ contained contains=NONE
syntax match rqStringEscape +\\[tnrbf\"']\++ contained contains=NONE

" Strings
" [63], [78], [79], [80], [81]
syntax match rqStringSingle +'\([^\u0027\u005C\u000A\u000D]\|\\[tnrbf\\"']\+\|\\U\x\{8\}\|\\u\x\{4\}\)*'+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax match rqStringDouble +"\([^\u0022\u005C\u000A\u000D]\|\\[tnrbf\\"']\+\|\\U\x\{8\}\|\\u\x\{4\}\)*"+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax region rqStringLongSingle start=+'''+ end=+'''+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax region rqStringLongDouble start=+"""+ end=+"""+ contains=rqStringEscape,rqCodepointEscape,@Spell 
syntax cluster rqString contains=rqStringSingle,rqStringDouble,rqStringLongSingle

" Names 
" [69] Qname
syntax match rqQnamePrefix /\(\w\|\\U\x\{8\}\|\\u\x\{4\}\)\+:/he=e-1 contains=rqCodepointEscape 
" [67] Q_IRI_REF 
syntax match rqQIRIREF /<[^<>'{}|^`\u00-\u20]*>/hs=s+1,he=e-1 contains=rqCodepointEscape 
" [71], [72], [88-90] Variables 
" (JPU: High code points crash my vim, too many character classes SEGV my vim
"  I'll just keep it simple for now: recognize word-class characters plus
"  escapes: )
syntax match rqVar /[?$]\{1\}\(\w\|\\U\x\{8\}\|\\u\x\{4\}\)\+/ contains=rqCodepointEscape 



highlight link rqKeyword Keyword 
highlight link rqKeyword1_1 Keyword 
highlight link rqBuiltinCall Keyword
highlight link rqBuiltinCall1_1 Keyword
highlight link rqBuiltinAggregate1_1 Keyword
highlight link rqVar Identifier 
highlight link rqStringSingle String 
highlight link rqStringLongSingle String 
highlight link rqStringDouble String 
highlight link rqStringLongDouble String 
highlight link rqComment Comment
highlight link rqRdfType Constant 
highlight link rqQIRIREF Constant
highlight link rqBoolean Constant
highlight link rqQnamePrefix Macro
highlight link rqCodepointEscape SpecialChar 
highlight link rqStringEscape SpecialChar 


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sparql_syn_inits")
  if version < 508
    let did_sparql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

"  HiLink mysqlKeyword		 Statement

  delcommand HiLink
endif

let b:current_syntax = "sparql"

