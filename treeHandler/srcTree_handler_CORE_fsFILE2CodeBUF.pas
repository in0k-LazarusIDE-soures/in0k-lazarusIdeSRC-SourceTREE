unit srcTree_handler_CORE_fsFile2CodeBUF;

{$mode objfpc}{$H+}

interface

uses
  LazIDEIntf, Dialogs,
  //---
  CodeCache,
  CodeToolManager,
  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  //---
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  //---
  srcTree_handler_CORE;

type

 tSrcTree_itmHandler_fsFile2CodeBUF=class(tSrcTree_itmHandler)
  protected
    function _SrcTree_fsFILE__2__codeBUF_(const srcItem:tSrcTree_fsFILE):TCodeBuffer;
  protected
    function _codeBUF_4EDIT_(const CodeBuff:TCodeBuffer; out CodeTool:TCodeTool):boolean;
    function _codeBUF_WRITE_(const CodeBuff:TCodeBuffer):boolean;
  protected
    function _CleanPos_in_CodeBuff_(const CodeBuffer:TCodeBuffer; const CleanPos:integer):boolean;
  public
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

implementation

function tSrcTree_itmHandler_fsFile2CodeBUF._SrcTree_fsFILE__2__codeBUF_(const srcItem:tSrcTree_fsFILE):TCodeBuffer;
var tmpFileName:string;
begin
    {$ifOpt D+}Assert(Assigned(srcItem), self.ClassName+'.Processing : srcItem=NIL');{$endIf}
    //--- из какого-то ХАУ ТУ с сайта
    // make sure the filename is trimmed and contains a full path
    tmpFileName:=srcTree_fsFnk_CleanAndExpandFilename(srcItem.fsPath);
    // save changes in source editor to codetools
    LazarusIDE.SaveSourceEditorChangesToCodeCache(nil);
    // load the file
    result:=CodeToolBoss.LoadFile(tmpFileName,false,false);
    {$ifOpt D+}
        if Assigned(result)
        then writeLOG('OPEN file "'+tmpFileName+'"')
        else writeLOG('fail open file "'+tmpFileName+'"');
    {$endIf}
end;

//------------------------------------------------------------------------------

function tSrcTree_itmHandler_fsFile2CodeBUF._codeBUF_4EDIT_(const CodeBuff:TCodeBuffer; out CodeTool:TCodeTool):boolean;
begin
    CodeToolBoss.Explore(CodeBuff,CodeTool,false);
    if NOT Assigned(CodeTool) then begin
        //doEvent_on_ERROR('CodeTool NOT received:"'+Node.Get_Target_fullName+'"');
    end;
    // Step 2: connect the SourceChangeCache
    CodeToolBoss.SourceChangeCache.MainScanner:=CodeTool.Scanner;
    CodeToolBoss.SourceChangeCache.BeginUpdate;
    //

end;

function tSrcTree_itmHandler_fsFile2CodeBUF._codeBUF_WRITE_(const CodeBuff:TCodeBuffer):boolean;
begin

    // Step 4: Apply the changes
    if not CodeToolBoss.SourceChangeCache.EndUpdate then begin
        //doEvent_on_ERROR('CodeToolBoss.SourceChangeCache.EndUpdate ERROR:"'+Node.Get_Target_fullName+'"');
    end;
    // Step 5: SAVE the changes
    if NOT CodeBuff.Save then begin
         //doEvent_on_ERROR('CodeBuff.Save ERROR:"'+Node.Get_Target_fullName+'" ER');
    end;


end;

//------------------------------------------------------------------------------

function tSrcTree_itmHandler_fsFile2CodeBUF.Processing:boolean;
begin
    {$ifOpt D+}Assert(Assigned(prcssdITEM), self.ClassName+'.Processing : prcssdITEM=NIL');{$endIf}
    {$ifOpt D+}Assert(tObject(prcssdITEM) is tSrcTree_fsFILE, self.ClassName+'.Processing : tObject(prcssdITEM) is NOT tSrcTree_fsFILE');{$endIf}
    result:=false;
    prcssdDATA:=_SrcTree_fsFILE__2__codeBUF_(tSrcTree_fsFILE(prcssdITEM));
    result:=true;
end;

//------------------------------------------------------------------------------

function tSrcTree_itmHandler_fsFile2CodeBUF._CleanPos_in_CodeBuff_(const CodeBuffer:TCodeBuffer; const CleanPos:integer):boolean;
begin
    with CodeBuffer do result:=(1<=CleanPos)and(CleanPos<=SourceLength) ;
end;

end.

