unit in0k_lazIdeSRC_srcTree_FNK_PATH_FND;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel,
  in0k_lazIdeSRC_srcTree_FNK_PATH_FND_abs;

function SrcTree_fndPath(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;

implementation

function SrcTree_fndPath(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
var tmp:tSrcTree_item;
begin
    if srcTree_fsFnk_FilenameIsAbsolute(path) then begin
        result:=nil;
        //---
        tmp:=item.ItemCHLD;
        while Assigned(tmp) do begin
            if tmp is _tSrcTree_item_fsNodeFLDR_ then begin
                if (srcTree_fsFnk_CompareFilenames(path,_tSrcTree_item_fsNodeFLDR_(tmp).src_abs_PATH)=0)
                then begin //< нашли ПОЛНОЕ совпадение
                    result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                    BREAK;
                end
               else
                if (srcTree_fsFnk_FileIsInPath(path,_tSrcTree_item_fsNodeFLDR_(tmp).src_abs_PATH)
                then begin //< tmp для нас РОДИТЕЛЬСКАЯ, поищем ВНУТРИ неё
                    result:=SrcTree_fndPathREL(_tSrcTree_item_fsNodeFLDR_(tmp), srcTree_fsFnk_CreateRelativePath(path,_tSrcTree_item_fsNodeFLDR_(tmp).src_abs_PATH));
                    if Assigned(result) then begin
                        BREAK; //< таки НАШЛИ
                    end;
                end;
            end;
            tmp:=tmp.ItemNEXT;
        end;
    end
    else begin //< ищем ОТНОСИТЕЛЬНО базовой директории
        result:=SrcTree_fndPathREL(item,path);
    end;
end;

end.

