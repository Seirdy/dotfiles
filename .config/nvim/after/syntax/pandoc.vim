hi link pandocAtxHeader markdownH1
hi link pandocSetexHeader markdownH1
syn match pandocSetexHeader /^.\+\n[=]\+$/ contains=pandocEmphasis,pandocStrong,pandocNoFormatted,pandocLaTeXInlineMath,pandocEscapedDollar,@Spell,pandocAmpersandEscape,pandocHeadingRule
syn match pandocSetexHeader /^.\+\n[-]\+$/ contains=pandocEmphasis,pandocStrong,pandocNoFormatted,pandocLaTeXInlineMath,pandocEscapedDollar,@Spell,pandocAmpersandEscape,pandocHeadingRule
syn match pandocHeadingRule "^[=-]\+$"
hi link pandocHeadingRule markdownHeadingRule
hi link pandocAtxStart markdownHeadingDelimiter
" hi link markdownHeadingRule PreProc
" hi link pandocHRule mreProc
