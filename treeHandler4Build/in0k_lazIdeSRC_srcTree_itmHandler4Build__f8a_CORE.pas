unit in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_CORE;

{$mode objfpc}{$H+}

interface

uses
  Classes,

  CodeCache,

  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_fsFile,

  srcTree_handler_CORE,
  srcTree_handler_CORE_makeLIST,
  srcTree_handler_CORE_makeListFsFILE,
  srcTree_handler_CORE_fsFile2CodeBUF;


type

 pSrcTree_itmHandler4Build__f8a_Item_prcDATA=^rSrcTree_itmHandler4Build__f8a_Item_prcDATA;
 rSrcTree_itmHandler4Build__f8a_Item_prcDATA=record //< данные ДЛЯ обработки
    FileNames:tStringList; // список найденных ИМЕН файлов
  end;


  // для конкретного вида деятельности
 tSrcTree_itmHandler4Build__f8a_Item=class(tSrcTree_itmHandler_fsFile2CodeBUF)
  protected
   function _prc_possible_(const item:tSrcTree_item):boolean; virtual;
   function _prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean; virtual;
  public
   function Processing:boolean; override;
  end;

  // ОБЩИЙ обработчик
 tSrcTree_itmHandler4Build__f8a_CORE=class(tSrcTree_itmHandler)
  protected
   _fList_:tList; // список файлов которые ЕЩЁ надо обработать
   _fItms_:tList; // список ОБРАБОТЧИКоВ
   _pDATA_:pSrcTree_itmHandler4Build__f8a_Item_prcDATA;
  protected
    function _prc__make_InitFileList_:boolean;
    function _prc__execute_4FileItem_(const srcItem:tSrcTree_fsFILE):boolean;
  public
    function Processing:boolean; override;
  public
    constructor Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler);
  end;

implementation

function tSrcTree_itmHandler4Build__f8a_Item._prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean;
begin
    result:=false;//Names.Count>0;
end;

function tSrcTree_itmHandler4Build__f8a_Item._prc_possible_(const item:tSrcTree_item):boolean;
begin
    result:=FALSE;
end;

function tSrcTree_itmHandler4Build__f8a_Item.Processing:boolean;
var CodeBuffer:TCodeBuffer;
begin
    if _prc_possible_(prcssdITEM) then begin //< мы МОЖЕМ его обработать
        CodeBuffer:=_SrcTree_fsFILE__2__codeBUF_(tSrcTree_fsFILE(prcssdITEM));
        if (Assigned(CodeBuffer)) then begin
           _prc_4CodeBUF_(CodeBuffer,pSrcTree_itmHandler4Build__f8a_Item_prcDATA(prcssdDATA)^.FileNames);
            result:= pSrcTree_itmHandler4Build__f8a_Item_prcDATA(prcssdDATA)^.FileNames.Count>0;
        end;
    end;
end;

//==============================================================================

constructor tSrcTree_itmHandler4Build__f8a_CORE.Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler);
begin
    inherited Create(Owner,Parent);
   _fItms_:=TList.Create;

end;

//------------------------------------------------------------------------------

// составление ПЕРВИЧНОГО списка файлов .. (ВСЕ файлы)
function tSrcTree_itmHandler4Build__f8a_CORE._prc__make_InitFileList_:boolean;
var tmpPrcDATA:rSrcTree_itmHandler_makeListFsFILE_prcDATA;
begin
   _fList_:=TList.Create;
    //---
    tmpPrcDATA.File_LIST:=_fList_;
    tmpPrcDATA.FileTypes:= []; //< типа ВСЕ файлы с исходниками
    //--- ЗАПУСК
    result:=EXECUTE_4TREE(tSrcTree_itmHandler_makeListFsFILE, @tmpPrcDATA);
end;

function tSrcTree_itmHandler4Build__f8a_CORE._prc__execute_4FileItem_(const srcItem:tSrcTree_fsFILE):boolean;
var i:integer;
    j:integer;
begin
    result:=TRUE;
    //---
    for i:=0 to _fItms_.Count-1 do begin
       _pDATA_^.FileNames.Clear;
        if EXECUTE_4NODE(tSrcTree_itmHandler_TYPE(_fItms_.Items[i]), _pDATA_, srcItem) then begin
            // он что-то там по обрабатывал
            for j:=0 to _pDATA_^.FileNames.Count-1 do begin
               {todo: проверка что его НЕТ в ДЕРЕВЕ}
               // если его НЕТ в ДЕРЕВЕ => его нет и в списке
               {todo: ДОБАВЛЕНИЕ в список}
            end;
        end;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tSrcTree_itmHandler4Build__f8a_CORE.Processing:boolean;
var srcItem:tSrcTree_fsFILE;
begin
    //result:=true;
    result:=_prc__make_InitFileList_;
   _pDATA_^.FileNames:=TStringList.Create;
    while result and (_fList_.Count>0) do begin
        // изымаем первый узел
        srcItem:=tSrcTree_fsFILE(_fList_.Items[0]);
       _fList_.Delete(0);
        if (srcItem is tSrcTree_fsFILE) then begin //< это файл, и его МОЖНО открыть
            result:=_prc__execute_4FileItem_(srcItem); //< ОБРАБАТЫВАЕМ
        end;
    end;
   _pDATA_^.FileNames.FREE;
end;

end.

