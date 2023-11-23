return {
  -- Begin empty environment
  s({trig="bee", snippetType="autosnippet"},
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    )
  ),

  -- Begin align
  s({trig="bsal", snippetType="autosnippet"},
    fmta(
      [[
        \begin{align*}
          <>
        \end{align*}
      ]],
      { i(1) }
    )
  ),
  
  -- integral from 0 to + inf
  s({trig="ipi", snippetType="autosnippet"},
    fmta(
      [[
        \int_0^{+ \infty}<>
      ]],
      { i(1) }
    )
  ),

  -- fraction
  s({trig="bff", snippetType="autosnippet"},
    fmta(
      [[
        \frac{<>}{<>}<>
      ]],
      { i(1),i(2),i(3) }
    )
  ),

  -- display fraction
  s({trig="bdf", snippetType="autosnippet"},
    fmta(
      [[
        \dfrac{<>}{<>}<>
      ]],
      { i(1),i(2),i(3) }
    )
  )
}
