unit in0k_lazIdeSRC_srcTree_FNK_fsFLDR_FND;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_fnd_REL,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_fnd_ABS;

function SrcTree_fndFsFLDR(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;

implementation

function SrcTree_fndFsFLDR(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
    {$endIf}
    if srcTree_fsFnk_pathIsAbsolute(path)
    then result:=SrcTree_fndFsFldrABS(item,path)
    else result:=SrcTree_fndFsFldrREL(item,path);
end;

end.

