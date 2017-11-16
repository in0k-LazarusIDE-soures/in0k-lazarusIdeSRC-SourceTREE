unit in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_REL;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //---
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_ADD,
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND;

function SrcTree_getFsFldrREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_getFsFldrREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_getFsFldrREL(const item: tSrcTree_BASE;             const path:string; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_getFsFldrREL(const item: tSrcTree_BASE;             const path:string; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_getFsFldrREL(const item: tSrcTree_ROOT;             const path:string; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_getFsFldrREL(const item: tSrcTree_ROOT;             const path:string; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
//
function SrcTree_getFsFldrREL(const item: tSrcTree_ROOT;             const path:string):_tSrcTree_item_fsNodeFLDR_;

implementation

function SrcTree_getFsFldrREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_REL.inc}

function SrcTree_getFsFldrREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_REL.inc}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function SrcTree_getFsFldrREL(const item:tSrcTree_BASE; const path:string; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Absolute.');
      Assert(Assigned(crtFLDR),'crtFLDR Is NIL');
    {$endIf}
    result:=SrcTree_getFsFldrREL(_tSrcTree_item_fsNodeFLDR_(item),path,crtFLDR);
end;

function SrcTree_getFsFldrREL(const item:tSrcTree_BASE; const path:string; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Absolute.');
      Assert(Assigned(crtFLDR),'crtFLDR Is NIL');
    {$endIf}
    result:=SrcTree_getFsFldrREL(_tSrcTree_item_fsNodeFLDR_(item),path,crtFLDR);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function SrcTree_getFsFldrREL(const item:tSrcTree_ROOT; const path:string; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Absolute.');
      Assert(Assigned(crtFLDR),'crtFLDR Is NIL');
    {$endIf}
    result:=SrcTree_getFsFldrREL(SrcTree_fndBaseDIR(item),path,crtFLDR);
end;

function SrcTree_getFsFldrREL(const item:tSrcTree_ROOT; const path:string; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_; overload;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Absolute.');
      Assert(Assigned(crtFLDR),'crtFLDR Is NIL');
    {$endIf}
    result:=SrcTree_getFsFldrREL(SrcTree_fndBaseDIR(item),path,crtFLDR);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _crtFLDR_(const relFolderPATH:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(srcTree_fsFnk_ChompPathDelim(relFolderPATH));
end;

function SrcTree_getFsFldrREL(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    result:=SrcTree_getFsFldrREL(item,path,@_crtFLDR_);
end;

end.
