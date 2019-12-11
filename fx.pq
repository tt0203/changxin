let
fx=(x)=>Table.FromRecords(Json.Document(Web.Contents("api.pullword.com/get.php?source="&x&"&param1=0&param2=1&json=1")))
in
fx