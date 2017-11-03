unit in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_CORE;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
        sysutils,
     {$endIf}
  Classes,

  PackageIntf,
  CodeCache,

  in0k_lazIdeSRC_srcTree_CORE_item,
  //in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_fsFile,

  in0k_lazIdeSRC_srcTree_CORE_filePkgType_FNK,
  in0k_lazIdeSRC_srcTree_FNK_FILE_FND,
  //in0k_lazIdeSRC_srcTree_FNK_PATH_FND,
  in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND,


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
    //function _prc__fileName_Need_ADD_(const srcName:string):boolean; virtual;
    function _prc__fileName_Need_ADD_(const srcName:string):boolean; virtual;
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
  itm:tSrcTree_fsFILE;
   fn:string;
   ft:TPkgFileType;

begin
    result:=TRUE;
    //---
    for i:=0 to _HNDLs_.Count-1 do begin // цикл по обработчикам
       _rDATA_.FileNames.Clear;
        if EXECUTE_4NODE(tSrcTree_itmHandler_TYPE(_HNDLs_.Items[i]), @_rDATA_, srcItem) then begin
            // он что-то там по обрабатывал
            for j:=0 to _rDATA_.FileNames.Count-1 do begin
                {done: проверка что его НЕТ в ДЕРЕВЕ, ачтоно так?}
                fn :=_rDATA_.FileNames.Strings[j];
                {$ifDef _DEBUG_}
                    DEBUG('{'+self.ClassName+'}'+ 'find File "'+fn+'"');
                {$endIf}
                itm:=SrcTree_fndFile(SrcTree_fndRootFILE(prcssdITEM), fn);
//                {$ifDef _DEBUG_}
//                    DEBUG('{'+self.ClassName+'}'+ 'find File "'+fn+'"');
//                {$endIf}


                {if not Assigned(itm) then begin //< такого у нас еще НЕТ
                    // если его НЕТ в ДЕРЕВЕ => его нет и в списке
                    if _prc__fileName_Need_ADD_(fn) then begin
                        // и его просят добавить
                        {todo: ДОБАВЛЕНИЕ в ДереВО}
                        ft :=srcTree_ftPkg_FileNameToPkgFileType(fn);
                        itm:=Builder.Add_FILE(SrcTree_fndRootFILE(prcssdITEM), fn,ft);
                        {todo: ДОБАВЛЕНИЕ в список}
                        writeLOG('need ADD "'+_rDATA_.FileNames.Strings[j]+'"');
                       _ITEMs_.Add(itm);

                    end;
                end;}
            end;
        end;
    end;
end;

function tSrcTree_itmHandler4Build__f8a_CORE._prc__fileName_Need_ADD_(const srcName:string):boolean;
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

