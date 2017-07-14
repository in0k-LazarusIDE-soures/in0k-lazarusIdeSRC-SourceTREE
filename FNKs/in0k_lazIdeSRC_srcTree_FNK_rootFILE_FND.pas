unit in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_Globals;

function SrcTree_fndRootFILE(const item:tSrcTree_item):tSrcTree_ROOT; inline;

implementation

function SrcTree_fndRootFILE(const item:tSrcTree_item):tSrcTree_ROOT;
var tmp:tSrcTree_item;
begin //< оно ДОЛЖНО быть где-то в родителях
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    result:=nil;
    //---
    tmp:=item;
    while Assigned(tmp) do begin
        if tmp is tSrcTree_ROOT then begin
            result:=tSrcTree_ROOT(tmp);
            BREAK;
        end;
        tmp:=tmp.ItemPRNT;
    end;
end;

end.

