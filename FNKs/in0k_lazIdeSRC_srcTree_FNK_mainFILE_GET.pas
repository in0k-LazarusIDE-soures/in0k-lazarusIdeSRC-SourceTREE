unit in0k_lazIdeSRC_srcTree_FNK_mainFILE_GET;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_GET,
  in0k_lazIdeSRC_srcTree_FNK_mainFILE_FND;

type // создание ЭКЗеМпЛЯРа "Базовой директории"
  fSrcTree_getMainFILE_crtMainFILE=function(const MainFILE_Name:string):tSrcTree_MAIN;
  mSrcTree_getMainFILE_crtMainFILE=function(const MainFILE_Name:string):tSrcTree_MAIN of object;

// -----

function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:mSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;

implementation

function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
{$I in0k_lazIdeSRC_srcTree_FNK_getMainFILE.inc}

function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:mSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
{$I in0k_lazIdeSRC_srcTree_FNK_getMainFILE.inc}

end.

