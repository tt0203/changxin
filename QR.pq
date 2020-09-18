let
fx=(x)=>Table.FromRows({{"data:image/jpeg;base64,"&Binary.ToText(Web.Contents("http://qr.liantu.com/api.php?text="&x))}})
in
fx
