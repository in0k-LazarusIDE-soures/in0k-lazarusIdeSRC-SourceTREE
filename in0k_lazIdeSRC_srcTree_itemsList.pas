unit in0k_lazIdeSRC_srcTree_itemsList;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  in0k_lazIdeSRC_srcTree_CORE_item;

type

 tSrcTree_listITEMs=class(TList) {todo: перейти на СОБСТВЕННУЮ реализацию}
  private
    procedure _items_SET_(Idx:Integer; const Value:tSrcTree_item);
    function  _items_GET_(Idx:Integer):tSrcTree_item;
  public
    property Items[Idx:Integer]:tSrcTree_item read _items_GET_ write _items_SET_; default;
    function Add(const item:tSrcTree_item):Integer;
  public
    constructor Create;
  end;


implementation

constructor tSrcTree_listITEMs.Create;
begin
    inherited Create;
end;

//------------------------------------------------------------------------------

procedure tSrcTree_listITEMs._items_SET_(Idx:Integer; const Value:tSrcTree_item);
begin
    Put(Idx,Pointer(Value));
end;

function tSrcTree_listITEMs._items_GET_(Idx:Integer):tSrcTree_item;
begin
    result:=tSrcTree_item(inherited Get(Idx));
end;

//------------------------------------------------------------------------------

function tSrcTree_listITEMs.Add(const item:tSrcTree_item):Integer;
begin
    result:=inherited Add(item);
end;

end.

