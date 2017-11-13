unit in0k_lazIdeSRC_srcTree_FNK_FILE_FND;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_FILE_FND_abs,
  in0k_lazIdeSRC_srcTree_FNK_FILE_FND_rel;

function SrcTree_fndFile(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;

implementation

function SrcTree_fndFile(const item:tSrcTree_ROOT; const fileName:string):tSrcTree_fsFILE;
var fldr:_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}Assert(Assigned(item)); {$endIf}
    if srcTree_fsFnk_pathIsAbsolute(fileName)
    then result:=SrcTree_fndFileABS(item,fileName)
    else result:=SrcTree_fndFileREL(item,fileName);
end;


end.

