let
fx=(uri,message)=>Json.Document(Web.Contents(uri,[Headers=[#"Content-Type"="application/json"],Content=Json.FromValue([msgtype="text",text=[content=message]])]))
in
fx
