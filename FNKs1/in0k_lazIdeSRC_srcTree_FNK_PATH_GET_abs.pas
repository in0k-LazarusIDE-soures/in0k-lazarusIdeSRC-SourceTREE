unit in0k_lazIdeSRC_srcTree_FNK_PATH_GET_abs;

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
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
  in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel,
  in0k_lazIdeSRC_srcTree_FNK_PATH_FND_abs;

type

  fSrcTree_crtFLDR_4PathABS_callBACK=function(const Path:string):tSrcTree_fsFLDR;
  mSrcTree_crtFLDR_4PathABS_callBACK=function(const Path:string):tSrcTree_fsFLDR of object;

  function SrcTree_getPathABS(const item:tSrcTree_ROOT; const Path:string; const crtFnc:fSrcTree_crtFLDR_4PathABS_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
  function SrcTree_getPathABS(const item:tSrcTree_ROOT; const Path:string; const crtFnc:mSrcTree_crtFLDR_4PathABS_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
  //-----
  function SrcTree_getPathABS(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;

implementation

function SrcTree_getPathABS(const item:tSrcTree_ROOT; const Path:string; const crtFnc:fSrcTree_crtFLDR_4PathABS_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_PATH_GET_abs.inc}

function SrcTree_getPathABS(const item:tSrcTree_ROOT; const Path:string; const crtFnc:mSrcTree_crtFLDR_4PathABS_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_PATH_GET_abs.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _crtFLDR_4PathABS_callBACK_(const relFolderName:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(srcTree_fsFnk_ChompPathDelim(relFolderName));
end;

function SrcTree_getPathABS(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    result:=SrcTree_getPathABS(item,path,@_crtFLDR_4PathABS_callBACK_);
end;

end.

