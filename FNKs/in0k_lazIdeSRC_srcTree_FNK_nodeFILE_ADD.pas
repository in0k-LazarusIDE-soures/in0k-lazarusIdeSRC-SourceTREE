unit in0k_lazIdeSRC_srcTree_FNK_nodeFILE_ADD;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,

  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  //---
  in0k_lazIdeSRC_srcTree_FNK_FILE_FND_rel,
  in0k_lazIdeSRC_srcTree_FNK_PATH_GET_rel;

type // создание ЭКЗеМпЛЯРа "ФАЙЛ"
  fSrcTree_addNodeFILE_crtNodeFILE=function(const fileName:string; const fileKind:TPkgFileType):tSrcTree_fsFILE;
  mSrcTree_addNodeFILE_crtNodeFILE=function(const fileName:string; const fileKind:TPkgFileType):tSrcTree_fsFILE of object;

//---

function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:fSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:fSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFILE_;
function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:mSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:mSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFILE_;

implementation

function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:fSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:fSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_addNodeFILE.inc}

function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:mSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:mSrcTree_crtFLDR_4PathREL_callBACK):_tSrcTree_item_fsNodeFILE_;
{$I in0k_lazIdeSRC_srcTree_FNK_addNodeFILE.inc}

end.

