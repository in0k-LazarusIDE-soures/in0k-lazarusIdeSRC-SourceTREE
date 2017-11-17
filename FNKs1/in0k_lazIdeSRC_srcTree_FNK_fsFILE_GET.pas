unit in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  //
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_item_fsFile,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_ADD,
  //---
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_ADD,
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_REL,
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_ABS;


function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType; const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType; const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType; const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType; const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}

function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}

implementation

function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType; const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET.inc}

function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType; const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET.inc}

function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType; const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET.inc}

function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType; const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET.inc}

//------------------------------------------------------------------------------

function _crtFILE_(const FilePath:string; const FileKind:TPkgFileType):tSrcTree_fsFILE;
begin
    result:=tSrcTree_fsFILE.Create(FilePath,FileKind);
end;

function _crtFLDR_(const FolderPATH:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR.Create(FolderPATH);
end;

function SrcTree_getFsFILE(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType):_tSrcTree_item_fsNodeFILE_;
begin
    result:=SrcTree_getFsFILE(item,path,fileKind, @_crtFILE_,@_crtFLDR_);
end;

end.

