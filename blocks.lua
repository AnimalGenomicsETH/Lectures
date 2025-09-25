if FORMAT:match 'beamer' then
  function Span(el)
    local blocks = { exampleblock=true, definitionblock=true }
    if el.classes[1] == "alert" then
      table.insert(el.content, 1, pandoc.RawInline("latex", "\\alert{"))
      table.insert(el.content, pandoc.RawInline("latex", "}"))
    elseif blocks[el.classes[1]] then
      if el.attributes["title"] == nil then el.attributes["title"] = "" end
      table.insert(el.content, 1, pandoc.RawInline("latex", "\\begin{"..el.classes[1].."}["..el.attributes["title"].."]"))
      table.insert(el.content, pandoc.RawInline("latex", "\\end{"..el.classes[1].."}"))
    end
    return el
  end
return { { Span = Span } }
end
