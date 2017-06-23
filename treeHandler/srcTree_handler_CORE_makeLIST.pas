unit srcTree_handler_CORE_makeLIST;

{$mode objfpc}{$H+}

interface


{$define _DEBUG_}

uses
  Classes,
  //---
  in0k_lazIdeSRC_srcTree_CORE_item,
  srcTree_handler_CORE;

type //<

 tSrcTree_itmHandler_makeLIST=class(tSrcTree_itmHandler)
  public
    function prcssdDATA_getLIST:tList; virtual;
    function Processing_itmUSED(const srcItem:tSrcTree_item):boolean; virtual;
    function Processing:boolean;       override;
  end;

implementation

function tSrcTree_itmHandler_makeLIST.prcssdDATA_getLIST:tList;
begin
    {$ifOpt D+}Assert(Assigned(prcssdDATA), self.ClassName+'.prcssdDATA_getLIST'+' : prcssdDATA=NIL');{$endIf}
    {$ifOpt D+}Assert(tObject(prcssdDATA) is tList, self.ClassName+'.prcssdDATA_getLIST'+' : tObject(prcssdDATA) is NOT tList');{$endIf}
    result:=tList(prcssdDATA)
end;

function tSrcTree_itmHandler_makeLIST.Processing_itmUSED(const srcItem:tSrcTree_item):boolean;
begin
    result:=FALSE;
end;

function tSrcTree_itmHandler_makeLIST.Processing:boolean;
begin
    result:=TRUE;
    //---
    if (prcssdDATA_getLIST.IndexOf(prcssdITEM)<0) //< его еще НЕТ
       and Processing_itmUSED(prcssdITEM)         //< надо использовать
    then prcssdDATA_getLIST.Add(prcssdITEM);      //< добавляем
end;


end.

