" Vim syntax file
" Language:   mlir
" Maintainer: The MLIR team, http://github.com/tensorflow/mlir/
" Version:      $Revision$
" Some parts adapted from the LLVM vim syntax file.

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

" Types.
"
syn keyword mlirType index f16 f32 f64 f80 f128 bf16 tf32 complex none tuple
" Signless integer types.
syn match mlirType /\<i\d\+\>/
" Unsigned integer types.
syn match mlirType /\<ui\d\+\>/
" Signed integer types.
syn match mlirType /\<si\d\+\>/

" Elemental types inside memref, tensor, or vector types.
syn match mlirType /x\s*\zs\(bf16\|f16\|f32\|tf32\|f64\|i\d\+\|ui\d\+\|si\d\+\)/

" Shaped types.
syn match mlirType /\<memref\ze\s*<.*>/
syn match mlirType /\<tensor\ze\s*<.*>/
syn match mlirType /\<vector\ze\s*<.*>/

" vector types inside memref or tensor.
syn match mlirType /x\s*\zsvector/

" The dialect and operation name are separate visual levels. This also covers
" operations added by dialects which are absent from the keyword list below.
syn match mlirOperation /\<[A-Za-z_][A-Za-z0-9_]*\.[A-Za-z_][A-Za-z0-9_.]*\>/ contains=mlirDialect
syn match mlirDialect /\<[A-Za-z_][A-Za-z0-9_]*\ze\./ contained

" MLU operations from mlir/Dialect/MLU/IR/MLUOps.td. Keep the general
" operation rule above for new ops; distinguish the main hardware roles.
syn match mlirMluControlOp /\<mlu\.\%(module\|module_terminator\|func\|return\|call\|libdevice\.call\|execute\|yield\|annotate\)\>/ contains=mlirMluDialect
syn match mlirMluMemoryOp /\<mlu\.\%(alloc\|view\|addr\|offset\|stride\|load\|store\|copy\|multicast\|memset\|memref_cast\|gather\|scatter\|broadcast\|pad\|reorder_filter\|transpose\|reshape_and_transpose\)\>/ contains=mlirMluDialect
syn match mlirMluSyncOp /\<mlu\.\%(sync\%(\.[pv]\)\?\|barrier\)\>/ contains=mlirMluDialect
syn match mlirMluAtomicOp /\<mlu\.atomic\.\%(add\|and\|cas\|dec\|exch\|inc\|max\|min\|or\|xor\)\%(\.discrete\)\?\>/ contains=mlirMluDialect
syn match mlirMluDialect /\<mlu\ze\./ contained

" MLU attribute names also have a dotted prefix (including mlu.func).
" Match them in dictionaries so they do not inherit an operation color.
syn match mlirMluAttribute /\%({\|,\)\s*\zsmlu\.[A-Za-z_][A-Za-z0-9_.]*\ze\s*\%(=\|[,}]\)/

" Operations.
" TODO: this list is not exhaustive.
syn keyword mlirOps alloc alloca addf addi and call call_indirect cmpf cmpi divui
syn keyword mlirOps constant dealloc divf dma_start dma_wait dim exp
syn keyword mlirOps getTensor index_cast load log memref_cast
syn keyword mlirOps memref_shape_cast mulf muli negf powf prefetch rsqrt sitofp
syn keyword mlirOps splat store select sqrt subf subi subview tanh
syn keyword mlirOps view reinterpret_cast expand_shape collapse_shape
syn keyword mlirOps sizes strided offset strides stride

" Math ops.
syn match mlirOps /\<math\.erf\>/

" Affine ops.
syn match mlirOps /\<affine\.apply\>/
syn match mlirOps /\<affine\.dma_start\>/
syn match mlirOps /\<affine\.dma_wait\>/
syn match mlirOps /\<affine\.for\>/
syn match mlirOps /\<affine\.if\>/
syn match mlirOps /\<affine\.load\>/
syn match mlirOps /\<affine\.parallel\>/
syn match mlirOps /\<affine\.prefetch\>/
syn match mlirOps /\<affine\.store\>/
syn match mlirOps /\<scf\.execute_region\>/
syn match mlirOps /\<scf\.for\>/
syn match mlirOps /\<scf\.if\>/
syn match mlirOps /\<scf\.yield\>/

" TODO: dialect name prefixed ops (llvm or std).

" Keywords.
syn keyword mlirKeyword
      \ affine_map
      \ affine_set
      \ dense
      \ else
      \ func
      \ module
      \ return
      \ step
      \ to
      \ attributes
      \ builtin
      \ loc
      \ unit

" Attribute dictionary keys, for example {sym_name = "foo"}.
syn match mlirAttributeName /\<[A-Za-z_][A-Za-z0-9_]*\ze\s*=/

" Misc syntax.

syn match   mlirNumber /-\?\<\d\+\>/
" Match numbers even in shaped types.
syn match   mlirNumber /-\?\<\d\+\ze\s*x/
syn match   mlirNumber /x\s*\zs-\?\d\+\ze\s*x/

syn match   mlirFloat  /-\?\<\d\+\.\d*\([eE][+-]\?\d\+\)\?\>/
syn match   mlirFloat  /-\?\<\d\+[eE][+-]\?\d\+\>/
syn match   mlirFloat  /\<0x\x\+\>/
syn keyword mlirBoolean true false
" Spell checking is enabled only in comments by default.
syn match   mlirComment /\/\/.*$/ contains=@Spell
syn region  mlirString start=/"/ skip=/\\"/ end=/"/
" Generic-form operations are quoted, unlike custom-form mlu.copy(...).
syn match   mlirMluQuotedOp /"mlu\.[A-Za-z_][A-Za-z0-9_.]*"\ze\s*(/ contains=mlirMluDialect
syn match   mlirMluAttribute /"mlu\.[A-Za-z_][A-Za-z0-9_.]*"\ze\s*=/
syn match   mlirLabel /[-a-zA-Z$._][-a-zA-Z$._0-9]*:/
" Prefixed identifiers usually used for ssa values and symbols.
syn match   mlirIdentifier /[%@][a-zA-Z$._-][a-zA-Z0-9$._-]*/
syn match   mlirIdentifier /[%@]\d\+\>/
" SSA values and symbols have different roles in IR; give them separate groups.
syn match   mlirSSAValue /%[a-zA-Z$._-][a-zA-Z0-9$._-]*\%([#]\d\+\)\?/
syn match   mlirSSAValue /%\d\+\%([#]\d\+\)\?\>/
syn match   mlirSymbol /@[a-zA-Z$._-][a-zA-Z0-9$._-]*/
syn match   mlirSymbol /@\d\+\>/
" Prefixed identifiers usually used for blocks.
syn match   mlirBlockIdentifier /\^[a-zA-Z$._-][a-zA-Z0-9$._-]*/
syn match   mlirBlockIdentifier /\^\d\+\>/
" Prefixed identifiers usually used for types.
syn match   mlirTypeIdentifier /![a-zA-Z$._-][a-zA-Z0-9$._-]*/
syn match   mlirTypeIdentifier /!\d\+\>/
" Prefixed identifiers usually used for attribute aliases and result numbers.
syn match   mlirAttrIdentifier /#[a-zA-Z$._-][a-zA-Z0-9$._-]*/
syn match   mlirAttrIdentifier /#\d\+\>/

" Syntax-highlight lit test commands and bug numbers.
syn match  mlirSpecialComment /\/\/\s*RUN:.*$/
syn match  mlirSpecialComment /\/\/\s*CHECK:.*$/
syn match  mlirSpecialComment "\v\/\/\s*CHECK-(NEXT|NOT|DAG|SAME|LABEL):.*$"
syn match  mlirSpecialComment /\/\/\s*expected-error.*$/
syn match  mlirSpecialComment /\/\/\s*expected-remark.*$/
syn match  mlirSpecialComment /;\s*XFAIL:.*$/
syn match  mlirSpecialComment /\/\/\s*PR\d*\s*$/
syn match  mlirSpecialComment /\/\/\s*REQUIRES:.*$/

if version >= 508 || !exists("did_c_syn_inits")
  if version < 508
    let did_c_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink mlirType Type
  HiLink mlirOps Statement
  HiLink mlirNumber Number
  HiLink mlirComment Comment
  HiLink mlirString String
  HiLink mlirLabel Label
  HiLink mlirKeyword Keyword
  HiLink mlirBoolean Boolean
  HiLink mlirFloat Float
  HiLink mlirConstant Constant
  HiLink mlirSpecialComment SpecialComment
  HiLink mlirIdentifier Identifier
  HiLink mlirSSAValue Identifier
  HiLink mlirSymbol Constant
  HiLink mlirOperation Function
  HiLink mlirDialect StorageClass
  HiLink mlirBlockIdentifier Label
  HiLink mlirTypeIdentifier Type
  HiLink mlirAttrIdentifier PreProc
  HiLink mlirAttributeName Typedef
  HiLink mlirMluDialect StorageClass
  HiLink mlirMluControlOp Conditional
  HiLink mlirMluMemoryOp Constant
  HiLink mlirMluSyncOp PreProc
  HiLink mlirMluAtomicOp Special
  HiLink mlirMluQuotedOp Function
  HiLink mlirMluAttribute Typedef

  delcommand HiLink
endif

let b:current_syntax = "mlir"
