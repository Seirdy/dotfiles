syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl
syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl

" Remove the keywords. We'll re-add them below. Use silent in case the group
" doesn't exist.
" silent! syntax clear pythonOperator

" XXX least specific cases at the top, since the match rules seem to be
" cumulative.


" Include the space after “not” – if present – so that “not a” becomes “¬a”.
" also, don't hide “not” behind  ‘¬’ if it is after “is ”.

" Disabled because too small
" syntax match pyOperator '\%(is \)\@<!\<not\%( \|\>\)' conceal cchar=¬
"syntax keyword match Normal not conceal cchar=¬

" Subscripts


" Matches x0 -> x₀ A2 -> A₂ word2 -> word₂
" Use ms=s+1 to avoid concealing the letter before the number
syntax match Normal '\v<[[:alpha:]_]+0>'ms=e conceal cchar=₀
syntax match Normal '\v<[[:alpha:]_]+1>'ms=e conceal cchar=₁
syntax match Normal '\v<[[:alpha:]_]+2>'ms=e conceal cchar=₂
syntax match Normal '\v<[[:alpha:]_]+3>'ms=e conceal cchar=₃
syntax match Normal '\v<[[:alpha:]_]+4>'ms=e conceal cchar=₄
syntax match Normal '\v<[[:alpha:]_]+5>'ms=e conceal cchar=₅
syntax match Normal '\v<[[:alpha:]_]+6>'ms=e conceal cchar=₆
syntax match Normal '\v<[[:alpha:]_]+7>'ms=e conceal cchar=₇
syntax match Normal '\v<[[:alpha:]_]+8>'ms=e conceal cchar=₈
syntax match Normal '\v<[[:alpha:]_]+9>'ms=e conceal cchar=₉

" Numbers
syntax match Normal '\v[^_]\zs_0\ze>' conceal cchar=₀
syntax match Normal '\v[^_]\zs_1\ze>' conceal cchar=₁
syntax match Normal '\v[^_]\zs_2\ze>' conceal cchar=₂
syntax match Normal '\v[^_]\zs_3\ze>' conceal cchar=₃
syntax match Normal '\v[^_]\zs_4\ze>' conceal cchar=₄
syntax match Normal '\v[^_]\zs_5\ze>' conceal cchar=₅
syntax match Normal '\v[^_]\zs_6\ze>' conceal cchar=₆
syntax match Normal '\v[^_]\zs_7\ze>' conceal cchar=₇
syntax match Normal '\v[^_]\zs_8\ze>' conceal cchar=₈
syntax match Normal '\v[^_]\zs_9\ze>' conceal cchar=₉
" Letters
syntax match Normal '\v[^_]\zs_[aA]\ze>' conceal cchar=ₐ
syntax match Normal '\v[^_]\zs_[lL]\ze>' conceal cchar=ₗ
syntax match Normal '\v[^_]\zs_[pP]\ze>' conceal cchar=ₚ
syntax match Normal '\v[^_]\zs_[rR]\ze>' conceal cchar=ᵣ
syntax match Normal '\v[^_]\zs_[sS]\ze>' conceal cchar=ₛ
syntax match Normal '\v[^_]\zs_[uU]\ze>' conceal cchar=ᵤ
syntax match Normal '\v[^_]\zs_[vV]\ze>' conceal cchar=ᵥ
syntax match Normal '\v[^_]\zs_[xX]\ze>' conceal cchar=ₓ
syntax match Normal '\v[^_]\zs_[hH]\ze>' conceal cchar=ₕ
syntax match Normal '\v[^_]\zs_[iI]\ze>' conceal cchar=ᵢ
syntax match Normal '\v[^_]\zs_[jJ]\ze>' conceal cchar=ⱼ
syntax match Normal '\v[^_]\zs_[kK]\ze>' conceal cchar=ₖ
syntax match Normal '\v[^_]\zs_[nN]\ze>' conceal cchar=ₙ
syntax match Normal '\v[^_]\zs_[mM]\ze>' conceal cchar=ₘ
syntax match Normal '\v[^_]\zs_[tT]\ze>' conceal cchar=ₜ

"" " Conceal underscores in numeric literals with commas
"" Disabled because it looks like multiple elements
"" syntax match Constant '\v<\d+\zs_\ze\d+>' conceal cchar=,

"" Conceal things like a_ -> a'
"" Disabled because it's too small to notice
"" syntax match Normal '\v[^_]\zs_\ze>' conceal cchar=′
"" Underscore by itself is not concealed
"syntax match Normal '\v<\zs_\ze>' conceal cchar=_


"" Need to be handled specially for `not in` to work. Order doesn't matter.
"" TODO: Fix
syntax keyword Operator in conceal cchar=∈
"" Disabled because it looks too much like the letter v
"" syntax keyword Normal or conceal cchar=∨
"syntax keyword Normal and conceal cchar=∧


"" syntax match Normal '->' conceal cchar=→  " Handled by Hasklig ligatures
"syntax match Normal '<=' conceal cchar=≤
"syntax match Normal '>=' conceal cchar=≥

"" These two are disabled for illegibility on low-res screens.
"" syntax match Normal '\s@\s'ms=s+1,me=e-1 conceal cchar=⊗
"" syntax match Normal '\s\*\s'ms=s+1,me=e-1 conceal cchar=∙
"" These two are disabled because they can be confused with <- ligature
"" syntax match Normal '\v(\+|-|*|/|\%)@!\=' conceal cchar=←
"" syntax match Normal '\v[^-=+*/]\zs\=\ze[^=]' conceal cchar=←
"" This is disabled because it just looks so ugly in a monospace font.
"" syntax match Normal '\v\=@<!\=\=\=@!' conceal cchar=≝


"" only conceal `==` if alone, to avoid concealing merge conflict markers
"" syntax match Normal '!=' conceal cchar=≠


"syntax match Normal '\v<((math|torch|np|tf|scipy|sp)\.)?ceil>' conceal cchar=⌈
"syntax match Normal '\v<((math|torch|np|tf|scipy|sp)\.)?floor>' conceal cchar=⌊
"syntax match Normal '\v<((math|torch|np|tf|scipy|sp)\.)?sqrt>' conceal cchar=√
"syntax match Normal '\v<((math|torch|np|tf|scipy|sp)\.)?sum>' conceal cchar=∑
"" Disabled because low-res screens can blur this
"" syntax match Normal '\v<((torch|np|tf|scipy|sp)\.)?(eye|identity)>' conceal cchar=𝕀
"" Disabled because it's tiny
"" syntax match Normal '\v<((math|np|scipy|sp)\.)e>' conceal cchar=ℯ
"syntax match Normal '\v<((math|np|scipy|sp)\.)?inf>' conceal cchar=
"syntax match Normal "\v<float('inf')>" conceal cchar=
"syntax match Normal '\v<float("inf")>' conceal cchar=

"syntax match Normal '\v<((math|torch|np|tf|scipy|sp)\.)?pi>' conceal cchar=
"" syntax match Normal '\v<((torch|np|scipy|sp)\.mean)|(tf\.reduce_mean)>' conceal cchar=𝔼


"syntax match Normal '\v\zs ?\*\* ?2\ze>([^.]|$)' conceal cchar=²
"syntax match Normal '\v\zs ?\*\* ?n\ze>([^.]|$)' conceal cchar=ⁿ
"syntax match Normal '\v\zs ?\*\* ?i\ze>([^.]|$)' conceal cchar=ⁱ
"syntax match Normal '\v\zs ?\*\* ?j\ze>([^.]|$)' conceal cchar=ʲ
"syntax match Normal '\v\zs ?\*\* ?k\ze>([^.]|$)' conceal cchar=ᵏ
"syntax match Normal '\v\zs ?\*\* ?t\ze>([^.]|$)' conceal cchar=ᵗ
"syntax match Normal '\v\zs ?\*\* ?x\ze>([^.]|$)' conceal cchar=ˣ
"syntax match Normal '\v\zs ?\*\* ?y\ze>([^.]|$)' conceal cchar=ʸ
"syntax match Normal '\v\zs ?\*\* ?z\ze>([^.]|$)' conceal cchar=ᶻ
"syntax match Normal '\v\zs ?\*\* ?a\ze>([^.]|$)' conceal cchar=ᵃ
"syntax match Normal '\v\zs ?\*\* ?b\ze>([^.]|$)' conceal cchar=ᵇ
"syntax match Normal '\v\zs ?\*\* ?c\ze>([^.]|$)' conceal cchar=ᶜ
"syntax match Normal '\v\zs ?\*\* ?d\ze>([^.]|$)' conceal cchar=ᵈ
"syntax match Normal '\v\zs ?\*\* ?e\ze>([^.]|$)' conceal cchar=ᵉ
"syntax match Normal '\v\zs ?\*\* ?p\ze>([^.]|$)' conceal cchar=ᵖ
"syntax match Normal '\v\zs ?\*\* ?l\ze>([^.]|$)' conceal cchar=ˡ
"syntax match Normal '\v\zs ?\*\* ?m\ze>([^.]|$)' conceal cchar=ᵐ

"" no ending word boundary on parens
"" syntax match Normal '\v\.t\(\)' conceal cchar=ᵀ
"" syntax match Normal '\v\.T>' conceal cchar=ᵀ

"" Disabled because it's tiny
"" syntax match Normal '\v\.inverse\(\)' conceal cchar=⁻

"" Disabled because it's a blob on low-res screens
"" syntax match Normal '\v\.reshape>'ms=s conceal cchar=♚

"" Disabled because they look too much like angle brackets.
"" syntax match Normal '<<' conceal cchar=≺
"" syntax match Normal '>>' conceal cchar=≻

"syntax keyword Normal alpha ALPHA conceal cchar=α
"syntax keyword Normal beta BETA conceal cchar=β
"syntax keyword Normal Gamma conceal cchar=Γ
"syntax keyword Normal gamma GAMMA conceal cchar=γ
"syntax keyword Normal Delta conceal cchar=Δ
"syntax keyword Normal delta DELTA conceal cchar=δ
"syntax keyword Normal epsilon EPSILON conceal cchar=ε
"syntax keyword Normal zeta ZETA conceal cchar=ζ
"syntax keyword Normal eta ETA conceal cchar=η
"syntax keyword Normal Theta conceal cchar=ϴ
"syntax keyword Normal theta THETA conceal cchar=θ
"syntax keyword Normal kappa KAPPA conceal cchar=κ
"" lambda is also a reserved word
"syntax keyword Normal lambda LAMBDA lambda_ _lambda conceal cchar=λ
"syntax keyword Normal mu MU conceal cchar=μ
"syntax keyword Normal nu NU conceal cchar=ν
"syntax keyword Normal Xi conceal cchar=Ξ
"syntax keyword Normal xi XI conceal cchar=ξ
"syntax keyword Normal Pi conceal cchar=Π
"syntax keyword Normal rho RHO conceal cchar=ρ
"syntax keyword Normal sigma SIGMA conceal cchar=σ
"syntax keyword Normal tau TAU conceal cchar=τ
"syntax keyword Normal upsilon UPSILON conceal cchar=υ
"syntax keyword Normal Phi conceal cchar=Φ
"syntax keyword Normal phi PHI conceal cchar=φ
"syntax keyword Normal chi CHI conceal cchar=χ
"syntax keyword Normal Psi conceal cchar=Ψ
"syntax keyword Normal psi PSI conceal cchar=ψ
"syntax keyword Normal Omega conceal cchar=Ω
"syntax keyword Normal omega OMEGA conceal cchar=ω
"syntax keyword Normal nabla NABLA conceal cchar=∇

"" like APL
"" Need to use `syntax match` instead of `syntax keyword` or else keyword takes
"" priority and `range(len...` isn't matched.
"" Disabled because '⍳' Looks like 'l' (lowercase L)
"" syntax match Normal '\v<range>' conceal cchar=⍳
"" syntax match Normal '\v<\zsrange\(len\ze\(' conceal cchar=⍳
"" syntax keyword Normal enumerate conceal cchar=↑


"syntax keyword Constant None conceal cchar=∅
"syntax keyword Constant True conceal cchar=⊤
"syntax keyword Constant False conceal cchar=⊥

"" http://www.fileformat.info/info/unicode/block/geometric_shapes/images.htm
"syntax keyword Keyword break conceal cchar=
"" syntax keyword Keyword continue conceal cchar=↻  " Looks too much like ⥁
"syntax keyword Keyword return conceal cchar=黎
"" These three are too small:
"" syntax keyword Keyword if conceal cchar=▸
"" syntax keyword Keyword elif conceal cchar=▹
"" syntax keyword Keyword else conceal cchar=▪
"" My own additions: logic ops

"syntax keyword Normal import conceal cchar=

"syntax keyword Normal for conceal cchar=∀
"syntax keyword Normal while conceal cchar=⥁

" syntax keyword pythonDef def conceal cchar=
" syntax keyword Statement class conceal cchar=§
"" syntax keyword Keyword assert conceal cchar=‽
"syntax match Keyword 'yield from' conceal cchar=⇄
"syntax keyword Keyword yield conceal cchar=⇇
"" syntax match Normal '\v<self>' conceal cchar=
"" syntax match Normal '\v<self>\.' conceal cchar=

syntax keyword Type Vector conceal cchar=V
syntax match Type '(np|scipy|sp)\.ndarray' conceal cchar=V  " Literally a V
syntax match Type '\vtf\.Tensor' conceal cchar=𝕋
syntax match Type '\vtorch\.[tT]ensor' conceal cchar=𝕋
syntax keyword Type tensor Tensor conceal cchar=𝕋
syntax match Type '\v(torch|np|tf|scipy|sp)\.float(32|64)?' conceal cchar=ℝ
syntax match Type '\v(torch|np|tf|scipy|sp)\.int(32|64)?' conceal cchar=ℤ

"" XXX These have to be after all the float{16,32} stuff to avoid accidental
"" capture. Use @! to ensure that type casts are not concealed, since that's
"" hard to read._
""
"" [^\s)] is to avoid the edge case of (x: int) where the right paren would
"" override the int conceal.
syntax match Type '\v<int(\(|[^\s)\],:])@!' conceal cchar=ℤ
syntax match Type '\v<Integral(\(|[^\s)\],:])@!' conceal cchar=ℤ
syntax match Type '\v<float(\(|[^\s)\],:])@!' conceal cchar=ℝ
syntax match Type '\v<Real(\(|[^\s)\],:])@!' conceal cchar=ℝ
syntax match Type '\v<complex(\(|[^\s)\],:])@!' conceal cchar=ℂ
syntax match Type '\v<Complex(\(|[^\s)\],:])@!' conceal cchar=ℂ
syntax match Type '\v<str(\(|[^\s)\],:])@!' conceal cchar=𝐒
syntax match Type '\v<bool(\(|[^\s)\],:])@!' conceal cchar=𝔹

"" Disabled because it looks like l (lowercase L)
"" syntax match Normal '\v((np|scipy|sp|torch)\.)?arange' conceal cchar=⍳

"syntax keyword Builtin all
"syntax keyword Builtin any conceal cchar=∃

"highlight! link pyBuiltin pyOperator
"highlight! link pyOperator Operator
"highlight! link pyStatement Statement
"highlight! link pyKeyword Keyword
"highlight! link pyComment Comment
"highlight! link pyConstant Constant
"highlight! link pySpecial Special
"highlight! link pyIdentifier Identifier
"highlight! link pyType Type
