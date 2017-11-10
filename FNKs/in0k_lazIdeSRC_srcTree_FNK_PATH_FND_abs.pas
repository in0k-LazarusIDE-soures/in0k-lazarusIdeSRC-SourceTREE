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

//function SrcTree_fndPathABS(const item:_tSrcTree_item_fsNodeFLDR_; const path:string):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_fndPathABS(const item: tSrcTree_ROOT;             const path:string):_tSrcTree_item_fsNodeFLDR_; overload;

implementation

// спускаемся ВГЛУБЬ до папки (ниже НЕ идем)
// ищем полное соответствие "путей"
function _fndPath_inFirstFLDR_(const item:tSrcTree_item; const path:string; const withRel:boolean):tSrcTree_item;
var tmp:tSrcTree_item;
begin
    result:=nil;
    tmp   :=item.ItemCHLD;
    while Assigned(tmp) do begin
        if tmp is _tSrcTree_item_fsNodeFLDR_ then begin // обработка узла "ДИРЕКТОРИЯ"
            if srcTree_fsFnk_CompareFilenames(path,_tSrcTree_item_fsNodeFLDR_(tmp).fsPath)=0
            then result:=tmp // прямое попадание ... нашли
            else begin
                if withRel and //< просят искать ОТНОСИТЕЛЬНЫЙ тоже
                   srcTree_fsFnk_FileIsInPath(path,_tSrcTree_item_fsNodeFLDR_(tmp).fsPath)
                then begin
                    // это РОДИЕЛЬСКАЯ по отношению к path
                    // будем искать в ней ОТНОСИТЕЛЬНЫЙ путь
                    result:=SrcTree_fndPathREL(_tSrcTree_item_fsNodeFLDR_(tmp),srcTree_fsFnk_CreateRelativePath(path,_tSrcTree_item_fsNodeFLDR_(tmp).fsPath));
                end;
            end;
        end
        else begin // это НЕ "дериктория" => идем ВГЛУБь
            result:=_fndPath_inFirstFLDR_(item,path,withRel);
        end;
        //---
        if Assigned(result) then BREAK; //< типа НаШЛИ
        //-->
        tmp:=tmp.ItemNEXT;
    end;
end;

(*function SrcTree_fndPathABS(const item:_tSrcTree_item_fsNodeFLDR_; const path:string):_tSrcTree_item_fsNodeFLDR_;
var tmpPTH:string;
begin // если `path=item+abc`, то ищем ОТНОСИТЕЛЬНЫЙ путь `abc` в item.
    {$ifOpt D+}Assert(Assigned(item),'`item` IS NIL'); {$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsAbsolute(path),'`path` NOT absolute'); {$endIf}
    {$ifOpt D+}Assert(not srcTree_fsFnk_endsWithDirectorySeparator(path),'`path` ends with `DirectorySeparator`'); {$endIf}
    result:=nil;
    tmpPTH:=item.fsPath;
    if srcTree_fsFnk_CompareFilenames(path,tmpPTH)=0 then begin
        result:=item; // полное совпадение имен с
    end
   else
    if srcTree_fsFnk_FileIsInPath(path,tmpPTH) then begin
        tmpPTH:=srcTree_fsFnk_CreateRelativePath(path,tmpPTH);
        result:=SrcTree_fndPathREL(item,tmpPTH);
    end;
end;*)

// ищем ПОЛНОЕ совпаление по имени
function SrcTree_fndPathABS(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}Assert(Assigned(item),'`item` IS NIL'); {$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsAbsolute(path),'`path` NOT absolute'); {$endIf}
    {$ifOpt D+}Assert(not srcTree_fsFnk_endsWithDirectorySeparator(path),'`path` ends with `DirectorySeparator`'); {$endIf}
    // в лоб ... по ВСЕМ первым папкам ... на ПОЛНОЕ соответствие
    result:=_tSrcTree_item_fsNodeFLDR_(_fndPath_inFirstFLDR_(item,path,false));
    if not Assigned(result) then begin
        // ищем относительно (внутри) ПЕРВЫХ папок
        result:=_tSrcTree_item_fsNodeFLDR_(_fndPath_inFirstFLDR_(item,path,TRUE));
    end;
end;

end.

