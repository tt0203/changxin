let
fx=(text,regex)=>
    Web.Page(
        "<script>
            var x='"&text&"';
            var y=new RegExp('"&regex&"','g');
            var b=x.match(y);
            document.write(b);
        </script>")[Data]{0}[Children]{0}[Children]{1}[Text]{0}
in
fx
