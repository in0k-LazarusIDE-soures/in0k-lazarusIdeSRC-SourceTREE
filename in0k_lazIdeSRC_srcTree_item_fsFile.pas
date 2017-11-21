unit in0k_lazIdeSRC_srcTree_item_fsFile;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem;

type

 sSrcTree_FileType=TPkgFileType;

 tSrcTree_fsFILE=class(_tSrcTree_item_fsNodeFILE_)
  protected
   _fileType_:TPkgFileType;
  public
    property fileKIND:TPkgFileType read _fileType_;
  public
    constructor Create(const Text:string; const KIND:sSrcTree_FileType); virtual;
    constructor Create(const Text:string); override;
  end;


procedure SrcTree_fsFILE__set_FileKIND(const item:tSrcTree_fsFILE; const value:TPkgFileType);

implementation

constructor tSrcTree_fsFILE.Create(const Text:string; const KIND:sSrcTree_FileType);
begin
    inherited Create(Text);
   _fileType_:=KIND;
end;

constructor tSrcTree_fsFILE.Create(const Text:string);
begin
    Create(Text,pftBinary);
end;

//==============================================================================

procedure SrcTree_fsFILE__set_FileKIND(const item:tSrcTree_fsFILE; const value:TPkgFileType);
begin
   {$ifOpt D+}Assert(Assigned(item));{$endIf}
   item._fileType_:=value;
end;

end.

