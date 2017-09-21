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
   _ITEMs_:tList; // список файлов которые ЕЩЁ надо обработать
   _HNDLs_:tList; // список ОБРАБОТЧИКоВ
   _rDATA_:rSrcTree_itmHandler4Build__f8a_Item_prcDATA;
  protected
    function _prc__make_InitFileList_:boolean;
    function _prc__execute_4FileItem_(const srcItem:tSrcTree_fsFILE):boolean;
    function _prc__execute_4FileName_(const srcName:string):boolean; virtual;
  public
    function  Processing:boolean; override;                       // ВЫПОЛНИТЬ обработку
  public
    constructor Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler); override;
    destructor DESTROY; override;
  public
    procedure Handler_ADD(const Handler:tSrcTree_itmHandler_TYPE);
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
   _HNDLs_:=TList.Create;
   _ITEMs_:=TList.Create;
   _rDATA_.FileNames:=TStringList.Create;
end;

destructor tSrcTree_itmHandler4Build__f8a_CORE.DESTROY;
begin
    inherited;
   _rDATA_.FileNames.FREE;
   _ITEMs_.FREE;
   _HNDLs_.FREE;
end;

//------------------------------------------------------------------------------

procedure tSrcTree_itmHandler4Build__f8a_CORE.Handler_ADD(const Handler:tSrcTree_itmHandler_TYPE);
begin
   _HNDLs_.Add(Handler);
end;

//------------------------------------------------------------------------------

// составление ПЕРВИЧНОГО списка файлов .. (ВСЕ файлы)
function tSrcTree_itmHandler4Build__f8a_CORE._prc__make_InitFileList_:boolean;
var tmpPrcDATA:rSrcTree_itmHandler_makeListFsFILE_prcDATA;
begin
    result:=false;
    //---
    tmpPrcDATA.File_LIST:=_ITEMs_;
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
    writeLOG('aaaaaaaaaaaaa '+srcItem.src_abs_PATH);
    for i:=0 to _HNDLs_.Count-1 do begin
       _rDATA_.FileNames.Clear;
        if EXECUTE_4NODE(tSrcTree_itmHandler_TYPE(_HNDLs_.Items[i]), @_rDATA_, srcItem) then begin
            // он что-то там по обрабатывал
            for j:=0 to _rDATA_.FileNames.Count-1 do begin
               //writeLOG(_rDATA_.FileNames.Strings[j]);
              _prc__execute_4FileName_(_rDATA_.FileNames.Strings[j]);
               {todo: проверка что его НЕТ в ДЕРЕВЕ}
               // если его НЕТ в ДЕРЕВЕ => его нет и в списке
               {todo: ДОБАВЛЕНИЕ в список}
            end;
        end;
    end;
end;

function tSrcTree_itmHandler4Build__f8a_CORE._prc__execute_4FileName_(const srcName:string):boolean;
begin
    result:=false;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tSrcTree_itmHandler4Build__f8a_CORE.Processing:boolean;
var srcItem:tSrcTree_fsFILE;
begin
    result:=_prc__make_InitFileList_;
    while result and (_ITEMs_.Count>0) do begin
        // изымаем первый узел
        srcItem:=tSrcTree_fsFILE(_ITEMs_.Items[0]);
       _ITEMs_.Delete(0);
        if (srcItem is tSrcTree_fsFILE) then begin //< это файл, и его МОЖНО открыть
            result:=_prc__execute_4FileItem_(srcItem); //< ОБРАБАТЫВАЕМ
        end;
    end;
end;

end.

