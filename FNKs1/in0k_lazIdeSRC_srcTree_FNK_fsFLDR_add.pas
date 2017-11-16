unit in0k_lazIdeSRC_srcTree_FNK_fsFLDR_ADD;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_fsFolder;

type

  {todo: добавить методы для nested}
  //nSrcTree_crtFLDR_callBACK=function(const FolderPATH:string):tSrcTree_fsFLDR is nested;
  fSrcTree_crt_FsFLDR_callBACK=function(const FolderPATH:string):tSrcTree_fsFLDR;
  mSrcTree_crt_FsFLDR_callBACK=function(const FolderPATH:string):tSrcTree_fsFLDR of object;

function SrcTree_add_FsFLDR(const item:tSrcTree_item; const path:string; const crtFnc:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_add_FsFLDR(const item:tSrcTree_item; const path:string; const crtFnc:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload; {$ifOpt D-}inline;{$endIf}

implementation

function SrcTree_add_FsFLDR(const item:tSrcTree_item; const path:string; const crtFnc:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$i in0k_lazIdeSRC_srcTree_FNK_fsFLDR_add.inc}

function SrcTree_add_FsFLDR(const item:tSrcTree_item; const path:string; const crtFnc:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$i in0k_lazIdeSRC_srcTree_FNK_fsFLDR_add.inc}

end.

