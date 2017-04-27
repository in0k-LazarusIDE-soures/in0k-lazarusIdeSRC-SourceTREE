unit in0k_lazIdeSRC_srcTree_FNK_fndBaseDIR;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_item_CORE,
  in0k_lazIdeSRC_srcTree_item_Globals;

function SrcTree_fndBaseDIR(const item:tSrcTree_ROOT):tSrcTree_BASE;

implementation

function SrcTree_fndBaseDIR(const item:tSrcTree_ROOT):tSrcTree_BASE;
var tmp:tSrcTree_item;
begin //< оно ДОЛЖНО быть в корне РЕБЕНКОМ
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    tmp:=item.ItemCHLD;
    while Assigned(tmp) and not (tmp is tSrcTree_BASE) do tmp:=tmp.ItemNEXT;
    result:=tSrcTree_BASE(tmp);
end;

end.

