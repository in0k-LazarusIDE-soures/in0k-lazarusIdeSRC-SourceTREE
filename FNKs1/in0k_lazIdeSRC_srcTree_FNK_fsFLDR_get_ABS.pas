unit in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_ABS;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_ADD,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_REL,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_fnd_ABS;


function SrcTree_getFsFldrABS(const item:tSrcTree_ROOT; const Path:string; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_getFsFldrABS(const item:tSrcTree_ROOT; const Path:string; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
//-----
function SrcTree_getFsFldrABS(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;

implementation

function SrcTree_getFsFldrABS(const item:tSrcTree_ROOT; const Path:string; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_ABS.inc}

function SrcTree_getFsFldrABS(const item:tSrcTree_ROOT; const Path:string; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_ABS.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _crtFLDR_(const relFolderName:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(srcTree_fsFnk_ChompPathDelim(relFolderName));
end;

function SrcTree_getFsFldrABS(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    result:=SrcTree_getFsFldrABS(item,path,@_crtFLDR_);
end;

end.

