unit in0k_lazIdeSRC_srcTree_FNK_PATH_GET_abs;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
  in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel,
  in0k_lazIdeSRC_srcTree_FNK_PATH_FND_abs;

type

  {todo: rename}
  fSrcTree_crtAbsPATH_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR;
  //nSrcTree_crtRelPATH_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR is nested;
  mSrcTree_crtAbsPATH_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR of object;

  function SrcTree_getAbsPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:fSrcTree_crtAbsPATH_callBACK):tSrcTree_fsFLDR; overload;
  //function SrcTree_getAbsPATH(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFnc:mSrcTree_crtAbsPATH_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;


  //function SrcTree_getAbsPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:fSrcTree_crtAbsPATH_callBACK):tSrcTree_fsFLDR; overload;
  //function SrcTree_getAbsPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:nSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsNodeFLDR; overload;
  //function SrcTree_getAbsPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:mSrcTree_crtAbsPATH_callBACK):tSrcTree_fsFLDR; overload;
  function SrcTree_getAbsPATH(const item:tSrcTree_ROOT; const path:string):tSrcTree_fsFLDR;

implementation

function SrcTree_getAbsPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:fSrcTree_crtAbsPATH_callBACK):tSrcTree_fsFLDR;
begin
    {$ifOpt D+}Assert(Assigned(item),'item');{$endIf}
    result:=tSrcTree_fsFLDR(SrcTree_fndPathABS(item,path));
    if not Assigned(result) then begin
        // проверим БАЗОВУЮ ... может в ней искать нада
        result:=tSrcTree_fsFLDR(_tSrcTree_item_fsNodeFLDR_(SrcTree_fndBaseDIR(item)));
        if Assigned(Result) and (srcTree_fsFnk_FileIsInPath(path,tSrcTree_BASE(_tSrcTree_item_fsNodeFLDR_(result)).fsPath))
        then begin // ну точно ... в ней надо
            result:=tSrcTree_fsFLDR(SrcTree_getRelPATH(tSrcTree_BASE(_tSrcTree_item_fsNodeFLDR_(result)), srcTree_fsFnk_CreateRelativePath(path,tSrcTree_BASE(_tSrcTree_item_fsNodeFLDR_(result)).fsPath),crtFnc));
        end;
        if not Assigned(result) then begin
            // таки НАДО создавать ... и вставлять ПРЯМО в КОРЕНЬ !!!
            result:=crtFnc(path);
            SrcTree_insert_ChldLast(item,result);
        end;
     end;
end;

{/$I in0k_lazIdeSRC_srcTree_FNK_getRelPATH.inc}

{function SrcTree_getAbsPATH(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFnc:mSrcTree_crtAbsPATH_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_getRelPATH.inc}
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(*
function SrcTree_getAbsPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:fSrcTree_crtAbsPATH_callBACK):tSrcTree_fsFLDR;
begin
    {$ifOpt D+}Assert(Assigned(SrcTree_fndBaseDIR(item)),'BaseDIR NOT found');{$endIf}
    result:=tSrcTree_fsFLDR(SrcTree_getAbsPATH(SrcTree_fndBaseDIR(item),path,crtFnc));
end;

function SrcTree_getAbsPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:mSrcTree_crtAbsPATH_callBACK):tSrcTree_fsFLDR;
begin
    {$ifOpt D+}Assert(Assigned(SrcTree_fndBaseDIR(item)),'BaseDIR NOT found');{$endIf}
    result:=tSrcTree_fsFLDR(SrcTree_getAbsPATH(SrcTree_fndBaseDIR(item),path,crtFnc));
end;
*)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _crt_relPATH_callBACK_(const relFolderName:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(srcTree_fsFnk_ChompPathDelim(relFolderName));
end;

function SrcTree_getAbsPATH(const item:tSrcTree_ROOT; const path:string):tSrcTree_fsFLDR;
begin
    result:=SrcTree_getAbsPATH(item,path,@_crt_relPATH_callBACK_);
end;

end.

