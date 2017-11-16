unit in0k_lazIdeSRC_srcTree_FNK_fsFILE_fnd_ABS;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_fnd_ABS,
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_fnd_REL;

function SrcTree_fndFsFileABS(const item:_tSrcTree_item_fsNodeFLDR_; const fileName:string):_tSrcTree_item_fsNodeFILE_;
function SrcTree_fndFsFileABS(const item: tSrcTree_fsFLDR;           const fileName:string):_tSrcTree_item_fsNodeFILE_;
function SrcTree_fndFsFileABS(const item: tSrcTree_ROOT;             const fileName:string):_tSrcTree_item_fsNodeFILE_;

implementation

function SrcTree_fndFsFileABS(const item:_tSrcTree_item_fsNodeFLDR_; const fileName:string):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}Assert(Assigned(item),'item == NIL');{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_pathIsAbsolute(fileName),'not ASB PATH');{$endIf}
    result:=nil;
    if srcTree_fsFnk_FileIsInPath(fileName,item.fsPath) then begin
        result:=SrcTree_fndFsFileREL(item, srcTree_fsFnk_CreateRelativePath(fileName,item.fsPath));
    end;
end;

function SrcTree_fndFsFileABS(const item:tSrcTree_fsFLDR; const fileName:string):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}Assert(Assigned(item),'item == NIL');{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_pathIsAbsolute(fileName),'not ASB PATH');{$endIf}
    result:=SrcTree_fndFsFileABS(_tSrcTree_item_fsNodeFLDR_(item), fileName)
end;

function SrcTree_fndFsFileABS(const item:tSrcTree_ROOT; const fileName:string):_tSrcTree_item_fsNodeFILE_;
var fldr:_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}Assert(srcTree_fsFnk_pathIsAbsolute(fileName),'not ASB PATH');{$endIf}
    result:=nil;
    fldr:=SrcTree_fndFsFldrABS(item, srcTree_fsFnk_ExtractFileDir(fileName));
    if Assigned(fldr) then begin
        result:=SrcTree_fndFsFileREL(fldr, srcTree_fsFnk_CreateRelativePath(fileName,fldr.fsPath));
    end
end;

end.

