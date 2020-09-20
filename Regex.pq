let
fx=(text, pattern) => Web.Page("<script>document.write(new RegExp('"& pattern &"').test('"& text &"'))</script>")[Data]{0}[Children]{0}[Children]{1}[Text]{0}
in
fx
