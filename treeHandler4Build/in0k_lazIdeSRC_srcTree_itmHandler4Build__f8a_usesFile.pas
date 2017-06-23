unit in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_usesFile;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  //---
  PackageIntf,
  //---
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  srcTree_handler_CORE,
  srcTree_handler_CORE_makeLIST,
  srcTree_handler_CORE_makeListFsFILE,
  srcTree_handler_CORE_fsFile2CodeBUF;

type


 tSrcTree_itmHandler4Build__f8a_usesFile=class(tSrcTree_itmHandler)
  protected
   _fList_:tList; // список файлов которые ЕЩЁ надо обработать
  protected
    function _prc__make_InitFileList_:boolean;
    function _prc__execute_4FileItem_(const srcItem:tSrcTree_fsFILE):boolean;
  public
    function Processing:boolean; override;
  end;


implementation

// составление ПЕРВИЧНОГО списка файлов ..
function tSrcTree_itmHandler4Build__f8a_usesFile._prc__make_InitFileList_:boolean;
var tmpPrcDATA:rSrcTree_itmHandler_makeListFsFILE_prcDATA;
begin
   _fList_:=TList.Create;
    //---
    tmpPrcDATA.File_LIST:=_fList_;
    tmpPrcDATA.FileTypes:= PkgFileRealUnitTypes; //< типа ВСЕ файлы с исходниками
    //--- ЗАПУСК
    result:=EXECUTE_4TREE(tSrcTree_itmHandler_makeListFsFILE, @tmpPrcDATA);
end;

function tSrcTree_itmHandler4Build__f8a_usesFile._prc__execute_4FileItem_(const srcItem:tSrcTree_fsFILE):boolean;
begin
    writeLOG(srcItem.src_PATH);
    result:=true;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tSrcTree_itmHandler4Build__f8a_usesFile.Processing:boolean;
var srcItem:tSrcTree_fsFILE;
begin
    //result:=true;
    result:=_prc__make_InitFileList_;
    while result and (_fList_.Count>0) do begin
        // изымаем первый узел
        srcItem:=tSrcTree_fsFILE(_fList_.Items[0]);
       _fList_.Delete(0);
        // ОБРАБАТЫВАЕМ
        result:=_prc__execute_4FileItem_(srcItem);
    end;
end;

end.

