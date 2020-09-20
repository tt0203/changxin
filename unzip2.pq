let
fx=(ZIPFile) =>
let
//shorthand
    UInt32 = BinaryFormat.ByteOrder(BinaryFormat.UnsignedInteger32,
				    ByteOrder.LittleEndian),
    UInt16 = BinaryFormat.ByteOrder(BinaryFormat.UnsignedInteger16,
				    ByteOrder.LittleEndian),
//Local File Header
    Header = BinaryFormat.Record([
	    	Version 	 	= UInt16,
                Flags 		 	= UInt16,
                Compression      	= UInt16,
                ModTime 	 	= UInt16,
                ModDate 	 	= UInt16,
                CRC32 		 	= UInt32,
                CompressedSize   	= UInt32,
                UncompressedSize 	= UInt32,
                FileNameLen      	= UInt16,
                ExtraFieldLen 	 	= UInt16]),
    FileData = (h)=> BinaryFormat.Record([
                Header           	= h,
                FileName         	= BinaryFormat.Text(h[FileNameLen]),
                ExtraField       	= BinaryFormat.Text(h[ExtraFieldLen]),
                UncompressedData 	= BinaryFormat.Transform(
	    						BinaryFormat.Binary(h[CompressedSize]),
	    						(x) =>  try 
	    								Binary.Buffer(Binary.Decompress(x, Compression.Deflate)) 
	    							otherwise null)]),
//Central Directory
    CentralDirHeader =  BinaryFormat.Record([
                Version			= UInt16,
                VersNeeded 		= UInt16,
                Flags 			= UInt16,
                Compression 		= UInt16,
                ModTime 		= UInt16,
                ModDate 		= UInt16,
                CRC32 			= UInt32,
                CompressedSize 		= UInt32,
                UncompressedSize 	= UInt32,
                FileNameLen 		= UInt16,
                ExtraFieldLen 		= UInt16,
                FileCommLen		= UInt16,
                DiskStart 		= UInt16,
                InternalAttr 		= UInt16,
                ExternalAttr 		= UInt32,
                OffsetOfLocalHeader 	= UInt32]),
    CentralDir = (cdh)=> BinaryFormat.Record([
                 CentralDirHeader 	= cdh,
                 FileName         	= BinaryFormat.Text(cdh[FileNameLen]),
                 ExtraField       	= BinaryFormat.Text(cdh[ExtraFieldLen]),
                 FileComment      	= BinaryFormat.Text(cdh[FileCommLen])]),

// End block of Central Directory 
    EndDirHeader = BinaryFormat.Record([
	    	DiskNumber		= UInt16,
                DiskWCD 		= UInt16,
                DiskEntries		= UInt16,
                TotalEntries 		= UInt16,
                CentDirSize		= UInt32,
                OffsetCDwrtStartDisk	= UInt32,
                CommentLen		= UInt16]),
    EndDir = (edh)=> BinaryFormat.Record([
                 EndDirHeader     	= edh,
                 ZipFileComment   	= BinaryFormat.Text(edh[CommentLen])]),

//Choosing which Zip block type to parse depending on the signature
    SignatureChoice = (x) => 
	    let
               SignatureOptions ={ [sig = 0x04034B50, head = Header,           body = FileData],
                                   [sig = 0x02014B50, head = CentralDirHeader, body = CentralDir],
                                   [sig = 0x06054B50, head = EndDirHeader,     body = EndDir]}
             in  List.First(List.Select(SignatureOptions, each _[sig]=x)),

    ZipPart = BinaryFormat.Choice(UInt32, (_) => 
				  let 
                                      zipPartChoice = SignatureChoice(_) 
                                  in BinaryFormat.Choice(zipPartChoice[head],(z)=>zipPartChoice[body](z),
                                                                        type binary), 
                                  type binary),
    ZipFormat = BinaryFormat.List(ZipPart),
    Entries =  ZipFormat(File.Contents(ZIPFile))
in
    Entries
    in
 fx   
