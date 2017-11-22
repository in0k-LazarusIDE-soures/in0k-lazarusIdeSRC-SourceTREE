unit in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_ABS;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  //
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  //---
  in0k_lazIdeSRC_srcTree_item_fsFile,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,

  in0k_lazIdeSRC_srcTree_FNK_fsFILE_ADD,
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_fnd_ABS,

  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_ADD,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_get_ABS;


function SrcTree_getFsFileABS(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFileABS(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFileABS(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
function SrcTree_getFsFileABS(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}

implementation

function SrcTree_getFsFileABS(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_ABS.inc}

function SrcTree_getFsFileABS(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:fSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_ABS.inc}

function SrcTree_getFsFileABS(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:fSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_ABS.inc}

function SrcTree_getFsFileABS(const item:tSrcTree_ROOT; const path:string; {const fileKind:TPkgFileType;} const crtFILE:mSrcTree_crt_FsFILE_callBACK; const crtFLDR:mSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_fsFILE_get_ABS.inc}

end.

