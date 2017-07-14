unit in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_usesFile;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  //---
  PackageIntf,
  //---
  CodeCache,
  CodeToolManager,
  //---
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND,
  in0k_lazIdeSRC_srcTree_FNK_absPATH_FND,
  in0k_lazIdeSRC_srcTree_FNK_nodeFILE_FND,
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

 tSrcTree_itmHandler4Build__f8a_usesFile_itemStep=class(tSrcTree_itmHandler_fsFile2CodeBUF)
  private
   _root_:tSrcTree_ROOT;
  protected
    procedure _Processing_Unit_ (const fileName:string);
    procedure _Processing_Units_(const List:TStrings);
  public
    function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
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
    result:=EXECUTE_4NODE(tSrcTree_itmHandler4Build__f8a_usesFile_itemStep, nil, srcItem);
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

//==============================================================================

procedure tSrcTree_itmHandler4Build__f8a_usesFile_itemStep._Processing_Unit_(const fileName:string);
var fldr:_tSrcTree_item_fsNodeFLDR_;
    fTmp: tSrcTree_fsFILE;
begin
    fldr:= SrcTree_fndAbsPATH(_root_, srcTree_fsFnk_ExtractFileDir(fileName));
    if Assigned(fldr) then begin
        fTmp:=SrcTree_fndNodeFILE(fldr,fileName);
        if not Assigned(fTmp) then begin
            writeLOG('YES - '+srcTree_fsFnk_ExtractFileName(fileName)+'-'+fileName);
        end
        else begin
            writeLOG('NOT need - '+fileName);
        end;
    end
    else begin
        writeLOG('no in SearhPATH - '+fileName);
    end;
end;

procedure tSrcTree_itmHandler4Build__f8a_usesFile_itemStep._Processing_Units_(const List:TStrings);
var i:integer;
begin
    if Assigned(List) then begin
        for i:=0 to List.Count-1 do begin
           _Processing_Unit_(List[i]);
        end;
    end;
end;

function tSrcTree_itmHandler4Build__f8a_usesFile_itemStep.Processing:boolean;
var CodeBuffer:TCodeBuffer;
var MainUsesSection,ImplementationUsesSection:TStrings;
begin
    {$ifOpt D+}Assert(Assigned(prcssdITEM), self.ClassName+'.Processing : prcssdITEM=NIL');{$endIf}
    {$ifOpt D+}Assert(tObject(prcssdITEM) is tSrcTree_fsFILE, self.ClassName+'.Processing : tObject(prcssdITEM) is NOT tSrcTree_fsFILE');{$endIf}
    CodeBuffer:=_SrcTree_fsFILE__2__codeBUF_(tSrcTree_fsFILE(prcssdITEM));
    //---
    MainUsesSection:=nil;
    ImplementationUsesSection:=nil;
    if (Assigned(CodeBuffer)) then begin
        if CodeToolBoss.FindUsedUnitFiles(CodeBuffer, MainUsesSection,ImplementationUsesSection) then begin
            _root_:=SrcTree_fndRootFILE(prcssdITEM);
            _Processing_Units_(MainUsesSection);
            _Processing_Units_(ImplementationUsesSection);
        end;
        MainUsesSection          .FREE;
        ImplementationUsesSection.FREE;
    end
    else begin
        writeLOG('CodeBuffer is NUL:'+'"'+tSrcTree_fsFILE(prcssdITEM).src_abs_PATH+'"');
    end;
    //---
    result:=true;
end;

end.

