unit in0k_lazIdeSRC_srcTree_FNK_PATH_FND_abs;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //---
  in0k_lazIdeSRC_srcTree_FNK_PATH_FND_relin0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel;

function SrcTree_fndPathABS(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;

implementation

// ищем ПОЛНОЕ совпаление по имени
function SrcTree_fndPathABS(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
var tmp:tSrcTree_item;
begin
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsAbsolute(path),'not ASB PATH'); {$endIf}
    {$ifOpt D+}Assert(not srcTree_fsFnk_endPathDelim  (path),'not PATH have EndPathDelim '); {$endIf}
    result:=nil;
    //---
    tmp:=item.ItemCHLD;
    while Assigned(tmp) do begin
        if tmp is _tSrcTree_item_fsNodeFLDR_ then begin
            if (srcTree_fsFnk_CompareFilenames(path,_tSrcTree_item_fsNodeFLDR_(tmp).src_abs_PATH)=0)
            then begin
                result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                BREAK;
            end;
        end;
        tmp:=tmp.ItemNEXT;
    end;
    //---
    {if Assigned(tmp) then begin
        result:=SrcTree_fndPathREL(_tSrcTree_item_fsNodeFLDR_(tmp), srcTree_fsFnk_CreateRelativePath(path,_tSrcTree_item_fsNodeFLDR_(tmp).src_abs_PATH));
    end;}
end;

end.

