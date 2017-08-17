unit in0k_lazIdeSRC_srcTree_FNK_PATH_rel_FND;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,

  //---
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND;

function SrcTree_fndPathREL(const item: tSrcTree_ROOT;             const folder:string):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const folder:string):_tSrcTree_item_fsNodeFLDR_; overload;

function SrcTree_fndPathREL(const item: tSrcTree_ROOT;             const folder:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const folder:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_; overload;

implementation

function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const folder:string):_tSrcTree_item_fsNodeFLDR_;
var lstDir:_tSrcTree_item_fsNodeFLDR_;
    mdlDir:string;
begin
    result:=SrcTree_fndPathREL(item,folder,lstDir,mdlDir);
end;

function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const folder:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_;
var fldr:string;
    tmp :tSrcTree_item;
begin
    {$ifdef _debug_}DEBUG('SrcTreeROOT_fnd_relPATH',folder);{$endIf}
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsRelative(folder));{$endIf}
    result:=nil;
    lstDir:=nil;
    mdlDir:='';
    //---
    fldr:=srcTree_fsFnk_ChompPathDelim(folder); //< ???
    if (fldr='') then begin
        result:=SrcTree_fndBaseDIR(item);
        {$ifOpt D+}Assert(Assigned(result),'BaseDIR NOT found');{$endIf}
    end
    else begin
        // исчем РОДИТЕЛЬСКИЙ путь
        fldr:=srcTree_fsFnk_ExtractFileDir(fldr); //< это родительская директория    //if NOT ( (fld='')or(0=CompareFilenames(fld,prnt.DirPATH)) )
        if (fldr='') or ( srcTree_fsFnk_CompareFilenames(folder,fldr)=0 ) then begin
            result:=SrcTree_fndBaseDIR(item);
            {$ifOpt D+}Assert(Assigned(result),'BaseDIR NOT found');{$endIf}
        end
        else result:=SrcTree_fndPathREL(item,fldr,lstDir,mdlDir); //< исчем ГЛУБЖЕ, ближе к корню
        //
        if Assigned(result) then begin // НАШЕЛСЯ прямой родитель
            lstDir:=result;
            result:=nil;
            fldr  :=srcTree_fsFnk_ExtractFileName( srcTree_fsFnk_ChompPathDelim(folder) );
            //--- ищем ПРЯМОЕ попадание
            tmp :=lstDir.ItemCHLD;
            while Assigned(tmp) do begin
                if (tmp is _tSrcTree_item_fsNodeFLDR_) and //< проверяем ТОКА папки
                   (srcTree_fsFnk_CompareFilenames(fldr,_tSrcTree_item_fsNodeFLDR_(tmp).src_Name)=0)
                then begin
                    // надо-же ... нашли ПРЯМОЕ попадание в папку !!!
                    result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                    mdlDir:='';
                    BREAK;
                end;
                //-->
                tmp:=tmp.ItemNEXT;
            end;
        end;
        //--- ищем просто ВХОЖДЕНИЕ
        if not Assigned(result) then begin
            fldr:=srcTree_fsFnk_ChompPathDelim(folder);
            tmp :=lstDir.ItemCHLD;
            while Assigned(tmp) do begin
                if tmp is _tSrcTree_item_fsNodeFLDR_ then begin //< проверяем ТОКА папки
                    if (srcTree_fsFnk_CompareFilenames(fldr,_tSrcTree_item_fsNodeFLDR_(tmp).src_Name)=0) or
                       (srcTree_fsFnk_CompareFilenames(fldr,_tSrcTree_item_fsNodeFLDR_(tmp).src_PATH)=0)
                    then begin // нашли полное соответствие по имени или пути
                        result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                        mdlDir:='';
                        BREAK;
                    end
                    else begin
                        if srcTree_fsFnk_FileIsInPath(_tSrcTree_item_fsNodeFLDR_(tmp).src_PATH,fldr)
                        then begin // нашли ВХОЖДЕНИЕ попадание в папку
                            mdlDir:=fldr;
                            BREAK;
                        end
                       else
                        if srcTree_fsFnk_FileIsInPath(fldr,_tSrcTree_item_fsNodeFLDR_(tmp).src_PATH)
                        then begin // нашли ВХОЖДЕНИЕ попадание в папку
                            lstDir:=_tSrcTree_item_fsNodeFLDR_(tmp);
                            mdlDir:='';
                            BREAK;
                        end;
                    end;
                end;
                //-->
                tmp:=tmp.ItemNEXT;
            end;
        end;
    end;
    {$ifOpt D+}Assert( Assigned(result) or ((not Assigned(result)) and Assigned(lstDir)),'Wrong result');{$endIf}
    {$ifdef _debug_}DEBUG('SrcTreeROOT_fnd_relPATH','out'+'"'+mdlDir+'"');{$endIf}
end;

//------------------------------------------------------------------------------

function SrcTree_fndPathREL(const item:tSrcTree_ROOT; const folder:string):_tSrcTree_item_fsNodeFLDR_;
var base:tSrcTree_BASE;
begin
    base:=SrcTree_fndBaseDIR(item);
    {$ifOpt D+}Assert(Assigned(base),'BaseDIR NOT found');{$endIf}
    result:=SrcTree_fndPathREL(base,folder);
end;

function SrcTree_fndPathREL(const item:tSrcTree_ROOT; const folder:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_;
var base:tSrcTree_BASE;
begin
    base:=SrcTree_fndBaseDIR(item);
    {$ifOpt D+}Assert(Assigned(base),'BaseDIR NOT found');{$endIf}
    result:=SrcTree_fndPathREL(base,folder, lstDir,mdlDir);
end;



end.

