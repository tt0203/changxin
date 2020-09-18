let
fx=(x)=>
Json.Document(Web.Contents("https://1024tools.com/base64",
[Headers=[#"Content-Type"="application/json"],
Content=Json.FromValue([query=x,type="encode",encoding="UTF-8"])]))[result]
in
fx
