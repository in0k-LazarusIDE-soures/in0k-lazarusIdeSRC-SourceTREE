unit srcTree_handler_CORE_makeListFsFILE;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  //---
  PackageIntf,
  //---
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  srcTree_handler_CORE_makeLIST;

type //< данные по обработке

 pSrcTree_itmHandler_makeListFsFILE_prcDATA=^rSrcTree_itmHandler_makeListFsFILE_prcDATA;
 rSrcTree_itmHandler_makeListFsFILE_prcDATA=record //< данные ДЛЯ обработки
    File_LIST:tList;         // результат поиска
    FileTypes:TPkgFileTypes; // какие именно файлы исчем
  end;

 tSrcTree_itmHandler_makeListFsFILE=class(tSrcTree_itmHandler_makeLIST)
  public
    function prcssdDATA_getLIST:tList; override;
    function Processing_itmUSED(const srcItem:tSrcTree_item):boolean; override;
  end;

implementation

function tSrcTree_itmHandler_makeListFsFILE.prcssdDATA_getLIST:tList;
begin
    {$ifOpt D+}Assert(Assigned(prcssdDATA), self.ClassName+'.prcssdDATA_getLIST'+' : #1'); {$endIf}
    {$ifOpt D+}Assert(Assigned(pSrcTree_itmHandler_makeListFsFILE_prcDATA(prcssdDATA)^.File_LIST), self.ClassName+'.prcssdDATA_getLIST'+' : #2');{$endIf}
    result:=pSrcTree_itmHandler_makeListFsFILE_prcDATA(prcssdDATA)^.File_LIST;
end;

function tSrcTree_itmHandler_makeListFsFILE.Processing_itmUSED(const srcItem:tSrcTree_item):boolean;
begin
    {$ifOpt D+}Assert(Assigned(srcItem), self.ClassName+'.srcItem_USED'+' : srcItem=NIL');{$endIf}
    {$ifOpt D+}Assert(Assigned(prcssdDATA), self.ClassName+'.srcItem_USED'+' : #1');{$endIf}
    result:=false;
    if srcItem is tSrcTree_fsFILE then begin
        if tSrcTree_fsFILE(srcItem).fileKIND in
           pSrcTree_itmHandler_makeListFsFILE_prcDATA(prcssdDATA)^.FileTypes
        then begin
            result:=TRUE;
        end;
    end
end;

end.

