unit in0k_lazIdeSRC_srcTree_FNK_getBaseDIR;

{$mode objfpc}{$H+}
{.$modeswitch nestedprocvars}

interface

uses
    in0k_lazIdeSRC_srcTree_item_CORE,
    in0k_lazIdeSRC_srcTree_item_Globals,

    in0k_lazIdeSRC_srcTree_FNK_fndBaseDIR,
    LazFileUtils,

  Classes, SysUtils;

type //< создание ЭКЗеМпЛЯРа "Базовой директории"
  {todo: добавить экземпляр nested}
  //nSrcTree_getBaseDIR_crtBaseDIR=function(const BaseDIR_PATH:string):tSrcTree_BASE is nested;
  mSrcTree_getBaseDIR_crtBaseDIR=function(const BaseDIR_PATH:string):tSrcTree_BASE of object;
  fSrcTree_getBaseDIR_crtBaseDIR=function(const BaseDIR_PATH:string):tSrcTree_BASE;

// -----

//function SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:nSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
function SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
function SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
function SrcTree_getBaseDIR(const item:tSrcTree_ROOT):tSrcTree_BASE;

implementation

// просто создаем папку с путем.
// при кастомизации тут момжно выбирать классы
function _getBaseDIR__crt_BaseDIR_(const BaseDIR_PATH:string):tSrcTree_BASE;
begin
    result:=tSrcTree_BASE.Create(ChompPathDelim(BaseDIR_PATH));
end;

//function SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:nSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
//{$i in0k_srcTree_getBaseDIR.inc}

function SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
{$i in0k_lazIdeSRC_srcTree_FNK_getBaseDIR.inc}

function SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
{$i in0k_lazIdeSRC_srcTree_FNK_getBaseDIR.inc}

function SrcTree_getBaseDIR(const item:tSrcTree_ROOT):tSrcTree_BASE;
begin
    result:=SrcTree_getBaseDIR(item,@_getBaseDIR__crt_BaseDIR_);
end;

end.

