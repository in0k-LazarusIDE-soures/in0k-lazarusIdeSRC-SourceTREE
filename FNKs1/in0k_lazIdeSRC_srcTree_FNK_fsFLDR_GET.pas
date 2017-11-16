unit in0k_lazIdeSRC_srcTree_FNK_fsFLDR_GET;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_ADD,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_REL,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_ABS;


function SrcTree_getFsFLDR(const item:tSrcTree_ROOT; const path:string; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_getFsFLDR(const item:tSrcTree_ROOT; const path:string; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
//
function SrcTree_getFsFLDR(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_; overload;

implementation

function SrcTree_getFsFLDR(const item:tSrcTree_ROOT; const path:string; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
    {$endIf}
    if srcTree_fsFnk_pathIsAbsolute(path)
    then result:=SrcTree_getFsFldrABS(item,path,crtFLDR)
    else result:=SrcTree_getFsFldrREL(item,path,crtFLDR);
end;

function SrcTree_getFsFLDR(const item:tSrcTree_ROOT; const path:string; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
    {$endIf}
    if srcTree_fsFnk_pathIsAbsolute(path)
    then result:=SrcTree_getFsFldrABS(item,path,crtFLDR)
    else result:=SrcTree_getFsFldrREL(item,path,crtFLDR);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _crtFnk_(const path:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(srcTree_fsFnk_ChompPathDelim(path));
end;

function SrcTree_getFsFLDR(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
    {$endIf}
    result:=SrcTree_getFsFLDR(item,path,@_crtFnk_)
end;

end.

