unit in0k_lazIdeSRC_srcTree_FNK_PATH_GET;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel,
  in0k_lazIdeSRC_srcTree_FNK_PATH_GET_abs;

type

  {todo: добавить методы для nested}
  //nSrcTree_crtRelPATH_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR is nested;
  fSrcTree_crtFLDR_4PATH_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR;
  mSrcTree_crtFLDR_4PATH_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR of object;

  //----------------------------------------------------------------------------

  function SrcTree_getPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:fSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
  function SrcTree_getPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:mSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;

  function SrcTree_getPATH(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_; overload;

implementation

function SrcTree_getPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:fSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
    {$endIf}
    if srcTree_fsFnk_pathIsAbsolute(path)
    then result:=SrcTree_getPathABS(item,path,crtFnc)
    else result:=SrcTree_getPathREL(item,path,crtFnc);
end;

function SrcTree_getPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:mSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
    {$endIf}
    if srcTree_fsFnk_pathIsAbsolute(path)
    then result:=SrcTree_getPathABS(item,path,crtFnc)
    else result:=SrcTree_getPathREL(item,path,crtFnc);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _crt_relPATH_callBACK_(const path:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(srcTree_fsFnk_ChompPathDelim(path));
end;

function SrcTree_getPATH(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
    {$endIf}
    if srcTree_fsFnk_pathIsAbsolute(path)
    then result:=SrcTree_getPathABS(item,path,@_crt_relPATH_callBACK_)
    else result:=SrcTree_getPathREL(item,path,@_crt_relPATH_callBACK_);
end;

end.

