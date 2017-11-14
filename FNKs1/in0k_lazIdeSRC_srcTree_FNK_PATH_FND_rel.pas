unit in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel;

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
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND;

function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_fndPathREL(const item: tSrcTree_fsFLDR;           const path:string):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_fndPathREL(const item: tSrcTree_BASE;             const path:string):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_fndPathREL(const item: tSrcTree_ROOT;             const path:string):_tSrcTree_item_fsNodeFLDR_; overload;

implementation

function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string):_tSrcTree_item_fsNodeFLDR_;
var str:string;
    tmp:tSrcTree_item;
begin {todo: уйти от РЕКУРСИИ?}
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(path),'path Is NOT relative.');
    {$endIf}
    if path='' then result:=item // достигли КОРНЯ
    else begin
        // пытаемся найти родителя
        result:=SrcTree_fndPathREL(item,srcTree_fsFnk_ExtractFileDir(path));
        if Assigned(result) then begin
            // ищем СВОЕ имя среди его детей
            str   :=srcTree_fsFnk_ExtractFileName(path); //< имя, которое мы исчем
            tmp   :=result.ItemCHLD;
            result:=nil;
            while Assigned(tmp) do begin
                if (tmp is _tSrcTree_item_fsNodeFLDR_) and
                   (0=srcTree_fsFnk_CompareFilenames(str,_tSrcTree_item_fsNodeFLDR_(tmp).fsName))
                then begin
                    result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                    BREAK;
                end;
                tmp:=tmp.ItemNEXT;
            end;
        end;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function SrcTree_fndPathREL(const item:tSrcTree_fsFLDR; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(path),'path Is NOT relative.');
    {$endIf}
    result:=SrcTree_fndPathREL(_tSrcTree_item_fsNodeFLDR_(item),path);
end;

function SrcTree_fndPathREL(const item:tSrcTree_BASE; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(path),'path Is NOT relative.');
    {$endIf}
    result:=SrcTree_fndPathREL(_tSrcTree_item_fsNodeFLDR_(item),path);
end;

function SrcTree_fndPathREL(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(path),'path Is NOT relative.');
    {$endIf}
    result:=SrcTree_fndPathREL(SrcTree_fndBaseDIR(item),path);
end;

end.

