#获取SSAS模型服务器地址及端口
$sd = (netstat -ano |findstr (Get-Process msmdsrv).Id)[0].split(" ")[6]
#创建Oledb关于olap的连接
$connection = New-Object -TypeName System.Data.OleDb.OleDbConnection
$connection.ConnectionString = "Provider=MSOLAP.5;Data Source=$sd;Initial Catalog=;"
$command = $connection.CreateCommand()
#定义查询语句，这里可以直接写MDX或者DAX及相关MDV挖掘语句，，，
$command.CommandText = "evaluate test1"
#比如你要获取度量值信息$command.CommandText = "select * FROM `$SYSTEM.MDSCHEMA_MEASURES"
#注意中文查询表报错,编码设置问题需要修改下！
$adapter = New-Object -TypeName System.Data.OleDb.OleDbDataAdapter $command
$dataset = New-Object -TypeName System.Data.DataSet
#设定命令执行超时限制
$adapter.SelectCommand.CommandTimeout = 240
#将数据集读入内存
$adapter.Fill($dataset)
#插入记录
$dataset.Tables[0].Rows.Add("PQ吹水自动化", 100)
#由于模型下表的列名称全部都变为"表[列名]"形式，所以来个批量重命名。
for ($i=0;$i -lt $dataset.Tables[0].Columns.Count;$i++)
{
   $dataset.Tables[0].Columns[$i].ColumnName = $dataSet.Tables[0].Columns[$i].ToString().split("[]")[1]
}
#导出文件中已经插入记录，但PowerBI中未能更新！
$dataset.Tables[0] | export-csv C:\Users\Administrator\Desktop\导出.csv  -encoding utf8 -notypeinformation
$connection.Close()