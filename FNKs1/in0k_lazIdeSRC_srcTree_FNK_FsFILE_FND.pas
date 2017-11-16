unit in0k_lazIdeSRC_srcTree_FNK_fsFILE_FND;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_fnd_ABS,
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_fnd_REL;

function SrcTree_fndFsFile(const item:tSrcTree_ROOT; const fileName:string):_tSrcTree_item_fsNodeFILE_;

implementation

function SrcTree_fndFsFile(const item:tSrcTree_ROOT; const fileName:string):_tSrcTree_item_fsNodeFILE_;
var fldr:_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}Assert(Assigned(item)); {$endIf}
    if srcTree_fsFnk_pathIsAbsolute(fileName)
    then result:=SrcTree_fndFsFileABS(item,fileName)
    else result:=SrcTree_fndFsFileREL(item,fileName);
end;


end.

