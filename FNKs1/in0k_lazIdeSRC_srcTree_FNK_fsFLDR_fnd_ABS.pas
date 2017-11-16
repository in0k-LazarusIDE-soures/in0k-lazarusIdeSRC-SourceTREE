unit in0k_lazIdeSRC_srcTree_FNK_fsFLDR_fnd_ABS;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_fnd_REL;

function SrcTree_fndFsFldrABS(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_; overload;

implementation

// спускаемся ВГЛУБЬ до папки (ниже НЕ идем)
// ищем полное соответствие "путей"
// @prm item    начальная
// @prm path    искомый путь
// @prm withRel провести ОТНОСИТЕЛЬНЫЙ поиск
function _fndPath_inFirstFLDR_(const item:tSrcTree_item; const path:string; const withRel:boolean):tSrcTree_item;
var tmp:tSrcTree_item;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsAbsolute(path),'path Is NOT Absolute.');
    {$endIf}
    result:=nil;
    tmp   :=item.ItemCHLD;
    while Assigned(tmp) do begin
        if tmp is _tSrcTree_item_fsNodeFLDR_ then begin // обработка узла "ДИРЕКТОРИЯ"
            if srcTree_fsFnk_namesIdentical(path,_tSrcTree_item_fsNodeFLDR_(tmp).fsPath)
            then result:=tmp // прямое попадание ... нашли
            else begin
                if withRel and //< просят искать ОТНОСИТЕЛЬНЫЙ тоже
                   srcTree_fsFnk_FileIsInPath(path,_tSrcTree_item_fsNodeFLDR_(tmp).fsPath)
                then begin
                    // это РОДИЕЛЬСКАЯ по отношению к path
                    // будем искать в ней ОТНОСИТЕЛЬНЫЙ путь
                    if tmp is tSrcTree_BASE
                    then result:=SrcTree_fndFsFldrREL(tSrcTree_BASE(tmp),srcTree_fsFnk_CreateRelativePath(path,tSrcTree_BASE(tmp).fsPath))
                   else
                    if tmp is tSrcTree_fsFLDR
                    then result:=SrcTree_fndFsFldrREL(tSrcTree_fsFLDR(tmp),srcTree_fsFnk_CreateRelativePath(path,tSrcTree_fsFLDR(tmp).fsPath));
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

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function SrcTree_fndFsFldrABS(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsAbsolute(path),'path Is NOT Absolute.');
    {$endIf}
    // в лоб ... по ВСЕМ первым папкам ... на ПОЛНОЕ соответствие
    result:=_tSrcTree_item_fsNodeFLDR_(_fndPath_inFirstFLDR_(item,path,false));
    if not Assigned(result) then begin
        // ищем относительно (внутри) ПЕРВЫХ папок
        result:=_tSrcTree_item_fsNodeFLDR_(_fndPath_inFirstFLDR_(item,path,TRUE));
    end;
end;

end.

