unit in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //---
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND;

type

  {todo: добавить методы для nested}
  //nSrcTree_crtRelPATH_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR is nested;
  fSrcTree_crtFLDR_4PathREL_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR;
  mSrcTree_crtFLDR_4PathREL_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR of object;

  function SrcTree_getPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFnc:fSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
  function SrcTree_getPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFnc:mSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;

  function SrcTree_getPathREL(const item:tSrcTree_BASE; const path:string; const crtFnc:fSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
  function SrcTree_getPathREL(const item:tSrcTree_BASE; const path:string; const crtFnc:mSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;

  function SrcTree_getPathREL(const item:tSrcTree_ROOT; const path:string; const crtFnc:fSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
  function SrcTree_getPathREL(const item:tSrcTree_ROOT; const path:string; const crtFnc:mSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;

  function SrcTree_getPathREL(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;

implementation

function SrcTree_getPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFnc:fSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel.inc}

function SrcTree_getPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFnc:mSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function SrcTree_getPathREL(const item:tSrcTree_BASE; const path:string; const crtFnc:fSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Absolute.');
      Assert(Assigned(crtFnc),'crtFnc Is NIL');
    {$endIf}
    result:=SrcTree_getPathREL(_tSrcTree_item_fsNodeFLDR_(item),path,crtFnc);
end;

function SrcTree_getPathREL(const item:tSrcTree_BASE; const path:string; const crtFnc:mSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Absolute.');
      Assert(Assigned(crtFnc),'crtFnc Is NIL');
    {$endIf}
    result:=SrcTree_getPathREL(_tSrcTree_item_fsNodeFLDR_(item),path,crtFnc);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function SrcTree_getPathREL(const item:tSrcTree_ROOT; const path:string; const crtFnc:fSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Absolute.');
      Assert(Assigned(crtFnc),'crtFnc Is NIL');
    {$endIf}
    result:=SrcTree_getPathREL(SrcTree_fndBaseDIR(item),path,crtFnc);
end;

function SrcTree_getPathREL(const item:tSrcTree_ROOT; const path:string; const crtFnc:mSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Absolute.');
      Assert(Assigned(crtFnc),'crtFnc Is NIL');
    {$endIf}
    result:=SrcTree_getPathREL(SrcTree_fndBaseDIR(item),path,crtFnc);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _crt_relPATH_callBACK_(const relFolderName:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(srcTree_fsFnk_ChompPathDelim(relFolderName));
end;

function SrcTree_getPathREL(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    result:=SrcTree_getPathREL(item,path,@_crt_relPATH_callBACK_);
end;

end.
