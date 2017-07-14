unit in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_Globals,
  //---
  in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND;

function SrcTree_fndBaseDIR(const item:tSrcTree_ROOT):tSrcTree_BASE; inline; overload;
function SrcTree_fndBaseDIR(const item:tSrcTree_item):tSrcTree_BASE; inline; overload;

implementation

function SrcTree_fndBaseDIR(const item:tSrcTree_ROOT):tSrcTree_BASE;
var tmp:tSrcTree_item;
begin //< оно ДОЛЖНО быть в корне РЕБЕНКОМ
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    tmp:=item.ItemCHLD;
    while Assigned(tmp) and not (tmp is tSrcTree_BASE) do tmp:=tmp.ItemNEXT;
    result:=tSrcTree_BASE(tmp);
end;

function SrcTree_fndBaseDIR(const item:tSrcTree_item):tSrcTree_BASE;
var tmp:tSrcTree_item;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    result:=SrcTree_fndBaseDIR(SrcTree_fndRootFILE(item));
end;

end.

