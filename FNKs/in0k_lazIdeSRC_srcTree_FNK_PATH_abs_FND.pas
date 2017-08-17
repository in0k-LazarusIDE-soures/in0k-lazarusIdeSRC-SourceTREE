unit in0k_lazIdeSRC_srcTree_FNK_PATH_abs_FND;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_PATH_rel_FND;

function SrcTree_fndPathABS(const item:tSrcTree_ROOT; const folder:string):_tSrcTree_item_fsNodeFLDR_;

implementation

function SrcTree_fndPathABS(const item:tSrcTree_ROOT; const folder:string):_tSrcTree_item_fsNodeFLDR_;
var tmp:tSrcTree_item;
begin
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsAbsolute(folder),'not ASB PATH'); {$endIf}
    result:=nil;
    //---
    tmp:=item.ItemCHLD;
    while Assigned(tmp) do begin
        if tmp is _tSrcTree_item_fsNodeFLDR_ then begin
            if (srcTree_fsFnk_CompareFilenames(folder,_tSrcTree_item_fsNodeFLDR_(tmp).src_abs_PATH)=0)
            or (srcTree_fsFnk_FileIsInPath(folder,_tSrcTree_item_fsNodeFLDR_(tmp).src_abs_PATH))
            then BREAK;
        end;
        tmp:=tmp.ItemNEXT;
    end;
    //---
    if Assigned(tmp) then begin
        result:=SrcTree_fndPathREL(_tSrcTree_item_fsNodeFLDR_(tmp), srcTree_fsFnk_CreateRelativePath(folder,_tSrcTree_item_fsNodeFLDR_(tmp).src_abs_PATH));
    end;
end;

end.

