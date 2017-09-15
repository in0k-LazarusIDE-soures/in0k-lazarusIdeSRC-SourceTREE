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
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
  in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel;

function SrcTree_fndPathABS(const item:_tSrcTree_item_fsNodeFLDR_; const path:string):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_fndPathABS(const item: tSrcTree_ROOT;             const path:string):_tSrcTree_item_fsNodeFLDR_; overload;




implementation

function SrcTree_fndPathABS(const item:_tSrcTree_item_fsNodeFLDR_; const path:string):_tSrcTree_item_fsNodeFLDR_;
var tmpPTH:string;
begin // если `path=item+abc`, то ищем ОТНОСИТЕЛЬНЫЙ путь `abc` в item.
    {$ifOpt D+}Assert(Assigned(item),'`item` IS NIL'); {$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsAbsolute(path),'`path` NOT absolute'); {$endIf}
    {$ifOpt D+}Assert(not srcTree_fsFnk_endsWithDirectorySeparator(path),'`path` ends with `DirectorySeparator`'); {$endIf}
    result:=nil;
    tmpPTH:=item.src_abs_DirName;
    if srcTree_fsFnk_CompareFilenames(path,tmpPTH)=0 then begin
        result:=item;
    end
   else
    if srcTree_fsFnk_FileIsInPath(path,tmpPTH) then begin
        tmpPTH:=srcTree_fsFnk_CreateRelativePath(path,tmpPTH);
        result:=SrcTree_fndPathREL(item,tmpPTH);
    end;
end;

// ищем ПОЛНОЕ совпаление по имени
function SrcTree_fndPathABS(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
var tmp:tSrcTree_item;
begin
    {$ifOpt D+}Assert(Assigned(item),'`item` IS NIL'); {$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsAbsolute(path),'`path` NOT absolute'); {$endIf}
    {$ifOpt D+}Assert(not srcTree_fsFnk_endsWithDirectorySeparator(path),'`path` ends with `DirectorySeparator`'); {$endIf}
    // сначала проведем поиск в "БАЗОВОЙ Директории"
    result:=SrcTree_fndBaseDIR(item);
    if Assigned(result) then begin
        result:=SrcTree_fndPathABS(result,path);
        if Assigned(result) then EXIT;
    end;
    // проходим по ВСЕМ (кроме tSrcTree_BASE) папкам в `item` и ищем в них
    tmp:=item.ItemCHLD;
    while Assigned(tmp) do begin
        if (tmp is _tSrcTree_item_fsNodeFLDR_) AND not(tmp is tSrcTree_BASE)
        then begin
            result:=SrcTree_fndPathABS(_tSrcTree_item_fsNodeFLDR_(tmp),path);
            if Assigned(result) then BREAK; //< НАШЛИ
        end;
        tmp:=tmp.ItemNEXT;
    end;
end;

end.

