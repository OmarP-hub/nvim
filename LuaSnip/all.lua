return{
  s(
    {
      trig = "hi",
      snippetType = "autosnippet"
    },
    {
      t("Hello, world!")
    }
  ),
  s({trig="env", snippetType="autosnippet"},
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
  )
}
