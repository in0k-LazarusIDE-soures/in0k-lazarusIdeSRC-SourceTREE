unit in0k_lazIdeSRC_srcTree_FNK_absFILE_FND;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_nodeFILE_FND,
  in0k_lazIdeSRC_srcTree_FNK_absPATH_FND;

function SrcTree_fndAbsFILE(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;

implementation

function SrcTree_fndAbsFILE(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;
var fldr:_tSrcTree_item_fsNodeFLDR_;
begin
    result:=nil;
    fldr:=SrcTree_fndAbsPATH(item, srcTree_fsFnk_ExtractFileDir(fileName));
    if Assigned(fldr) then begin
        result:=SrcTree_fndNodeFILE(fldr,fileName);
    end
end;

end.

