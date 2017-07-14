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
   function  _findNextIncludeDirective(var CodeBuffer:TCodeBuffer; var StartX,StartY:integer):boolean;
 protected
   procedure _Processing_Unit_ (const fileName:string);
   procedure _Processing_Units_(const List:TStrings);
 public
   function  Processing:boolean; override; // ВЫПОЛНИТЬ обработку
 end;

procedure _tF8A_files4INC_processFile_._Processing_Unit_(const fileName:string);
var fldr:_tSrcTree_item_fsNodeFLDR_;
    fTmp: tSrcTree_fsFILE;
begin
    {fldr:= SrcTree_fndAbsPATH(_root_, srcTree_fsFnk_ExtractFileDir(fileName));
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
    end; }
    writeLOG('AAAAAAAAAA - '+fileName);
end;

procedure _tF8A_files4INC_processFile_._Processing_Units_(const List:TStrings);
var i:integer;
begin
    if Assigned(List) then begin
        for i:=0 to List.Count-1 do begin
           _Processing_Unit_(List[i]);
        end;
    end;
end;


function  _tF8A_files4INC_processFile_._findNextIncludeDirective(var CodeBuffer:TCodeBuffer; var StartX,StartY:integer):boolean;
var lstX,lstY:integer;
    tstX,tstY:integer;
    new_Buffer:TCodeBuffer;
    NTL:integer;
begin
    result:=FALSE;
    //---
    lstX:=StartX;
    lstY:=StartY;
    while CodeToolBoss.FindIncludeDirective(CodeBuffer,lstX,lstY, new_Buffer,tstX,tstY, NTL) do begin
        if (StartX<>tstX)or(StartY<>tstY) then begin
            result:=TRUE;
            StartX:=tstX;
            StartY:=tstY;
        end
        else inc(lstX);
    end;
end;


function _tF8A_files4INC_processFile_.Processing:boolean;
var new_Buffer:TCodeBuffer;
    CodeBuffer:TCodeBuffer;
var FilenameStartPos, FileNameEndPos,
    CommentStart, CommentEnd: integer;
    ACleanPos: integer;
    s:string;
    StartX, StartY: integer;
    NewTopLine:integer;
    //---
    Found: TFindFileAtCursorFlag;
    FoundFilename: string;

    CodeContexts: TCodeContextInfo;

begin
    {$ifOpt D+}Assert(Assigned(prcssdITEM), self.ClassName+'.Processing : prcssdITEM=NIL');{$endIf}
    {$ifOpt D+}Assert(tObject(prcssdITEM) is tSrcTree_fsFILE, self.ClassName+'.Processing : tObject(prcssdITEM) is NOT tSrcTree_fsFILE');{$endIf}
    CodeBuffer:=_SrcTree_fsFILE__2__codeBUF_(tSrcTree_fsFILE(prcssdITEM));
    //---
    if (Assigned(CodeBuffer)) then begin
        StartX:=1;
        StartY:=1;


        // через зад надо наверно делать (((

//        while _findNextIncludeDirective(CodeBuffer,StartX,StartY) do begin
            _findNextIncludeDirective(CodeBuffer,StartX,StartY);
            //CodeToolBoss.FindFileAtCursor(CodeBuffer, StartX,StartY , Found,FoundFilename);//   Allowed: TFindFileAtCursorFlags = DefaultFindFileAtCursorAllowed;
            writeLOG('AAAAAAAAAA - '+' '+inttostr(StartX)+'-'+inttostr(StartY)+'-'{inttostr(NewTopLine)+' '+FoundFilename});
//        end;
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

