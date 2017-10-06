unit in0k_lazIdeSRC_srcTree_FNK_PATH_FND_rel;

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

//function SrcTree_fndPathREL(const item: tSrcTree_ROOT;             const path:string):_tSrcTree_item_fsNodeFLDR_; overload;
//function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string):_tSrcTree_item_fsNodeFLDR_; overload;

//function SrcTree_fndPathREL(const item: tSrcTree_ROOT;             const path:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_; overload;
//function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_; overload;

function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string):_tSrcTree_item_fsNodeFLDR_; overload;
function SrcTree_fndPathREL(const item: tSrcTree_ROOT;             const path:string):_tSrcTree_item_fsNodeFLDR_; overload;

implementation

(*function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string):_tSrcTree_item_fsNodeFLDR_;
var lstDir:_tSrcTree_item_fsNodeFLDR_;
    mdlDir:string;
begin
    result:=SrcTree_fndPathREL(item,path,lstDir,mdlDir);
end;*)


function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string):_tSrcTree_item_fsNodeFLDR_;
var str:string;
    tmp:tSrcTree_item;
begin {todo: уйти от РЕКУРСИИ?}
    {$ifdef _debug_}DEBUG('SrcTreeROOT_fnd_relPATH',path);{$endIf}
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    {$ifOpt D+}Assert(not srcTree_fsFnk_endsWithDirectorySeparator(path),'`path` ends with `DirectorySeparator`'); {$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsRelative(path));{$endIf}
    if path='' then result:=item // достигли КОРНЯ
    else begin
        // пытаемся найти родителя
        result:=SrcTree_fndPathREL(item,srcTree_fsFnk_ExtractFileDir(path));
        if Assigned(result) then begin
            // ищем СВОЕ имя среди его детей
            str   :=srcTree_fsFnk_ExtractFileName(path); //< имя, которое мы исчем
            tmp   :=result.ItemCHLD;
            result:=nil;
            while Assigned(tmp) do begin
                if (tmp is _tSrcTree_item_fsNodeFLDR_) and
                   (0=srcTree_fsFnk_CompareFilenames(str,_tSrcTree_item_fsNodeFLDR_(tmp).fsName))
                then begin
                    result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                    BREAK;
                end;
                tmp:=tmp.ItemNEXT;
            end;
        end;
    end;
end;

function SrcTree_fndPathREL(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}Assert(Assigned(SrcTree_fndBaseDIR(item)),'BaseDIR NOT found');{$endIf}
    result:=SrcTree_fndPathREL(SrcTree_fndBaseDIR(item),path);
end;

(*

// поиск ОТНОСИТЕЛЬНОГО пути
// @prm item   "корневая" папка, относительно которой ищем
// @prm path   "относительный путь", который исчем
// @prm lstDir "последняя" посещенная папка
// @prm mdlDir "оставшяйся путь" относительно lstDir
function SrcTree_fndPathREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_;
var fldr:string;
    tmp :tSrcTree_item;
begin
    {$ifdef _debug_}DEBUG('SrcTreeROOT_fnd_relPATH',path);{$endIf}
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    {$ifOpt D+}Assert(not srcTree_fsFnk_endsWithDirectorySeparator(path),'`path` ends with `DirectorySeparator`'); {$endIf}
    {$ifOpt D+}Assert(srcTree_fsFnk_FilenameIsRelative(path));{$endIf}
    result:=nil;
    lstDir:=nil;
    mdlDir:='';
    //---
    if (path='') then begin
        result:=item; // берем как КОРЕНЬ
        {$ifOpt D+}Assert(Assigned(result),'BaseDIR NOT found');{$endIf}
    end
    else begin
        // исчем РОДИТЕЛЬСКИЙ путь
        fldr:=srcTree_fsFnk_ExtractFileDir(path); //< это родительская директория    //if NOT ( (fld='')or(0=CompareFilenames(fld,prnt.DirPATH)) )
        if (fldr='') or ( srcTree_fsFnk_CompareFilenames(path,fldr)=0 ) then begin
            result:=item; // берем как КОРЕНЬ
            {$ifOpt D+}Assert(Assigned(result),'BaseDIR NOT found');{$endIf}
        end
        else result:=SrcTree_fndPathREL(item,fldr,lstDir,mdlDir); //< исчем ГЛУБЖЕ, ближе к корню
        //
        if Assigned(result) then begin // НАШЕЛСЯ прямой родитель
            lstDir:=result;
            result:=nil;
            fldr  :=srcTree_fsFnk_ExtractFileName(path);
            //--- ищем ПРЯМОЕ попадание
            tmp :=lstDir.ItemCHLD;
            while Assigned(tmp) do begin
                if (tmp is _tSrcTree_item_fsNodeFLDR_) and //< проверяем ТОКА папки
                   (srcTree_fsFnk_CompareFilenames(fldr,_tSrcTree_item_fsNodeFLDR_(tmp).fsName)=0)
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
            tmp :=lstDir.ItemCHLD;
            while Assigned(tmp) do begin
                if tmp is _tSrcTree_item_fsNodeFLDR_ then begin //< проверяем ТОКА папки
                    if (srcTree_fsFnk_CompareFilenames(path,_tSrcTree_item_fsNodeFLDR_(tmp).fsName)=0) or
                       (srcTree_fsFnk_CompareFilenames(path,_tSrcTree_item_fsNodeFLDR_(tmp).fsPath)=0)
                    then begin // нашли полное соответствие по имени или пути
                        result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                        mdlDir:='';
                        BREAK;
                    end
                    else begin
                        if srcTree_fsFnk_FileIsInPath(_tSrcTree_item_fsNodeFLDR_(tmp).fsPath,path)
                        then begin // нашли ВХОЖДЕНИЕ попадание в папку
                            mdlDir:=path;
                            BREAK;
                        end
                       else
                        if srcTree_fsFnk_FileIsInPath(path,_tSrcTree_item_fsNodeFLDR_(tmp).fsPath)
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

function SrcTree_fndPathREL(const item:tSrcTree_ROOT; const path:string):_tSrcTree_item_fsNodeFLDR_;
var base:tSrcTree_BASE;
begin
    base:=SrcTree_fndBaseDIR(item);
    {$ifOpt D+}Assert(Assigned(base),'BaseDIR NOT found');{$endIf}
    result:=SrcTree_fndPathREL(base,path);
end;

function SrcTree_fndPathREL(const item:tSrcTree_ROOT; const path:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_;
var base:tSrcTree_BASE;
begin
    base:=SrcTree_fndBaseDIR(item);
    {$ifOpt D+}Assert(Assigned(base),'BaseDIR NOT found');{$endIf}
    result:=SrcTree_fndPathREL(base,path, lstDir,mdlDir);
end;

*)

end.

