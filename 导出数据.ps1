$connection = New-Object -TypeName System.Data.OleDb.OleDbConnection
$connection.ConnectionString = "Provider=MSOLAP.5;Data Source=localhost:58899;Initial Catalog=84bf5cbf-5b57-44c7-9260-f8908c0e1121;"
$command = $connection.CreateCommand()
$command.CommandText = "evaluate test1"
#注意中文查询表报错,编码设置问题需要修改下！
$adapter = New-Object -TypeName System.Data.OleDb.OleDbDataAdapter $command
$dataset = New-Object -TypeName System.Data.DataSet
$adapter.SelectCommand.CommandTimeout = 240
$adapter.Fill($dataset)
$dataset.Tables[0] | export-csv 导出.csv -notypeinformation  
#DataSet.Tables[0].Rows[0][1]   DataSet.Tables["tableName"].Rows[0][1]   table.Row[0]["列"].ToString()
#DataSet.Tables[0].Rows.count
$connection.Close()




插入表
dataset.Tables.Add("Categories");
            dataset.Tables[0].Columns.Add("ID", typeof(int));
            dataset.Tables[0].Columns.Add("Categories", typeof(string));
            dataset.Tables[0].Columns.Add("Value", typeof(double));
指定主键
dataset.Tables[1].PrimaryKey = new[] { dataset.Tables["Orders"].Columns["ID"] };

创建关系
dataset.Relations.Add(new DataRelation("r1", dataset.Tables["Categories"].Columns["ID"], dataset.Tables["Orders"].Columns["CategoryID"]));