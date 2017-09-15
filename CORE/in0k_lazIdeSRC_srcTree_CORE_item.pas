unit in0k_lazIdeSRC_srcTree_CORE_item;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

{$ifDef in0k_lazIdeSRC_srcTree___DEBUG}uses in0k_lazIdeSRC_DEBUG;{$endIf}

type

 tSrcTree_item=class
  protected
   _prnt_:tSrcTree_item;
   _next_:tSrcTree_item;
   _chld_:tSrcTree_item;
  protected
    function  _get_chldFrst_:tSrcTree_item;
    function  _get_chldLast_:tSrcTree_item;
  protected
    procedure _ins_itemAfte_(const node:tSrcTree_item);
    procedure _ins_ChldFrst_(const node:tSrcTree_item);
    procedure _ins_ChldLast_(const node:tSrcTree_item);
  protected
   _item_Text_:string;
    function _get_itemText_:string; inline;
    function _get_ItemName_:string; virtual;
    function _get_ItemHint_:string; virtual;
  public //< навигация
    property ItemPRNT:tSrcTree_item read _prnt_;
    property ItemNEXT:tSrcTree_item read _next_;
    property ItemCHLD:tSrcTree_item read _chld_;
  public //< текстовки
    property ItemTEXT:string read _get_itemText_;
    property ItemNAME:string read _get_ItemName_; // название
    property ItemHINT:string read _get_ItemHint_; // описание
  public
    constructor Create(const Text:string); virtual;
    destructor DESTROY; override;
  end;

//<-----------------------------------------------------------------------------
procedure SrcTree_re_set_itemTEXT(const item:tSrcTree_item; const newItemTXT:string);
procedure SrcTree_insert_itemAfte(const item:tSrcTree_item; const insertItem:tSrcTree_item);
procedure SrcTree_insert_ChldFrst(const item:tSrcTree_item; const insertItem:tSrcTree_item);
procedure SrcTree_insert_ChldLast(const item:tSrcTree_item; const insertItem:tSrcTree_item);
procedure SrcTree_cut_From_Parent(const item:tSrcTree_item);

implementation
{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debug_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debug_}
{$endIf}
{%endregion}

constructor tSrcTree_item.Create(const Text:string);
begin
   _item_Text_:=Text;
   _prnt_    :=nil;
   _next_    :=nil;
   _chld_    :=nil;
end;

destructor tSrcTree_item.DESTROY;
var tmp:tSrcTree_item;
begin
    // чистим ДЕТЕЙ
    tmp:=ItemCHLD;
    while Assigned(tmp) do begin
        SrcTree_cut_From_Parent(tmp);
        tmp.FREE;
        //--->
        tmp:=ItemCHLD;
    end;
    // чистим СЕБЯ
   _item_Text_:=''; //< наследие мифов
   _prnt_    :=nil;
   _next_    :=nil;
   _chld_    :=nil;
end;

//------------------------------------------------------------------------------

function tSrcTree_item._get_chldFrst_:tSrcTree_item;
begin
    result:=_chld_;
end;

function tSrcTree_item._get_chldLast_:tSrcTree_item;
begin
    result:=_chld_;
    while Assigned(result) do begin
        if not Assigned(result._next_) then break;
        result:=result._next_;
    end;
end;

//------------------------------------------------------------------------------

procedure tSrcTree_item._ins_itemAfte_(const node:tSrcTree_item);
begin
    {$IfOpt D+}Assert(Assigned(node));{$endIf}
    node._prnt_:=self._prnt_;
    node._next_:=self._next_;
    self._next_:=node;

end;

procedure tSrcTree_item._ins_ChldFrst_(const node:tSrcTree_item);
begin
    {$IfOpt D+}Assert(Assigned(node));{$endIf}
    node._prnt_:=self;
    node._next_:=self._chld_;
    self._chld_:=node;
end;

procedure tSrcTree_item._ins_ChldLast_(const node:tSrcTree_item);
var tmp:tSrcTree_item;
begin
    {$IfOpt D+}Assert(Assigned(node));{$endIf}
    tmp:=_get_chldLast_;
    if Assigned(tmp) then tmp._ins_itemAfte_(node)
    else self._ins_ChldFrst_(node);
end;

//------------------------------------------------------------------------------

function tSrcTree_item._get_ItemText_:string;
begin
    result:=_item_Text_;
end;

function tSrcTree_item._get_ItemName_:string;
begin
    result:=_get_ItemText_;
end;

function tSrcTree_item._get_ItemHint_:string;
begin
    result:='';
end;

//==============================================================================

procedure SrcTree_insert_itemAfte(const item:tSrcTree_item; const insertItem:tSrcTree_item);
begin
    {$IfOpt D+}
        Assert(Assigned(item));
        Assert(Assigned(insertItem));
    {$endIf}
    item._ins_itemAfte_(insertItem);
end;

procedure SrcTree_insert_ChldFrst(const item:tSrcTree_item; const insertItem:tSrcTree_item);
begin
    {$IfOpt D+}
        Assert(Assigned(item));
        Assert(Assigned(insertItem));
    {$endIf}
    item._ins_ChldFrst_(insertItem);
end;

procedure SrcTree_insert_ChldLast(const item:tSrcTree_item; const insertItem:tSrcTree_item);
begin
    {$IfOpt D+}
        Assert(Assigned(item));
        Assert(Assigned(insertItem));
    {$endIf}
    item._ins_ChldLast_(insertItem);
end;

procedure SrcTree_cut_From_Parent(const item:tSrcTree_item);
var tmp:pointer;
begin
    {$IfOpt D+}
        Assert(Assigned(item));
        Assert(Assigned(item.ItemPRNT));
    {$endIf}
    tmp:=@(item.ItemPRNT._chld_);
    while (tSrcTree_item(tmp^)<>item)
    do tmp:=@(tSrcTree_item(tmp^)._next_);
    tSrcTree_item(tmp^):=item.ItemNEXT;
    item._next_:=nil;
end;

//------------------------------------------------------------------------------

// ПЕРЕУСТАНоВИТЬ, значение _item_Text_ ??? почему так, вопрос ^-)
procedure SrcTree_re_set_itemTEXT(const item:tSrcTree_item; const newItemTXT:string);
begin
    {$IfOpt D+}Assert(Assigned(item));{$endIf}
    {$ifdef _debug_}DEBUG('SrcTree_re_set_itemTEXT','"'+item._item_Text_+'"'+'->'+'"'+newItemTXT+'"');{$endIf}
    item._item_Text_:=newItemTXT;
end;

end.

