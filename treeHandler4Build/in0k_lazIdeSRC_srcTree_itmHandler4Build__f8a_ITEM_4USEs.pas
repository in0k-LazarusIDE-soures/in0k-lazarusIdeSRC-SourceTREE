unit in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4USEs;

{$mode objfpc}{$H+}

interface

uses
  Classes,


  CodeCache,

  in0k_lazIdeSRC_srcTree_CORE_item,

  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_CORE;

type

 tSrcTree_itmHandler4Build__f8a_Item_4USEs=class(tSrcTree_itmHandler4Build__f8a_Item)
  protected
    function _prc_possible_(const item:tSrcTree_item):boolean; override;
    function _prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean; override;
  end;

implementation

function tSrcTree_itmHandler4Build__f8a_Item_4USEs._prc_possible_(const item:tSrcTree_item):boolean;
begin
    item.
end.

end.

