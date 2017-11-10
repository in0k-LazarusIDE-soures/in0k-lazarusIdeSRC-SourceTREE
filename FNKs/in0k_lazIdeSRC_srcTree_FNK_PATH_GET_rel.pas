unit in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //---
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel;

type

  {todo: rename}
  fSrcTree_crtRelPATH_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR;
  //nSrcTree_crtRelPATH_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR is nested;
  mSrcTree_crtRelPATH_callBACK=function(const relFolderName:string):tSrcTree_fsFLDR of object;

  function SrcTree_getRelPATH(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFnc:fSrcTree_crtRelPATH_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
  function SrcTree_getRelPATH(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFnc:mSrcTree_crtRelPATH_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;


  function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:fSrcTree_crtRelPATH_callBACK):tSrcTree_fsFLDR; overload;
  function SrcTree_getRelPATH(const item:tSrcTree_BASE; const path:string; const crtFnc:fSrcTree_crtRelPATH_callBACK):tSrcTree_fsFLDR; overload;
  //function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:nSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsNodeFLDR; overload;
  function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:mSrcTree_crtRelPATH_callBACK):tSrcTree_fsFLDR; overload;
  function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const path:string):tSrcTree_fsFLDR;

implementation




function SrcTree_getRelPATH(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFnc:fSrcTree_crtRelPATH_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_getRelPATH.inc}

function SrcTree_getRelPATH(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFnc:mSrcTree_crtRelPATH_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_getRelPATH.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function SrcTree_getRelPATH(const item:tSrcTree_BASE; const path:string; const crtFnc:fSrcTree_crtRelPATH_callBACK):tSrcTree_fsFLDR;
begin
    {$ifOpt D+}Assert(Assigned(item),'BaseDIR NOT found');{$endIf}
    result:=tSrcTree_fsFLDR(SrcTree_getRelPATH(_tSrcTree_item_fsNodeFLDR_(item),path,crtFnc));
end;

function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:fSrcTree_crtRelPATH_callBACK):tSrcTree_fsFLDR;
begin
    {$ifOpt D+}Assert(Assigned(SrcTree_fndBaseDIR(item)),'BaseDIR NOT found');{$endIf}
    result:=tSrcTree_fsFLDR(SrcTree_getRelPATH(SrcTree_fndBaseDIR(item),path,crtFnc));
end;



function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const path:string; const crtFnc:mSrcTree_crtRelPATH_callBACK):tSrcTree_fsFLDR;
begin
    {$ifOpt D+}Assert(Assigned(SrcTree_fndBaseDIR(item)),'BaseDIR NOT found');{$endIf}
    result:=tSrcTree_fsFLDR(SrcTree_getRelPATH(SrcTree_fndBaseDIR(item),path,crtFnc));
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _crt_relPATH_callBACK_(const relFolderName:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(srcTree_fsFnk_ChompPathDelim(relFolderName));
end;

function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const path:string):tSrcTree_fsFLDR;
begin
    result:=SrcTree_getRelPATH(item,path,@_crt_relPATH_callBACK_);
end;

end.
