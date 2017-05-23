unit in0k_lazIdeSRC_srcTree_FNK_setMainFILE;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_item_CORE,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_getBaseDIR,
  in0k_lazIdeSRC_srcTree_FNK_getMainFILE;

function SrcTree_setMainFILE(const item:tSrcTree_ROOT; const MainFileNAME:string; const crtFnc:mSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;

implementation

function SrcTree_setMainFILE(const item:tSrcTree_ROOT; const MainFileNAME:string; const crtFnc:mSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:mSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    result:=SrcTree_getMainFILE(item,crtFnc,crtBaseDIR);
    SrcTree_re_set_itemTEXT(result,MainFileNAME);
end;

end.

