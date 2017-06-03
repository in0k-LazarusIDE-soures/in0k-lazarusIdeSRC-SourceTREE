unit in0k_lazIdeSRC_srcTree_item_fsFile;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem;

type

 tSrcTree_fsFILE=class(_tSrcTree_item_fsNodeFILE_)
  protected
   _fileType_:TPkgFileType;
  public
    property fileKIND:TPkgFileType read _fileType_;
  public
    constructor Create(const Text:string; const FileType:TPkgFileType); virtual;
    constructor Create(const Text:string); override;
  end;

implementation

constructor tSrcTree_fsFILE.Create(const Text:string);
begin
    Create(Text,pftBinary);
end;

constructor tSrcTree_fsFILE.Create(const Text:string; const FileType:TPkgFileType);
begin
    inherited Create(Text);
   _fileType_:=FileType;
end;

end.

