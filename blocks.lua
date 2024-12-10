if FORMAT:match 'beamer' then
    function Span(el)
        if el.classes[1] == "alert" then
            table.insert(el.content, 1, pandoc.RawInline("latex", "\\alert{"))
            table.insert(el.content, pandoc.RawInline("latex", "}"))
        elseif el.classes[1] == "exampleblock" then
	    table.insert(el.content, 1, pandoc.RawInline("latex", "\\begin{"..el.classes[1].."}{}"))
	    table.insert(el.content, pandoc.RawInline("latex", "\\end{"..el.classes[1].."}"))
	end
        return el
    end
    return { { Span = Span } }
end
