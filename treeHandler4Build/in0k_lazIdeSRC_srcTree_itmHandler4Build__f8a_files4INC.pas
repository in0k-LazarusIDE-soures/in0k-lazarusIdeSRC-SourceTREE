unit in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_files4INC;

interface

uses
  Classes,   sysutils,  IdentCompletionTool,
  //---
  PackageIntf,
  //---
  CodeCache,
  CodeToolManager,
  FindDeclarationTool,
  BasicCodeTools,
  //---
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND,
  in0k_lazIdeSRC_srcTree_FNK_absPATH_FND,
  in0k_lazIdeSRC_srcTree_FNK_nodeFILE_FND,
  in0k_lazIdeSRC_srcTree_FNK_absFILE_FND,
  //---
  srcTree_handler_CORE,
  srcTree_handler_CORE_makeLIST,
  srcTree_handler_CORE_makeListFsFILE,
  srcTree_handler_CORE_fsFile2CodeBUF;

type

 tSrcTree_itmHandler4Build__f8a_files4INC=class(tSrcTree_itmHandler)
  protected
   _fList_:tList; // список файлов которые ЕЩЁ надо обработать
  protected
    function _prc__make_InitFileList_:boolean;
    function _prc__execute_4FileItem_(const srcItem:tSrcTree_fsFILE):boolean;
  public
    function Processing:boolean; override;
  end;




implementation

type
_tF8A_files4INC_processFile_=class(tSrcTree_itmHandler_fsFile2CodeBUF)
 private
  _root_:tSrcTree_ROOT;
 protected
   function  _find_incDirective_(const CodeBuffer:TCodeBuffer; const fromPos:integer; out findPos,nextFromPos:integer):boolean;
   function  _find_incFileName_ (const CodeBuffer:TCodeBuffer; const findPos:integer; out foundFilename:string):boolean;
 protected
   procedure _Processing_Unit_ (const fileName:string);
 public
   function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
 end;

//------------------------------------------------------------------------------

procedure _tF8A_files4INC_processFile_._Processing_Unit_(const fileName:string);
var fTmp: tSrcTree_fsFILE;
begin
    fTmp:=SrcTree_fndAbsFILE(_root_,fileName);
    if not Assigned(fTmp) then begin
            writeLOG('YESYESYESYESYESYESYESYESYESYESYESYESYESYESYESYESYESYESYES - '+srcTree_fsFnk_ExtractFileName(fileName)+'-'+fileName);
    end
    else begin
        writeLOG('NOT need - '+fileName);
    end
end;

//------------------------------------------------------------------------------

function _tF8A_files4INC_processFile_._find_IncDirective_(const CodeBuffer:TCodeBuffer; const fromPos:integer; out findPos,nextFromPos:integer):boolean;
var newPos     :integer;
    fEPos,cSPos:integer;
begin
    newPos:=FindNextIncludeDirective(CodeBuffer.Source, fromPos, false, findPos,fEPos,cSPos,nextFromPos);
    result:=newPos<CodeBuffer.SourceLength;
    nextFromPos:=nextFromPos+1;
    {$ifOpt D+}
    if result
    then writeLOG('_find_IncDirective_ - '+inttostr(fromPos)+'->'+inttostr(newPos)+' Filename['+inttostr(findPos)+':'+inttostr(fEPos)+']'+' Comment['+inttostr(cSPos)+':'+inttostr(nextFromPos)+']')
    else writeLOG('_find_IncDirective_ - '+inttostr(fromPos)+'->xxx NotFound');
    {$endIf}
end;

function _tF8A_files4INC_processFile_. _find_incFileName_ (const CodeBuffer:TCodeBuffer; const findPos:integer; out foundFilename:string):boolean;
var StartX,StartY:integer;
    Found:TFindFileAtCursorFlag;
begin
    CodeBuffer.AbsoluteToLineCol(findPos,StartY,StartX);
    result:=CodeToolBoss.FindFileAtCursor(CodeBuffer, StartX,StartY , Found,FoundFilename);
    result:=result and (Found=ffatIncludeFile);
    {$ifOpt D+}
    if result
    then writeLOG('_find_incFileName_ - '+inttostr(findPos)+'->['+inttostr(StartY)+':'+inttostr(StartX)+']'+' '+'"'+FoundFilename+'"')
    else writeLOG('_find_incFileName_ - '+inttostr(findPos)+'->['+inttostr(StartY)+':'+inttostr(StartX)+']'+' '+'NotFound');
    {$endIf}
end;

//------------------------------------------------------------------------------

function _tF8A_files4INC_processFile_.Processing:boolean;
var CodeBuffer:TCodeBuffer;
var CleanPos,nextFindPos:integer;
    FoundFilename: string;
begin
    {$ifOpt D+}Assert(Assigned(prcssdITEM), self.ClassName+'.Processing : prcssdITEM=NIL');{$endIf}
    {$ifOpt D+}Assert(tObject(prcssdITEM) is tSrcTree_fsFILE, self.ClassName+'.Processing : tObject(prcssdITEM) is NOT tSrcTree_fsFILE');{$endIf}
    CodeBuffer:=_SrcTree_fsFILE__2__codeBUF_(tSrcTree_fsFILE(prcssdITEM));
    //---
    if (Assigned(CodeBuffer)) then begin
       _root_:=SrcTree_fndRootFILE(prcssdITEM);
        //
        CleanPos:=0;
        while (CleanPos<CodeBuffer.SourceLength) do begin
            if _find_IncDirective_(CodeBuffer,CleanPos,CleanPos,nextFindPos) then begin
                if _find_incFileName_(CodeBuffer,CleanPos,FoundFilename) then begin
                    _Processing_Unit_(FoundFilename);
				end;
			end
            else BREAK;
            CleanPos:=nextFindPos;
		end;
	end
    else begin
        writeLOG('CodeBuffer is NUL:'+'"'+tSrcTree_fsFILE(prcssdITEM).src_abs_PATH+'"');
    end;
    //---
    result:=true;
end;

//==============================================================================

// составление ПЕРВИЧНОГО списка файлов ..
function tSrcTree_itmHandler4Build__f8a_files4INC._prc__make_InitFileList_:boolean;
var tmpPrcDATA:rSrcTree_itmHandler_makeListFsFILE_prcDATA;
begin
   _fList_:=TList.Create;
    //---
    tmpPrcDATA.File_LIST:=_fList_;
    tmpPrcDATA.FileTypes:= PkgFileRealUnitTypes; //< типа ВСЕ файлы с исходниками
    //--- ЗАПУСК
    result:=EXECUTE_4TREE(tSrcTree_itmHandler_makeListFsFILE, @tmpPrcDATA);
end;

function tSrcTree_itmHandler4Build__f8a_files4INC._prc__execute_4FileItem_(const srcItem:tSrcTree_fsFILE):boolean;
begin
    result:=EXECUTE_4NODE(_tF8A_files4INC_processFile_, nil, srcItem);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tSrcTree_itmHandler4Build__f8a_files4INC.Processing:boolean;
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

