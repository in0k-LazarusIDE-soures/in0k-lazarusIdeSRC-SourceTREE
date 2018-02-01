unit in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_CORE;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
    // ЛОКАЛЬНОЕ тестирование
    {$define _localDBG__prc__execute_4FileItem_}
    {.$define _localDBG__file_4Use_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
        sysutils,
     {$endIf}
  Classes,

  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  srcTree_builder_CORE,

        CodeToolManager,

  srcTree_handler4build_CORE,


                                  DefineTemplates,
  PackageIntf,       ProjectIntf,
  CodeCache,   LazIDEIntf, // codetool,

  in0k_lazIdeSRC_srcTree_CORE_item,
  //in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_fsFile,

  in0k_lazIdeSRC_srcTree_CORE_filePkgType_FNK,
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_FND,
  //in0k_lazIdeSRC_srcTree_FNK_PATH_FND,
  in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND,


  srcTree_handler_CORE,
  srcTree_handler_CORE_makeLIST,
  srcTree_handler_CORE_makeListFsFILE,
  srcTree_handler_CORE_fsFile2CodeBUF;



type

eSrcTree_f8a_FileTestMode=(
   eSTf8aFTM__processing, //< тестирование на НЕОБХОДИМОСТЬ дальнейших проверок
   eSTf8aFTM__needAppend, //< тестирование на НЕОБХОДИМОСТЬ добавления в дерево
   eSTf8aFTM__needHandle  //< тестирование на НЕОБХОДИМОСТЬ дальнейшей обработки
   );

mSrcTree_Handler_f8a__testFile=function(const TestMode:eSrcTree_f8a_FileTestMode; const FileName:string):boolean of Object;
fSrcTree_Handler_f8a__testFile=function(const TestMode:eSrcTree_f8a_FileTestMode; const FileName:string):boolean;


type //< парсинг файла и поиск КОНКРЕТНЫХ объектов в нем
 tSrcTree_itmHandler__f8a_Item=class(tSrcTree_itmHandler_fsFile2CodeBUF)
  protected
    function _prc_possible_(const item:tSrcTree_item):boolean; virtual; {$ifOpt D-} abstrust; {$endIf}
    function _prc_4CodeBUF_(const codeBuffer:TCodeBuffer; const filesNames:tStrings):boolean; virtual; {$ifOpt D-} abstrust; {$endIf}
  public
    function  Processing:boolean; override;
  end;

type //< обработчик

 pSrcTree_itmHandler4Build__f8a_Item_prcDATA=^rSrcTree_itmHandler4Build__f8a_Item_prcDATA;
 rSrcTree_itmHandler4Build__f8a_Item_prcDATA=record //< данные ДЛЯ обработки
    FileNames:tStringList; // список найденных ИМЕН файлов
  end;

 tSrcTree_itmHandler__f8a=class(tSrcTree_itmHandler4Build)
  protected
   _HNDLs_:tList; // список ОБРАБОТЧИКоВ
   _ITEMs_:tList; // УНИКАЛЬНЫЙ список файлов которые ЕЩЁ надо обработать
   _rDATA_:rSrcTree_itmHandler4Build__f8a_Item_prcDATA; //< средство общения с ОБРАБОТЧИКАМИ
  private // вызов функций тестирования
   _m_testFile_:mSrcTree_Handler_f8a__testFile;
   _f_testFile_:fSrcTree_Handler_f8a__testFile;
    function _file_xxxxxxxxxx_(const fileName:string; const testMode:eSrcTree_f8a_FileTestMode):boolean;
  protected // тестирование файлов на необходимость ДАЛЬНЕЙШЕЙ обработки
    function _file_processing_(const fileName:string):boolean;
    function _file_needAppend_(const fileName:string):boolean;
    function _file_needHandle_(const fileName:string):boolean;
  protected
    function _prc__make_InitFileList_:boolean;
    function _prc__execute_4FileItem_(const srcItem:tSrcTree_fsFILE):boolean;
  public
    constructor Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler); override;
    destructor DESTROY; override;
  public //< НАПОЛНЕНИЕ обработчиками
    procedure Handler_ADD(const Handler:tSrcTree_itmHandler_TYPE);
  public //< методы ТЕСТИРОВАНИЯ файлов
    property mProcessing_testFile:mSrcTree_Handler_f8a__testFile read _m_testFile_ write _m_testFile_ ;
    property fProcessing_testFile:fSrcTree_Handler_f8a__testFile read _f_testFile_ write _f_testFile_ ;
  public // ВЫПОЛНИТЬ обработку
    function Processing:boolean; override;
  end;

type //< ОБОБЩЕННЫЙЩИЙ обработчик

 tSrcTree_prcHandler__f8a=class(tSrcTree_prcHandler4Build)
  protected
   _Handler_f8a_:tSrcTree_itmHandler__f8a;
    procedure _m_testFile_SET_(const value:mSrcTree_Handler_f8a__testFile);
    function  _m_testFile_GET_:mSrcTree_Handler_f8a__testFile;
    procedure _f_testFile_SET_(const value:fSrcTree_Handler_f8a__testFile);
    function  _f_testFile_GET_:fSrcTree_Handler_f8a__testFile;
  protected
    procedure _EXECUTE_; override;
  public
    constructor Create(const aBUILDer:tSrcTree_Builder_CORE); override;
    destructor DESTROY; override;
  public //< методы ТЕСТИРОВАНИЯ файлов
    property mProcessing_testFile:mSrcTree_Handler_f8a__testFile read _m_testFile_GET_ write _m_testFile_SET_;
    property fProcessing_testFile:fSrcTree_Handler_f8a__testFile read _f_testFile_GET_ write _f_testFile_SET_;
  public //< НАПОЛНЕНИЕ обработчиками
    procedure Handler_ADD(const Handler:tSrcTree_itmHandler_TYPE);
  end;


implementation


{$ifOpt D+}
function tSrcTree_itmHandler__f8a_Item._prc_possible_(const item:tSrcTree_item):boolean;
begin
    Assert(Assigned(item),Self.ClassName+'._prc_possible_: item===NIL');
    result:=FALSE;
end;
{$endif}

{$ifOpt D+}
function tSrcTree_itmHandler__f8a_Item._prc_4CodeBUF_(const codeBuffer:TCodeBuffer; const filesNames:tStrings):boolean;
begin
    Assert(Assigned(codeBuffer),Self.ClassName+'._prc_4CodeBUF_: codeBuffer===NIL');
    Assert(Assigned(filesNames),Self.ClassName+'._prc_4CodeBUF_: filesNames===NIL');
    result:=false;
end;
{$endif}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tSrcTree_itmHandler__f8a_Item.Processing:boolean;
var CodeBuffer:TCodeBuffer;
begin
    result:=FALSE;
    if _prc_possible_(prcssdITEM) then begin //< мы МОЖЕМ его обработать
        CodeBuffer:=_SrcTree_fsFILE__2__codeBUF_(tSrcTree_fsFILE(prcssdITEM));
        if (Assigned(CodeBuffer)) then begin
           _prc_4CodeBUF_(CodeBuffer,pSrcTree_itmHandler4Build__f8a_Item_prcDATA(prcssdDATA)^.FileNames);
            //result:=pSrcTree_itmHandler4Build__f8a_Item_prcDATA(prcssdDATA)^.FileNames.Count>0;
        end;
    end;
    result:=TRUE; {todo: как-то ГЛРОБАЛЬНЫЕ ошибки?}
end;

//==============================================================================

constructor tSrcTree_itmHandler__f8a.Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler);
begin
    inherited Create(Owner,Parent);
   _HNDLs_:=TList.Create;
   _ITEMs_:=TList.Create;
   _rDATA_.FileNames:=TStringList.Create;
end;

destructor tSrcTree_itmHandler__f8a.DESTROY;
begin
    inherited;
   _rDATA_.FileNames.FREE;
   _ITEMs_.FREE;
   _HNDLs_.FREE;
end;

//------------------------------------------------------------------------------

procedure tSrcTree_itmHandler__f8a.Handler_ADD(const Handler:tSrcTree_itmHandler_TYPE);
begin
   _HNDLs_.Add(Handler);
end;

//------------------------------------------------------------------------------

// составление ПЕРВИЧНОГО списка файлов .. (ВСЕ файлы)
function tSrcTree_itmHandler__f8a._prc__make_InitFileList_:boolean;
var tmpPrcDATA:rSrcTree_itmHandler_makeListFsFILE_prcDATA;
begin
    result:=false;
    //---
    tmpPrcDATA.File_LIST:=_ITEMs_;
    tmpPrcDATA.FileTypes:= []; //< типа ВСЕ файлы с исходниками
    //--- ЗАПУСК
    result:=EXECUTE_4TREE(tSrcTree_itmHandler_makeListFsFILE, @tmpPrcDATA);
end;

{todo: ОПИСАТЬ почему список _ITEMs_ остается УНИКАЛЬНЫМ}

// $ret FALSE - критическая ошибка, дальнейшая работа НЕ возможна
function tSrcTree_itmHandler__f8a._prc__execute_4FileItem_(const srcItem:tSrcTree_fsFILE):boolean;
var i:integer;
    j:integer;
var fName: string;
    fType: TPkgFileType;
    fItem:_tSrcTree_item_fsNodeFILE_;
begin
    result:=TRUE;
    //---
    for i:=0 to _HNDLs_.Count-1 do begin // цикл по обработчикам
        // запускаем обработку объекта
       _rDATA_.FileNames.Clear;
        result:=EXECUTE_4NODE(tSrcTree_itmHandler_TYPE(_HNDLs_.Items[i]), @_rDATA_, srcItem);
        // смотрим на её результаты
        if result then begin //< ОБРАБОТКА прошла успешно!
            // _rDATA_.FileNames - список найденных файлов для ПОСЛЕДУЮЩих действий
            for j:=0 to _rDATA_.FileNames.Count-1 do begin
                fName:=_rDATA_.FileNames.Strings[j];
                fItem:= SrcTree_fndFsFile(SrcTree_fndRootFILE(prcssdITEM), fName);
                writeLOG('TTTTTTTTTTTTTTTTT "'+fName+'"');
{01}            if NOT Assigned(fItem) then begin
                    // этого файла еще НЕТ в дереве, думаем что с ним делать
                    if _file_processing_(fName) then begin //< на него НАДО обратить внимание
                        if _file_needAppend_(fName) then begin //< его НАДО добавить
                            fType:=srcTree_ftPkg_FileNameToPkgFileType(fName);
                            fItem:=Builder.Add_FILE(SrcTree_fndRootFILE(prcssdITEM), fName,fType);
                            writeLOG('add by needAppend "'+fName+'"');
                            {todo: дебуг проверка на fItem=nil}
{02}                        if _file_needHandle_(fName) then begin //< его НАДО обрабатывать
                                writeLOG('add by needHandle "'+fName+'"');
                                // в список для обработки добавляем только
                                // НОВЫЕ для дерева файлы,
                                // поэтому сам список ОСТАЕТСЯ уникальным
                               _ITEMs_.Add(fItem);
                            end;
                        end;
                    end;
                end;
            end;
        end
        else BREAK; //< какая-то ГЛОБАЛЬНАЯ ошибка, дальше работать НЕЛЬЗЯ
    end;
end;

{function tSrcTree_itmHandler__f8a._prc__fileName_Need_ADD_(const srcName:string):boolean;
begin
    result:=false;
end;}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// @ret FALSE критическая ошибка
function tSrcTree_itmHandler__f8a.Processing:boolean;
var srcItem:tSrcTree_fsFILE;
begin
    // состявляем список ОБРАБАТЫВАЕМЫХ объектов
    result:=_prc__make_InitFileList_;
    // Пока этот список НЕ ПУСТ, изымаем ПЕРВЫЙ и его обрабатываем
    // (во время обработки список может ПОПОЛНЯТЬСЯ)
    while result and (_ITEMs_.Count>0) do begin
        // изымаем первый узел
        srcItem:=tSrcTree_fsFILE(_ITEMs_.Items[0]);
       _ITEMs_.Delete(0);
        // обрабатываем
        if (srcItem is tSrcTree_fsFILE) then begin //< это файл, и его МОЖНО открыть
            result:=_prc__execute_4FileItem_(srcItem); //< ОБРАБАТЫВАЕМ
        end;
    end;
end;


//------------------------------------------------------------------------------

// Выполнить проверку файла на неободимость дальнейшей обработки
// @prm fileName имя проверяемого файла
// @prm testMode режим проверки
// ---
// если указаны ОБА метода проверки (функция и метод), то они ДОЛЖНЫ вернуть
// ОДИНАКОВЫЙ положительный результат
function tSrcTree_itmHandler__f8a._file_xxxxxxxxxx_(const fileName:string; const testMode:eSrcTree_f8a_FileTestMode):boolean;
begin
    if Assigned(_m_testFile_) or Assigned(_f_testFile_) then begin
        result:=TRUE;
        // проверим МЕТОДОМ
        if result and Assigned(_m_testFile_) then begin
            result:=_m_testFile_(testMode,fileName);
        end;
        // проверим ФУНКЦИЕЙ
        if (not result) and Assigned(_f_testFile_) then begin
            result:=_f_testFile_(testMode,fileName);
        end;
    end
    else result:=FALSE; //< если НЕЧЕМ проверять, значит и НЕ надо
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// файл НЕОБХОДИМО рассмотреть
function tSrcTree_itmHandler__f8a._file_processing_(const fileName:string):boolean;
begin
    result:=_file_xxxxxxxxxx_(fileName,eSTf8aFTM__processing);
end;

// файл НЕОБХОДИМО добавить в дерево
function tSrcTree_itmHandler__f8a._file_needAppend_(const fileName:string):boolean;
begin
    result:=_file_xxxxxxxxxx_(fileName,eSTf8aFTM__needAppend);
end;

// файл НЕОБХОДИМО обработать
function tSrcTree_itmHandler__f8a._file_needHandle_(const fileName:string):boolean;
begin
    result:=_file_xxxxxxxxxx_(fileName,eSTf8aFTM__needHandle);
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

constructor tSrcTree_prcHandler__f8a.Create(const aBUILDer:tSrcTree_Builder_CORE);
begin
    inherited;
   _Handler_f8a_:=tSrcTree_itmHandler__f8a.Create(self,nil);
end;

destructor tSrcTree_prcHandler__f8a.DESTROY;
begin
   _Handler_f8a_.FREE;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tSrcTree_prcHandler__f8a._EXECUTE_;
begin
    EXECUTE_4ROOT(_Handler_f8a_);
end;

//------------------------------------------------------------------------------

procedure tSrcTree_prcHandler__f8a.Handler_ADD(const Handler:tSrcTree_itmHandler_TYPE);
begin
   _Handler_f8a_.Handler_ADD(Handler);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tSrcTree_prcHandler__f8a._m_testFile_SET_(const value:mSrcTree_Handler_f8a__testFile);
begin
   _Handler_f8a_.mProcessing_testFile:=value;
end;

function tSrcTree_prcHandler__f8a._m_testFile_GET_:mSrcTree_Handler_f8a__testFile;
begin
    result:=_Handler_f8a_.mProcessing_testFile;
end;

procedure tSrcTree_prcHandler__f8a._f_testFile_SET_(const value:fSrcTree_Handler_f8a__testFile);
begin
   _Handler_f8a_.fProcessing_testFile:=value;
end;

function tSrcTree_prcHandler__f8a._f_testFile_GET_:fSrcTree_Handler_f8a__testFile;
begin
    result:=_Handler_f8a_.fProcessing_testFile;
end;



(*// исключаем лежащие в исходниках FPC
function tSrcTree_itmHandler__f8a._file_4Use_exclude4FpcSRC(const fileName:string):boolean;
var FPCUnitSet:TFPCUnitSetCache;
begin
    result:=FALSE;
    //---
    FPCUnitSet:=CodeToolBoss.GetUnitSetForDirectory('');
    if Assigned(FPCUnitSet) then begin
        result:=srcTree_fsFnk_FileIsInPath(fileName,FPCUnitSet.FPCSourceDirectory);
    end;
end;*)

(*// исключаем лежащие в пакетах, кроме нашего
function tSrcTree_itmHandler__f8a._file_4Use_exclude4LazPKG(const fileName:string):boolean;
var Owners: TFPList;
    i: Integer;
    o: TObject;
begin
    Owners:=PackageEditingInterface.GetPossibleOwnersOfUnit(fileName,[]);
    if not Assigned(Owners) then begin
        // unit is not directly associated with a project/package
        // maybe the unit was for some reason not added, but is reachable
        // search in all unit paths of all projects/packages
        // Beware: This can lead to false hits
        Owners:=PackageEditingInterface.GetPossibleOwnersOfUnit(fileName,
                       [piosfExcludeOwned,piosfIncludeSourceDirectories]);
    end;
    if not Assigned(Owners) then result:=FALSE
    else begin
        result:=true;
        for i:=0 to Owners.Count-1 do begin
            o:=TObject(Owners[i]);
            {$ifDef _localDBG__file_4Use_}
            if o is TIDEPackage then begin
                DEBUG('{'+self.ClassName+'} '+ TIDEPackage(o).Name +' have "'+fileName+'"');
            end else if o is TLazProject then begin
                DEBUG('{'+self.ClassName+'} '+ TLazProject(o).ProjectInfoFile +' have "'+fileName+'"');
            end;
            {$endIf}
            {if Assigned(o) and (o=tObject(self.LazOBJ)) then begin
                result:=false;
                BREAK
            end; }
        end;
        Owners.Free;
    end;

end; *)

(*function tSrcTree_itmHandler__f8a._file_4Use_(const fileName:string):boolean;
begin
    if _file_4Use_exclude4FpcSRC(fileName) then exit(false);
    if _file_4Use_exclude4LazPKG(fileName) then exit(false);
    //---
    result:=true;
end;*)




end.

