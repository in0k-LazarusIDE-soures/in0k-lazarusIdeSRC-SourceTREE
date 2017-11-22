unit in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_REL;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  //
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_ADD,
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_fnd_REL,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_ADD,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_REL;

function SrcTree_getFsFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}

function SrcTree_getFsFileREL(const item: tSrcTree_fsFLDR;           const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFileREL(const item: tSrcTree_BASE;             const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}

function SrcTree_getFsFileREL(const item: tSrcTree_ROOT;             const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFileREL(const item: tSrcTree_ROOT;             const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFileREL(const item: tSrcTree_ROOT;             const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFileREL(const item: tSrcTree_ROOT;             const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}



implementation

function SrcTree_getFsFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_REL.inc}

function SrcTree_getFsFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_REL.inc}

function SrcTree_getFsFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_REL.inc}

function SrcTree_getFsFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_REL.inc}

//------------------------------------------------------------------------------

function SrcTree_getFsFileREL(const item:tSrcTree_fsFLDR; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
begin
    result:= SrcTree_getFsFileREL(_tSrcTree_item_fsNodeFLDR_(item), path,{fileKind,} crtFILE,crtFLDR);
end;

//------------------------------------------------------------------------------

function SrcTree_getFsFileREL(const item:tSrcTree_BASE; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
begin
    result:= SrcTree_getFsFileREL(_tSrcTree_item_fsNodeFLDR_(item), path,{fileKind,} crtFILE,crtFLDR);
end;

//------------------------------------------------------------------------------

function SrcTree_getFsFileREL(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Relative.');
      Assert(Assigned(crtFILE),'crtFILE Is NIL');
      Assert(Assigned(crtFLDR),'crtFLDR Is NIL');
    {$endIf}
    result:=SrcTree_getFsFileREL(SrcTree_fndBaseDIR(item), path,{fileKind,} crtFILE,crtFLDR);
end;

function SrcTree_getFsFileREL(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Relative.');
      Assert(Assigned(crtFILE),'crtFILE Is NIL');
      Assert(Assigned(crtFLDR),'crtFLDR Is NIL');
    {$endIf}
    result:=SrcTree_getFsFileREL(SrcTree_fndBaseDIR(item), path,{fileKind,} crtFILE,crtFLDR);
end;

function SrcTree_getFsFileREL(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Relative.');
      Assert(Assigned(crtFILE),'crtFILE Is NIL');
      Assert(Assigned(crtFLDR),'crtFLDR Is NIL');
    {$endIf}
    result:=SrcTree_getFsFileREL(SrcTree_fndBaseDIR(item), path,{fileKind,} crtFILE,crtFLDR);
end;

function SrcTree_getFsFileREL(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Relative.');
      Assert(Assigned(crtFILE),'crtFILE Is NIL');
      Assert(Assigned(crtFLDR),'crtFLDR Is NIL');
    {$endIf}
    result:=SrcTree_getFsFileREL(SrcTree_fndBaseDIR(item), path,{fileKind,} crtFILE,crtFLDR);
end;

end.

