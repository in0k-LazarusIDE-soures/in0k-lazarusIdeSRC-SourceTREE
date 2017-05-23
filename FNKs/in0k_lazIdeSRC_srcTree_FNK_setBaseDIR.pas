unit in0k_lazIdeSRC_srcTree_FNK_setBaseDIR;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_item_CORE,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_getBaseDIR;

function  SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
function  SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;

procedure SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR);
procedure SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string);

implementation

function SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
{$i in0k_lazIdeSRC_srcTree_FNK_setBaseDIR.inc}

function SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
{$i in0k_lazIdeSRC_srcTree_FNK_setBaseDIR.inc}


procedure SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:fSrcTree_getBaseDIR_crtBaseDIR);
begin
    SrcTree_setBaseDIR(item,baseDir,crtFnc);
end;

procedure SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string);
var tmp:tSrcTree_BASE;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    tmp:=SrcTree_getBaseDIR(item);
    SrcTree_re_set_itemTEXT(tmp,baseDir);
end;

end.

